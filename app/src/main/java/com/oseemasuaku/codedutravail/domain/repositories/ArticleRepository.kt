package com.oseemasuaku.codedutravail.domain.repositories

import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import kotlinx.coroutines.flow.Flow

interface ArticleRepository {

    suspend fun insertAll(articles: List<ArticleData>)

    fun streamArticleById(id: Int): Flow<ArticleData>

    fun streamArticles(ids: List<Int>): Flow<List<ArticleData>>

    fun search(query: String): Flow<List<ArticleData>>

    suspend fun getArticleById(id: Int): ArticleData
}