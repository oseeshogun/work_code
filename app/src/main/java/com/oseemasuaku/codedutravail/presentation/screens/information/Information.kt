package com.oseemasuaku.codedutravail.presentation.screens.information

import android.app.Activity
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Code
import androidx.compose.material.icons.filled.CorporateFare
import androidx.compose.material.icons.filled.Update
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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun InformationScreen(navController: NavHostController, activity: Activity) {
    val uriHandler = LocalUriHandler.current
    val appUpdateViewModel: AppUpdateViewModel = hiltViewModel()

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
                        uriHandler.openUri("https://oseemasuaku.com")
                    }
                )
            }
            item {
                ListItem(
                    headlineContent = {
                        Text(text = "À propos du Code du Travail")
                    },
                    leadingContent = {
                        Icon(Icons.Default.CorporateFare, contentDescription = "Corporate")
                    },
                    modifier = Modifier.clickable {
                        navController.navigate("about")
                    }
                )
            }
            if (appUpdateViewModel.updateAvailable) {
                item {
                    Spacer(modifier = Modifier.height(10.dp))
                }
                item {
                    ListItem(
                        headlineContent = {
                            Text(text = "Une mise à jour est disponible")
                        },
                        leadingContent = {
                            Icon(Icons.Default.Update, contentDescription = "Update")
                        },
                        modifier = Modifier.clickable {
                            appUpdateViewModel.startUpdateFlow(activity)
                        }
                    )
                }
            }
            item {
                Spacer(modifier = Modifier.height(10.dp))
            }
            item {
                Column(
                    modifier = Modifier
                        .padding(10.dp),
                ) {
                    Text(text = "CLAUSE DE NON-RESPONSABILITÉ", fontWeight = FontWeight.Bold)
                    Spacer(modifier = Modifier.height(6.dp))
                    Text(text = "Cette application fournit une version du Code du Travail provenant d'un lien PDF public. Elle n'est pas affiliée à une entité gouvernementale et ne représente pas un service gouvernemental officiel. Les informations contenues dans cette application sont fournies à titre informatif uniquement et ne doivent pas être considérées comme des conseils juridiques. Pour des informations officielles et à jour, veuillez consulter les sources gouvernementales appropriées dans le lien du cnss (La Caisse Nationale de Sécurité Sociale).")
                    Spacer(modifier = Modifier.height(6.dp))
                    Text(
                        text = "Lien du PDF",
                        modifier = Modifier.clickable {
                            uriHandler.openUri("https://cnss.cd/wp-content/uploads/2020/12/Les-Codes-Larcier-t.IV-Droit-du-Travail-et-de-la-Securite-sociale.pdf")
                        },
                        color = Color.Gray
                    )
                }
            }
        }

    }
}