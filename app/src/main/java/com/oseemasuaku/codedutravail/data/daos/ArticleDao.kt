package com.oseemasuaku.codedutravail.data.daos

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.oseemasuaku.codedutravail.data.entities.Article
import kotlinx.coroutines.flow.Flow

@Dao
interface ArticleDao {
    @Insert
    suspend fun insertAll(vararg articles: Article)

    @Query("SELECT * FROM articles")
    fun streamAll(): Flow<List<Article>>

    @Query("SELECT * FROM articles WHERE number IN (:ids)")
    fun streamArticles(ids: List<Int>): Flow<List<Article>>
}