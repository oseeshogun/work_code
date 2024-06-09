package com.oseemasuaku.codedutravail

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.oseemasuaku.codedutravail.presentation.screens.article.ArticleScreen
import com.oseemasuaku.codedutravail.presentation.screens.home.Home
import com.oseemasuaku.codedutravail.presentation.screens.information.AboutWorkCode
import com.oseemasuaku.codedutravail.presentation.screens.information.InformationScreen
import com.oseemasuaku.codedutravail.presentation.screens.search.ArticleSearch
import com.oseemasuaku.codedutravail.ui.theme.CodeDuTravailTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CodeDuTravailTheme {
                val navController = rememberNavController()
                NavHost(navController = navController, startDestination = "home") {
                    composable("home") {
                        Home(navController)
                    }
                    composable("article/{id}") { navBackStackEntry ->
                        navBackStackEntry.arguments?.let {
                            ArticleScreen(
                                id = it.getString("id")!!.toInt()
                            )
                        }
                    }
                    composable("search") {
                        ArticleSearch(navController)
                    }
                    composable("info") {
                        InformationScreen(navController)
                    }
                    composable("about") {
                        AboutWorkCode(navController)
                    }
                }
            }
        }
    }
}