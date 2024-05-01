package com.oseemasuaku.codedutravail.presentation.screens.home

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.oseemasuaku.codedutravail.presentation.screens.home.components.Header
import com.oseemasuaku.codedutravail.presentation.screens.home.components.HomeBegin

@Composable
fun Home() {


    Surface(
        modifier = Modifier
            .fillMaxSize()
            .padding(10.dp),
        color = MaterialTheme.colorScheme.background
    ) {
        Column(
            modifier = Modifier.fillMaxSize()
        ) {
            Header()
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                HomeBegin()
            }
        }
    }
}