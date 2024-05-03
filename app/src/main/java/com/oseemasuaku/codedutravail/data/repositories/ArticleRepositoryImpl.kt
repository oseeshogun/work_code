package com.oseemasuaku.codedutravail.data.repositories

import com.oseemasuaku.codedutravail.data.daos.ArticleDao
import com.oseemasuaku.codedutravail.data.entities.Article
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class ArticleRepositoryImpl(
    private val articleDao: ArticleDao,
) : ArticleRepository {
    override suspend fun insertAll(articles: List<ArticleData>) {
        val dbArticles: List<Article> = articles.map {
            Article(number = it.number, text = it.text)
        }

        articleDao.insertAll(*dbArticles.toTypedArray())
    }

    override fun streamArticles(ids: List<Int>): Flow<List<ArticleData>> {
        return articleDao.streamArticles(ids).map {
            it.map { article ->
                ArticleData(number = article.number, text = article.text)
            }
        }
    }

}