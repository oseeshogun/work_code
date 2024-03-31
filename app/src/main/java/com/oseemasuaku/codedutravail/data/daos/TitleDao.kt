package com.oseemasuaku.codedutravail.data.daos

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.oseemasuaku.codedutravail.data.entities.Title
import kotlinx.coroutines.flow.Flow

@Dao
interface TitleDao {

    @Insert
    suspend fun insertAll(vararg titles: Title)

    @Query("SELECT * FROM titles")
    fun streamAll(): Flow<List<Title>>
}