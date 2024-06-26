package com.oseemasuaku.codedutravail.presentation.screens.home

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.oseemasuaku.codedutravail.presentation.screens.home.components.Header
import com.oseemasuaku.codedutravail.presentation.screens.home.components.HomeBegin
import com.oseemasuaku.codedutravail.presentation.screens.home.components.HomeWorkCode

@Composable
fun Home(navController: NavHostController) {
    val viewModel: HomeViewModel = hiltViewModel()

    val titles by viewModel.titles.collectAsState()



    Surface(
        modifier = Modifier
            .fillMaxSize(),
        color = MaterialTheme.colorScheme.background
    ) {
        Box(
            modifier = Modifier
        ) {
            Column(
                modifier = Modifier.fillMaxSize()
            ) {
                Header(false, navController)
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    if (titles.isEmpty()) {
                        HomeBegin()
                    } else {
                        HomeWorkCode(titles, navController)
                    }
                }
            }
        }

    }
}