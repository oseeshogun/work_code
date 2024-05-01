package com.oseemasuaku.codedutravail.data.repositories

import com.oseemasuaku.codedutravail.data.daos.TitleDao
import com.oseemasuaku.codedutravail.data.entities.Title
import com.oseemasuaku.codedutravail.domain.entities.TitleData
import com.oseemasuaku.codedutravail.domain.repositories.TitleRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class TitleRepositoryImpl(
    private val titleDao: TitleDao,
) : TitleRepository {
    override suspend fun insertAll(vararg titles: TitleData) {
        val dbTitles: List<Title> = titles.map {
            Title(
                number = it.number,
                text = it.text,
                articles = it.articles
            )
        }
        titleDao.insertAll(*dbTitles.toTypedArray())
    }

    override fun streamAll(): Flow<List<TitleData>> {
        return titleDao.streamAll().map { data ->
            data.map {
                TitleData(it.number, it.text, it.articles)
            }
        }
    }

}