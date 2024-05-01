package com.oseemasuaku.codedutravail.presentation.screens.home.components

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.viewModelScope
import com.oseemasuaku.codedutravail.R
import com.oseemasuaku.codedutravail.presentation.screens.home.HomeViewModel
import kotlinx.coroutines.launch

@Composable
fun HomeBegin() {
    val assets = LocalContext.current.assets
    val viewModel: HomeViewModel = hiltViewModel()
    val loading = viewModel.offlineSaving
    val error = viewModel.offlineError

    Column(
        modifier = Modifier.padding(horizontal = 10.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Image(
            painter = painterResource(id = R.drawable.lawyer_bro),
            contentDescription = "Lawyer",
            modifier = Modifier.heightIn(0.dp, 260.dp)
        )
        Text(
            text = "Nemo jus ignorare censetur ou Ignorantia juris non excusat ⚖\uFE0F",
            textAlign = TextAlign.Center,
            modifier = Modifier.padding(horizontal = 3.dp, vertical = 20.dp)
        )
        if (error.isNotEmpty()) {
            Text(text = error, color = Color.Red, textAlign = TextAlign.Center)
        } else if (loading) {
            CircularProgressIndicator()
        } else {
            Button(modifier = Modifier
                .fillMaxWidth()
                .height(52.dp), onClick = {
                viewModel.viewModelScope.launch {
                    viewModel.saveForOffline(assets)
                }
            }) {
                Text(
                    text = "Commencer", fontSize = 20.sp, fontWeight = FontWeight.Bold
                )
            }
        }
    }
}