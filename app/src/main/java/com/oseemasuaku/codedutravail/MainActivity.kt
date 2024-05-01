package com.oseemasuaku.codedutravail

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.oseemasuaku.codedutravail.presentation.screens.home.Home
import com.oseemasuaku.codedutravail.ui.theme.CodeDuTravailTheme
import dagger.hilt.android.AndroidEntryPoint


@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CodeDuTravailTheme {
                Home()
            }
        }
    }
}