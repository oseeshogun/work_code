package com.oseemasuaku.codedutravail.presentation.screens.article

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.oseemasuaku.codedutravail.presentation.screens.home.components.Header

@Composable
fun ArticleScreen(id: Int) {
    val viewModel: ArticleViewModel = hiltViewModel()

    val article by viewModel.getArticle(id).collectAsState(initial = null)

    Column(
        modifier = Modifier.padding(top = 20.dp, start = 20.dp, end = 20.dp)
    ) {
        Header(true)
        Spacer(modifier = Modifier.height(20.dp))
        if (article != null) {
            LazyColumn(
                contentPadding = PaddingValues(bottom = 20.dp)
            ) {
                item {
                    Text(text = "Article ${article!!.number}", fontWeight = FontWeight.Bold)
                }
                item {
                    Spacer(modifier = Modifier.height(20.dp))
                }
                item {
                    Text(text = article!!.text)
                }
            }
        }
    }
}