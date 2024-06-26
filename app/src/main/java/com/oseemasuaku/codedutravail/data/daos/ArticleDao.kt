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

    @Query("SELECT * FROM articles WHERE number = :number")
    fun steamById(number: Int): Flow<Article>

    @Query("SELECT * FROM articles WHERE number = :number")
    suspend fun getById(number: Int): Article

    @Query("SELECT * FROM articles WHERE number IN (:ids)")
    fun streamArticles(ids: List<Int>): Flow<List<Article>>

    @Query("SELECT * FROM articles WHERE text LIKE '%' || :query || '%' LIMIT 30")
    fun search(query: String): Flow<List<Article>>
}