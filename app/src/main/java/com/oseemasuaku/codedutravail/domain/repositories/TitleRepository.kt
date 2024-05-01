package com.oseemasuaku.codedutravail.domain.repositories

import com.oseemasuaku.codedutravail.domain.entities.TitleData
import kotlinx.coroutines.flow.Flow

interface TitleRepository {

    suspend fun  insertAll(vararg titles: TitleData)

    fun streamAll(): Flow<List<TitleData>>
}