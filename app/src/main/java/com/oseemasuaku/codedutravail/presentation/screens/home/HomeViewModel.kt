package com.oseemasuaku.codedutravail.presentation.screens.home

import android.content.res.AssetManager
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.domain.entities.SectionData
import com.oseemasuaku.codedutravail.domain.errors.Result
import com.oseemasuaku.codedutravail.domain.errors.SaveOfflineError
import com.oseemasuaku.codedutravail.domain.repositories.ArticleRepository
import com.oseemasuaku.codedutravail.domain.repositories.ChapterRepository
import com.oseemasuaku.codedutravail.domain.repositories.SectionRepository
import com.oseemasuaku.codedutravail.domain.repositories.TitleRepository
import com.oseemasuaku.codedutravail.domain.usecases.RegisterDataOnOfflineUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.stateIn
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val saveOfflineUseCase: RegisterDataOnOfflineUseCase,

    titleRepository: TitleRepository,
    private val chapterRepository: ChapterRepository,
    private val sectionRepository: SectionRepository,
    private val articleRepository: ArticleRepository,
) : ViewModel() {


    val titles = titleRepository.streamAll()
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())

    var selectedTitle = MutableStateFlow<Int?>(null)
        private set


    @OptIn(ExperimentalCoroutinesApi::class)
    val chapters = selectedTitle.flatMapLatest {
        when (it) {
            null -> MutableStateFlow(emptyList())
            else -> chapterRepository.streamByTitle(it)
                .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())
        }
    }

    var openedChapters = mutableStateListOf<Int>()
        private set

    var offlineError by mutableStateOf("")
        private set
    var offlineSaving by mutableStateOf(false)
        private set

    fun toggleSelectTitle(id: Int) {
        selectedTitle.value = when (selectedTitle.value) {
            id -> null
            else -> id
        }
    }

    suspend fun saveForOffline(assets: AssetManager) {
        offlineSaving = true
        when (val result = saveOfflineUseCase(assets)) {
            is Result.Error -> {
                offlineError = when (result.error) {
                    SaveOfflineError.DID_NOT_LOAD_ASSET -> "Nous n'avons pas réussi à traiter les données."
                    SaveOfflineError.ERROR_IN_DB -> "Il y a eu une erreur au niveau de la base de données locale."
                }
            }

            is Result.Success -> {
                offlineSaving = false
            }
        }
    }

    fun getArticles(articles: List<Int>): StateFlow<List<ArticleData>> {
        return articleRepository.streamArticles(articles)
            .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())
    }

    fun toggleChapterVisibility(id: Int) {
        if (openedChapters.contains(id)) {
            openedChapters.remove(id)
        } else {
            openedChapters.add(id)
        }
    }

    fun getSections(title: Int, chapter: Int): StateFlow<List<SectionData>> {
        return sectionRepository.streamByChapter(title, chapter).stateIn(
            viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList()
        )
    }

}