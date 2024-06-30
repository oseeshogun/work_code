package com.oseemasuaku.codedutravail.presentation.screens.home.components

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.oseemasuaku.codedutravail.R

@Composable
fun Header(hideSearch: Boolean = false, navController: NavController? = null) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(10.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Image(
            painter = painterResource(id = R.drawable.drc_law),
            contentDescription = "Armorial",
            modifier = Modifier.size(30.dp)
        )
        Box(
            modifier = Modifier.weight(1f),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "Code du Travail",
                style = MaterialTheme.typography.headlineMedium
            )
        }

        if (!hideSearch) {
            IconButton(onClick = {
                navController.let {
                    it?.navigate("search")
                }
            }) {
                Icon(imageVector = Icons.Default.Search, contentDescription = "Recherche")
            }
            IconButton(onClick = {
                navController.let {
                    it?.navigate("info")
                }
            }) {
                Icon(Icons.Default.Info, contentDescription = "Info")
            }
        }

    }
}