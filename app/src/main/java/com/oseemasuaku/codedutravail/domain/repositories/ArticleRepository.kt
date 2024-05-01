package com.oseemasuaku.codedutravail.domain.repositories

import com.oseemasuaku.codedutravail.domain.entities.ArticleData

interface ArticleRepository {

    suspend fun insertAll(articles: List<ArticleData>)

}