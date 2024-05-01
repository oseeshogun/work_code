package com.oseemasuaku.codedutravail.data.repositories

import com.oseemasuaku.codedutravail.data.daos.SectionDao
import com.oseemasuaku.codedutravail.data.entities.Section
import com.oseemasuaku.codedutravail.domain.entities.SectionData
import com.oseemasuaku.codedutravail.domain.repositories.SectionRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class SectionRepositoryImpl(
    private val sectionDao: SectionDao
): SectionRepository {
    override suspend fun insertAll(vararg sections: SectionData) {
        val dbSections: List<Section> = sections.map {
            Section(number = it.number, text =  it.text, chapter = it.chapterNumber, title = it.titleNumber, articles = it.articles)
        }
        sectionDao.insertAll(*dbSections.toTypedArray())
    }

    override fun streamByChapter(chapterId: Int): Flow<List<SectionData>> {
        return sectionDao.streamByChapter(chapterId).map { data ->
            data.map {
                SectionData(it.number, it.text, it.chapter, it.title, it.articles)
            }
        }
    }
}