package com.oseemasuaku.codedutravail.presentation.screens.search

import androidx.lifecycle.ViewModel
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.flatMapLatest
import javax.inject.Inject

@HiltViewModel
class ArticleSearchViewModel @Inject constructor(
    private val articleRepository: ArticleRepository,
) : ViewModel() {

    var query = MutableStateFlow("")
        private set

    @OptIn(ExperimentalCoroutinesApi::class)
    val articles = query.flatMapLatest {
        if (it.isNumeric()) {
            articleRepository.streamArticles(listOf(it.toInt()))
        } else if (it.split(",").size > 1 && it.split(",")
                .all { value -> value.trim().isNumeric() }
        ) {
            articleRepository.streamArticles(it.split(",").map { value -> value.trim().toInt() })
        } else {
            articleRepository.search(it)
        }
    }

    fun search(value: String) {
        query.value = value
    }

}

fun String.isNumeric(): Boolean {
    val regex = "-?[0-9]+(\\.[0-9]+)?".toRegex()
    return this.matches(regex)
}