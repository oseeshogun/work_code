package com.oseemasuaku.codedutravail.presentation.screens.search

import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ArticleSearch(navController: NavHostController) {
    val viewModel: ArticleSearchViewModel = hiltViewModel()

    val query by viewModel.query.collectAsState(initial = "")
    val articles by viewModel.articles.collectAsState(initial = emptyList())

    Surface (
        modifier = Modifier.fillMaxHeight()
    ) {
        LazyColumn {
            item {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 9.dp)
                        .padding(end = 10.dp)
                ) {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.AutoMirrored.Default.ArrowBack, contentDescription = "Retour")
                    }

                    TextField(
                        modifier = Modifier
                            .fillMaxWidth()
                            .weight(1f),
                        value = query, onValueChange = viewModel::search,
                        placeholder = {
                            Text("Rechercher un article...")
                        },
                        leadingIcon = {
                            Icon(Icons.Default.Search, contentDescription = "Rechercher")
                        },
                        trailingIcon = {
                            IconButton(onClick = { viewModel.search("") }) {
                                Icon(Icons.Default.Close, contentDescription = "Reset")
                            }
                        },
                        shape = CircleShape,
                        colors = TextFieldDefaults.colors(
                            focusedIndicatorColor = Color.Transparent,
                            unfocusedIndicatorColor = Color.Transparent,
                            disabledIndicatorColor = Color.Transparent
                        )

                    )

                }
            }

            item {
                Box(
                    modifier = Modifier
                        .padding(12.dp)
                        .border(2.dp, Color.Gray, RoundedCornerShape(8.dp))
                        .padding(8.dp)
                ) {
                    Text(text = buildAnnotatedString {
                        withStyle(
                            style = SpanStyle(
                                fontWeight = FontWeight.Bold
                            )
                        ) {
                            append("Astuces: ")
                        }
                        append("Tapez ")
                        withStyle(
                            style = SpanStyle(
                                fontWeight = FontWeight.Bold
                            )
                        ) {
                            append("18,23,14")
                        }
                        append(" pour avoir les articles 18, 23 et 14")
                    })
                }
            }

            items(articles) {
                Box(
                    modifier = Modifier
                        .padding(vertical = 10.dp, horizontal = 12.dp)
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
}