package com.oseemasuaku.codedutravail.domain.repositories

import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import kotlinx.coroutines.flow.Flow

interface ArticleRepository {

    suspend fun insertAll(articles: List<ArticleData>)

    fun streamArticles(ids: List<Int>): Flow<List<ArticleData>>
}