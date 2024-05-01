package com.oseemasuaku.codedutravail.presentation.screens.home

import android.content.res.AssetManager
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import com.oseemasuaku.codedutravail.domain.errors.Result
import com.oseemasuaku.codedutravail.domain.errors.SaveOfflineError
import com.oseemasuaku.codedutravail.domain.usecases.RegisterDataOnOfflineUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val saveOfflineUseCase: RegisterDataOnOfflineUseCase
): ViewModel() {

    var offlineError by mutableStateOf("")
        private set
    var offlineSaving by mutableStateOf(false)
        private set

    suspend fun saveForOffline(assets: AssetManager) {
        offlineSaving = true
        when (val result = saveOfflineUseCase(assets)) {
            is Result.Error -> {
                offlineError = when (result.error) {
                    SaveOfflineError.DID_NOT_LOAD_ASSET -> "Nous n'avons pas réussi à traiter les données."
                    SaveOfflineError.ERROR_IN_DB -> "Il y a eu une erreur au niveau de la base de données locale."
                }
            }
            is Result.Success -> {
                offlineSaving = false
            }
        }
    }
}