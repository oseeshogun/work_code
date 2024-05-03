package com.oseemasuaku.codedutravail.presentation.screens.article

import androidx.lifecycle.ViewModel
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

@HiltViewModel
class ArticleViewModel @Inject constructor(
    private val articleRepository: ArticleRepository
): ViewModel() {

    fun getArticle(id: Int): Flow<ArticleData> {
        return articleRepository.streamArticleById(id)
    }
}