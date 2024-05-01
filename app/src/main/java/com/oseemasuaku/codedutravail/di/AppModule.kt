package com.oseemasuaku.codedutravail.di

import android.app.Application
import androidx.room.Room
import com.oseemasuaku.codedutravail.data.CodeDatabase
import com.oseemasuaku.codedutravail.data.repositories.ArticleRepositoryImpl
import com.oseemasuaku.codedutravail.data.repositories.ChapterRepositoryImpl
import com.oseemasuaku.codedutravail.data.repositories.SectionRepositoryImpl
import com.oseemasuaku.codedutravail.data.repositories.TitleRepositoryImpl
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import com.oseemasuaku.codedutravail.domain.repositories.ChapterRepository
import com.oseemasuaku.codedutravail.domain.repositories.SectionRepository
import com.oseemasuaku.codedutravail.domain.repositories.TitleRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
class AppModule {

    @Provides
    @Singleton
    fun provideDatabase(app: Application): CodeDatabase {
        return Room.databaseBuilder(app, CodeDatabase::class.java, CodeDatabase.DATABASE_NAME)
            .build()
    }

    @Provides
    @Singleton
    fun provideArticleRepository(db: CodeDatabase): ArticleRepository {
        return ArticleRepositoryImpl(db.articleDao)
    }

    @Provides
    @Singleton
    fun provideTitleRepository(db: CodeDatabase): TitleRepository {
        return TitleRepositoryImpl(db.titleDao)
    }

    @Provides
    @Singleton
    fun provideChapterRepository(db: CodeDatabase): ChapterRepository {
        return ChapterRepositoryImpl(db.chapterDao)
    }

    @Provides
    @Singleton
    fun provideSectionRepository(db: CodeDatabase): SectionRepository {
        return SectionRepositoryImpl(db.sectionDao)
    }
}