package com.oseemasuaku.codedutravail.presentation.screens.information

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Code
import androidx.compose.material.icons.filled.WavingHand
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ListItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun InformationScreen(navController: NavHostController) {
    val uriHandler = LocalUriHandler.current

    Scaffold(
        topBar = {
            TopAppBar(
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.AutoMirrored.Default.ArrowBack, contentDescription = "Retour")
                    }
                },
                title = { Text("Information") }
            )
        }
    ) { innerPadding ->
        LazyColumn(
            modifier = Modifier
                .padding(innerPadding),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            item {
                ListItem(
                    headlineContent = {
                        Text(text = "Code Source")
                    },
                    leadingContent = {
                        Icon(Icons.Default.Code, contentDescription = "Code")
                    },
                    modifier = Modifier.clickable {
                        uriHandler.openUri("https://github.com/oseeshogun/work_code")
                    }
                )
            }
            item {
                ListItem(
                    headlineContent = {
                        Text(text = "Développeur")
                    },
                    leadingContent = {
                        Icon(Icons.Default.WavingHand, contentDescription = "Greeting")
                    },
                    modifier = Modifier.clickable {
                        uriHandler.openUri("https://www.linkedin.com/in/osee-masuaku/")
                    }
                )
            }
        }

    }
}