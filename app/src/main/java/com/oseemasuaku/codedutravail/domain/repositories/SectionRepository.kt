package com.oseemasuaku.codedutravail.domain.repositories

import com.oseemasuaku.codedutravail.domain.entities.SectionData
import kotlinx.coroutines.flow.Flow

interface SectionRepository {

    suspend fun insertAll(vararg sections: SectionData)

    fun streamByChapter(chapterId: Int): Flow<List<SectionData>>
}