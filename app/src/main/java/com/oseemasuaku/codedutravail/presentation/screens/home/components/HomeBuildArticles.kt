package com.oseemasuaku.codedutravail.presentation.screens.home.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.oseemasuaku.codedutravail.domain.entities.ArticleData
import com.oseemasuaku.codedutravail.presentation.screens.home.HomeViewModel

@Composable
fun HomeBuildArticles(ids: List<Int>, navController: NavHostController) {
    val viewModel: HomeViewModel = hiltViewModel()

    var articles by remember {
        mutableStateOf<List<ArticleData>>(listOf())
    }

    LaunchedEffect(Unit) {
        viewModel.getArticles(ids).collect {
            articles = it
        }
    }

    Column {
        articles.forEach {
            Box(
                modifier = Modifier
                    .padding(vertical = 8.dp)
                    .clickable {
                        navController.navigate("article/${it.number}")
                    },
            ) {
                Text(text = buildAnnotatedString {
                    withStyle(
                        style = SpanStyle(
                            fontWeight = FontWeight.Bold
                        )
                    ) {
                        append("Article ${it.number}: ")
                    }
                    append(
                        "${
                            if (it.text.length > 150)
                                it.text.substring(
                                    0,
                                    150
                                ) else it.text
                        }..."
                    )
                })

            }
        }
    }
}