package com.oseemasuaku.codedutravail.data.daos

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.oseemasuaku.codedutravail.data.entities.Chapter
import kotlinx.coroutines.flow.Flow

@Dao
interface ChapterDao {
    @Insert
    suspend fun insertAll(vararg chapters: Chapter)

    @Query("SELECT * FROM chapters")
    fun streamAll(): Flow<List<Chapter>>

    @Query("SELECT * FROM chapters WHERE title = :title")
    fun streamByTitle(title: Int): Flow<List<Chapter>>
}