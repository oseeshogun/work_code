package com.oseemasuaku.codedutravail.presentation.screens.home.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.oseemasuaku.codedutravail.domain.entities.SectionData
import com.oseemasuaku.codedutravail.presentation.screens.home.HomeViewModel
import com.oseemasuaku.codedutravail.presentation.screens.home.components.expandable_section.ExpandableSection
import com.oseemasuaku.codedutravail.presentation.screens.home.utils.toRomanNumeral

@Composable
fun HomeBuildSections(title: Int, chapter: Int) {
    val viewModel: HomeViewModel = hiltViewModel()

    var openedSections by remember {
        mutableStateOf<List<Int>>(emptyList())
    }

    var sections by remember {
        mutableStateOf<List<SectionData>>(listOf())
    }

    LaunchedEffect(Unit) {
        viewModel.getSections(title, chapter).collect {
            sections = it
        }
    }

    return Column(
        modifier = Modifier.padding(start = 16.dp)
    ) {
        sections.forEach {
            ExpandableSection(
                title = "Section ${it.number.toRomanNumeral()}. ${it.text}",
                isExpanded = openedSections.contains(it.id),
                onClick = {
                    openedSections = if (openedSections.contains(it.id)) {
                        openedSections.toMutableList().filter { id -> id != it.id }
                    } else {
                        openedSections.toMutableList().plus(it.id)
                    }
                }) {
                HomeBuildArticles(ids = it.articles)
            }
        }
    }
}