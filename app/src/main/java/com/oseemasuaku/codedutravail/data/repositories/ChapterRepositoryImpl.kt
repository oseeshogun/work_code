package com.oseemasuaku.codedutravail.data.repositories

import com.oseemasuaku.codedutravail.data.daos.ChapterDao
import com.oseemasuaku.codedutravail.data.entities.Chapter
import com.oseemasuaku.codedutravail.domain.entities.ChapterData
import com.oseemasuaku.codedutravail.domain.repositories.ChapterRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class ChapterRepositoryImpl(
    private val chapterDao: ChapterDao
): ChapterRepository {
    override suspend fun insertAll(vararg chapters: ChapterData) {
        val dbChapters = chapters.map {
            Chapter(number = it.number, text = it.text, title =  it.titleNumber, articles = it.articles)
        }
        chapterDao.insertAll(*dbChapters.toTypedArray())
    }

    override fun streamByTitle(titleId: Int): Flow<List<ChapterData>> {
        return chapterDao.streamByTitle(titleId).map { data ->
            data.map {
                ChapterData(it.number, it.text, it.title, it.articles)
            }
        }
    }
}