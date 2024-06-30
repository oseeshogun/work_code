package com.oseemasuaku.codedutravail.presentation.screens.article

import android.content.Context
import android.speech.tts.TextToSpeech
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import com.oseemasuaku.codedutravail.data.PreferencesManager
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.Flow
import java.util.Locale
import javax.inject.Inject

@HiltViewModel
class ArticleViewModel @Inject constructor(
    private val articleRepository: ArticleRepository,
    private val preferencesManager: PreferencesManager
): ViewModel() {

    var reviewed by mutableStateOf(false)
        private set

    init {
        reviewed = preferencesManager.getBoolean("reviewed", false)
    }

    private  var  textToSpeech: TextToSpeech? = null

    var isReading by mutableStateOf(false)
        private set

    fun getArticle(id: Int): Flow<ArticleData> {
        return articleRepository.streamArticleById(id)
    }

    fun readArticle(article: ArticleData, context: Context) {
        val text: String = "Article ${article.number}:\n${article.text}"

        isReading = true

        textToSpeech = TextToSpeech(context) {
            if (it == TextToSpeech.SUCCESS) {
                textToSpeech?.let { txtToSpeech ->
                    txtToSpeech.language = Locale.FRENCH
                    txtToSpeech.setSpeechRate(1.0f)
                    txtToSpeech.speak(
                        text,
                        TextToSpeech.QUEUE_ADD,
                        null,
                        null
                    )
                }
            }
            isReading = false
        }
    }

    fun successReviewed() {
        preferencesManager.saveBool("reviewed", true)
    }
}