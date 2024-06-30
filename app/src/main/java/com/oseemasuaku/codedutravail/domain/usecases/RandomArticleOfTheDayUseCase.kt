package com.oseemasuaku.codedutravail.domain.usecases

import com.oseemasuaku.codedutravail.data.PreferencesManager
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.domain.errors.RandomArticleOfTheDayError
import com.oseemasuaku.codedutravail.domain.errors.Result
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import org.threeten.bp.LocalDate
import javax.inject.Inject
import kotlin.random.Random

class RandomArticleOfTheDayUseCase @Inject constructor(
    private val articleRepository: ArticleRepository,
    private val preferencesManager: PreferencesManager,
) {
    suspend operator fun invoke(): Result<ArticleData, RandomArticleOfTheDayError> {
        val today = LocalDate.now().toString()

        val noMoreToday = preferencesManager.getBoolean("no_more_$today", false)

        if (noMoreToday) {
            return Result.Error(RandomArticleOfTheDayError.NO_MORE_TODAY)
        }

        val savedNumber: Int = preferencesManager.getInt(today, -1)

        val number = if (savedNumber == -1) {
            Random.nextInt(1, 334)
        } else {
            savedNumber
        }

        if (savedNumber == -1) preferencesManager.saveInt(today, number)

        return try {
            articleRepository.getArticleById(number).let {
                Result.Success(it)
            }
        } catch (e: Exception) {
            Result.Error(RandomArticleOfTheDayError.ERROR_IN_DB)
        }

    }
}