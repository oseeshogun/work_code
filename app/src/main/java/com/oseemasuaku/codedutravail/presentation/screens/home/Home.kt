package com.oseemasuaku.codedutravail.presentation.screens.home

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.oseemasuaku.codedutravail.presentation.screens.home.components.Header
import com.oseemasuaku.codedutravail.presentation.screens.home.components.HomeBegin
import com.oseemasuaku.codedutravail.presentation.screens.home.components.HomeWorkCode
import kotlinx.coroutines.launch

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Home(navController: NavHostController) {
    val viewModel: HomeViewModel = hiltViewModel()

    val titles by viewModel.titles.collectAsState()

    val sheetState = rememberModalBottomSheetState(
        skipPartiallyExpanded = true
    )

    val scope = rememberCoroutineScope()

    var showBottomSheet by remember { mutableStateOf(titles.isEmpty()) }


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
                        if (showBottomSheet) ModalBottomSheet(
                            onDismissRequest = {
                                showBottomSheet = false
                            },
                            sheetState = sheetState,
                        ) {
                            Column(
                                modifier = Modifier.padding(16.dp),
                            ) {
                                Text(
                                    text = "CLAUSE DE NON-RESPONSABILITÉ",
                                    fontWeight = FontWeight.Bold,
                                    fontSize = 20.sp,
                                    textAlign = TextAlign.Center
                                )
                                Spacer(modifier = Modifier.height(10.dp))
                                Text(text = "Cette application n'est affiliée à aucune entité gouvernementale et ne représente pas un département gouvernemental officiel. Les informations contenues dans cette application sont fournies uniquement à titre informatif et ne doivent pas être considérées comme des conseils juridiques. Bien que nous nous efforcions de fournir des informations précises et à jour, nous ne garantissons pas leur exactitude, exhaustivité ou actualité. Pour des conseils juridiques spécifiques ou des informations officielles, veuillez consulter directement les sources gouvernementales appropriées ou un conseiller juridique qualifié.")
                                Spacer(modifier = Modifier.height(20.dp))
                                Button(onClick = {
                                    scope.launch {
                                        sheetState.hide()
                                    }.invokeOnCompletion {
                                        if (!sheetState.isVisible) {
                                            showBottomSheet = false
                                        }
                                    }
                                }) {

                                    Text(text = "J'ai compris")
                                }
                                Spacer(modifier = Modifier.height(20.dp))
                            }
                        }
                    } else {
                        HomeWorkCode(titles, navController)
                    }
                }
            }
        }

    }
}