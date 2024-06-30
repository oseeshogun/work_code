package com.oseemasuaku.codedutravail.presentation.screens.home.components

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.oseemasuaku.codedutravail.domain.entities.TitleData
import com.oseemasuaku.codedutravail.presentation.screens.home.HomeViewModel
import com.oseemasuaku.codedutravail.presentation.screens.home.components.expandable_section.ExpandableSection
import com.oseemasuaku.codedutravail.presentation.screens.home.utils.toRomanNumeral

@Composable
fun HomeWorkCode(titles: List<TitleData>, navController: NavHostController) {

    val viewModel: HomeViewModel = hiltViewModel()

    val selectedTitle by viewModel.selectedTitle.collectAsState()

    val openedChapters = viewModel.openedChapters

    val chapters by viewModel.chapters.collectAsState(initial = emptyList())

    Column {
        ArticleOfTheDay(navController)
        Box(
            modifier = Modifier.weight(1f)
        ) {
            LazyColumn {
                items(titles) {
                    ExpandableSection(title = "Titre ${it.number.toRomanNumeral()}. ${it.text}",
                        isExpanded = selectedTitle == it.number,
                        onClick = { viewModel.toggleSelectTitle(it.number) }) {
                        Column(
                            modifier = Modifier.padding(start = 10.dp)
                        ) {
                            chapters.forEach { chapter ->
                                ExpandableSection(
                                    title = "Chapitre ${chapter.number.toRomanNumeral()}. ${chapter.text}",
                                    isExpanded = openedChapters.contains(chapter.id),
                                    onClick = { viewModel.toggleChapterVisibility(chapter.id) }) {
                                    HomeBuildSections(it.number, chapter.number, navController)
                                    HomeBuildArticles(ids = chapter.articles, navController)
                                }
                            }
                            HomeBuildArticles(ids = it.articles, navController)
                        }
                    }
                }
            }
        }
    }


}