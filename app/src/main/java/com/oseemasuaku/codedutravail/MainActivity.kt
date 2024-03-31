package com.oseemasuaku.codedutravail

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.Modifier
import com.oseemasuaku.codedutravail.presentation.screens.Home
import com.oseemasuaku.codedutravail.ui.theme.CodeDuTravailTheme


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CodeDuTravailTheme {
                Home()

//                    val content: String = assets.open("work_code.yaml").bufferedReader().use {
//                        it.readText()
//                    }

            }
        }
    }
}