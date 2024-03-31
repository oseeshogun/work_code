package com.oseemasuaku.codedutravail.data.daos

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.oseemasuaku.codedutravail.data.entities.Section
import kotlinx.coroutines.flow.Flow

@Dao
interface SectionDao {
    @Insert
    suspend fun insertAll(vararg sections: Section)

    @Query("SELECT * FROM sections")
    fun streamAll(): Flow<List<Section>>

    @Query("SELECT * FROM sections WHERE chapter = :chapter")
    fun streamByChapter(chapter: Int): Flow<List<Section>>
}