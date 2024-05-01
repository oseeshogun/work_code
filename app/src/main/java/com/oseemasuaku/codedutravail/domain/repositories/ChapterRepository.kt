package com.oseemasuaku.codedutravail.domain.repositories

import com.oseemasuaku.codedutravail.domain.entities.ChapterData
import kotlinx.coroutines.flow.Flow

interface ChapterRepository {

    suspend fun insertAll(vararg chapters: ChapterData)

    fun streamByTitle(titleId: Int): Flow<List<ChapterData>>
}