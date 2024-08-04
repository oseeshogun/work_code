package com.oseemasuaku.codedutravail.presentation.screens.home.components

import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.oseemasuaku.codedutravail.presentation.screens.home.ArticleOfTheDayViewModel

@Composable
fun ArticleOfTheDay(navController: NavHostController) {
    val viewModel: ArticleOfTheDayViewModel = hiltViewModel()
    val articleOfTheDay = viewModel.articleOfTheDay

    if (articleOfTheDay == null) {
        Spacer(modifier = Modifier)
    } else {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 10.dp)
                .border(
                    width = 1.dp,
                    color = MaterialTheme.colorScheme.primary,
                    shape = RoundedCornerShape(10.dp)
                )
                .padding(vertical = 2.dp, horizontal = 4.dp)
        ) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 6.dp, horizontal = 10.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.Center,
                ) {
                    Text(
                        text = "Article du jour",
                        textAlign = TextAlign.Center,
                        style = TextStyle(fontWeight = FontWeight.Bold, fontSize = 20.sp)
                    )
                    Spacer(modifier = Modifier.weight(1f))
                    IconButton(onClick = {
                        viewModel.removeForToday()
                    }) {
                        Icon(imageVector = Icons.Default.Close, contentDescription = "Close")
                    }
                }
                Spacer(modifier = Modifier.height(8.dp))
                Box(
                    modifier = Modifier
                        .clickable {
                            navController.navigate("article/${articleOfTheDay.number}")
                        },
                ) {
                    Text(text = buildAnnotatedString {
                        withStyle(
                            style = SpanStyle(
                                fontWeight = FontWeight.Bold
                            )
                        ) {
                            append("Article ${articleOfTheDay.number}: ")
                        }
                        append(
                            "${
                                if (articleOfTheDay.text.length > 150)
                                    articleOfTheDay.text.substring(
                                        0,
                                        150
                                    ) else articleOfTheDay.text
                            }..."
                        )
                    })

                }
                Spacer(modifier = Modifier.height(8.dp))
                Box(
                    modifier = Modifier.align(Alignment.Start)
                ) {
                    TextButton(onClick = { navController.navigate("article/${articleOfTheDay.number}") }

                    ) {
                        Text(text = "Voir plus")
                    }
                }
            }
        }
    }
}