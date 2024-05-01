package com.oseemasuaku.codedutravail.domain.usecases

import android.content.res.AssetManager
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.domain.entities.ChapterData
import com.oseemasuaku.codedutravail.domain.entities.SectionData
import com.oseemasuaku.codedutravail.domain.entities.TitleData
import com.oseemasuaku.codedutravail.domain.errors.Result
import com.oseemasuaku.codedutravail.domain.errors.SaveOfflineError
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import com.oseemasuaku.codedutravail.domain.repositories.ChapterRepository
import com.oseemasuaku.codedutravail.domain.repositories.SectionRepository
import com.oseemasuaku.codedutravail.domain.repositories.TitleRepository
import org.yaml.snakeyaml.Yaml
import javax.inject.Inject

class RegisterDataOnOfflineUseCase @Inject constructor(
    private val articleRepository: ArticleRepository,
    private val titleRepository: TitleRepository,
    private val chapterRepository: ChapterRepository,
    private val sectionRepository: SectionRepository,
) {

    @Suppress("UNCHECKED_CAST")
    suspend operator fun invoke(assets: AssetManager): Result<Unit, SaveOfflineError> {
        val parser = Yaml()

        // Get Yaml String
        val content: String = try {
            assets.open("work_code.yaml").bufferedReader().use {
                it.readText()
            }
        } catch (e: Exception) {
            return Result.Error(SaveOfflineError.DID_NOT_LOAD_ASSET)
        }
        // Convert Yaml Text to Json
        val result = try {
            parser.load<Map<String, Any>>(content)
        } catch (e: Exception) {
            return Result.Error(SaveOfflineError.DID_NOT_LOAD_ASSET)
        }

        val rawArticles = result["articles"] as List<*>
        val rawTitles = result["titles"] as List<*>
        // Transform to Entities
        val titles = mutableListOf<TitleData>()
        val chapters = mutableListOf<ChapterData>()
        val sections = mutableListOf<SectionData>()
        val articles = mutableListOf<ArticleData>()

        for (article in rawArticles) {
            val key = (article as Map<*, *>).keys.first() as String
            val value = (article as Map<String, *>).values.first() as String

            val articleNumber = key.replace("article_", "").toInt()

            val dbArticles = ArticleData(
                number = articleNumber,
                text = value
            )

            articles.add(dbArticles)
        }

        for (title in rawTitles) {
            val key = (title as Map<*, *>).keys.first() as String
            val value = (title as Map<String, *>).values.first() as Map<String, *>

            val titleNumber = key.replace("title_", "").toInt()

            val dbTitle = TitleData(
                number = titleNumber, text = value["name"] as String,
                articles = (value["articles"] as List<Int>?) ?: listOf(),
            )

            titles.add(dbTitle)

            val rawChapters =
                (value["chapters"] as List<Map<String, Any>>?) ?: listOf()

            for (chapter in rawChapters) {
                val chapKey = (chapter as Map<*, *>).keys.first() as String
                val chapValue = (chapter as Map<String, *>).values.first() as Map<String, *>

                val chapterNumber = chapKey.replace("chapter_", "").toInt()

                val dbChapter = ChapterData(
                    number = chapterNumber,
                    text = chapValue["name"] as String,
                    titleNumber = titleNumber,
                    articles = (chapValue["articles"] as List<Int>?) ?: listOf(),
                )

                chapters.add(dbChapter)

                val rawSections = (chapValue["sections"] as List<Map<String, Any>>?)
                    ?: listOf()

                for (section in rawSections) {
                    val secKey = (section as Map<*, *>).keys.first() as String
                    val secValue = (section as Map<String, *>).values.first() as Map<String, *>

                    val sectionNumber = secKey.replace("section_", "").toInt()

                    val dbSection = SectionData(
                        number = sectionNumber,
                        text = secValue["name"] as String,
                        chapterNumber = chapterNumber,
                        titleNumber = titleNumber,
                        articles = (secValue["articles"] as List<Int>?) ?: listOf(),
                    )

                    sections.add(dbSection)
                }
            }
        }

        // Save In Db
        try {
            articleRepository.insertAll(articles.toList())
            titleRepository.insertAll(*titles.toTypedArray())
            chapterRepository.insertAll(*chapters.toTypedArray())
            sectionRepository.insertAll(*sections.toTypedArray())
        } catch (e: Exception) {
            return Result.Error(SaveOfflineError.ERROR_IN_DB)
        }

        return Result.Success(Unit)
    }


}

