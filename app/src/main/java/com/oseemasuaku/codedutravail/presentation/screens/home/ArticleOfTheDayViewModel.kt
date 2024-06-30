package com.oseemasuaku.codedutravail.presentation.screens.home

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.domain.errors.Result
import com.oseemasuaku.codedutravail.domain.usecases.NoMoreArticleTodayUseCase
import com.oseemasuaku.codedutravail.domain.usecases.RandomArticleOfTheDayUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class ArticleOfTheDayViewModel @Inject constructor(
    private val randomArticleOfTheDayUseCase: RandomArticleOfTheDayUseCase,
    private val noMoreArticleTodayUseCase: NoMoreArticleTodayUseCase
) : ViewModel() {
    var articleOfTheDay by mutableStateOf<ArticleData?>(null)
        private set

    init {
        viewModelScope.launch {
            setArticleOfTheDay()
        }
    }

    private suspend fun setArticleOfTheDay() {
        randomArticleOfTheDayUseCase().let {
            articleOfTheDay = when (it) {
                is Result.Error -> null
                is Result.Success -> it.data
            }
        }
    }

    fun removeForToday() {
        articleOfTheDay = null
        noMoreArticleTodayUseCase()
    }
}