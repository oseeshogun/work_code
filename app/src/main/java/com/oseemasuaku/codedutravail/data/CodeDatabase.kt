package com.oseemasuaku.codedutravail.data

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.oseemasuaku.codedutravail.data.converters.ListConverter
import com.oseemasuaku.codedutravail.data.daos.ArticleDao
import com.oseemasuaku.codedutravail.data.daos.ChapterDao
import com.oseemasuaku.codedutravail.data.daos.SectionDao
import com.oseemasuaku.codedutravail.data.daos.TitleDao
import com.oseemasuaku.codedutravail.data.entities.Article
import com.oseemasuaku.codedutravail.data.entities.Chapter
import com.oseemasuaku.codedutravail.data.entities.Section
import com.oseemasuaku.codedutravail.data.entities.Title

@Database(
    entities = [Article::class, Title::class, Chapter::class, Section::class],
    version = 1
)
@TypeConverters(ListConverter::class)
abstract class CodeDatabase: RoomDatabase() {

    abstract val articleDao: ArticleDao
    abstract val titleDao: TitleDao
    abstract val chapterDao: ChapterDao
    abstract val sectionDao: SectionDao

    companion object {
        const val DATABASE_NAME = "code_database"
    }
}