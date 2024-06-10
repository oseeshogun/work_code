package com.oseemasuaku.codedutravail.presentation.screens.information

import android.app.Activity
import android.content.Context
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import com.google.android.play.core.appupdate.AppUpdateInfo
import com.google.android.play.core.appupdate.AppUpdateManager
import com.google.android.play.core.appupdate.AppUpdateManagerFactory
import com.google.android.play.core.appupdate.AppUpdateOptions
import com.google.android.play.core.install.model.AppUpdateType
import com.google.android.play.core.install.model.UpdateAvailability
import com.google.android.play.core.ktx.isFlexibleUpdateAllowed
import dagger.hilt.android.lifecycle.HiltViewModel
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject

@HiltViewModel
class AppUpdateViewModel @Inject constructor(
    @ApplicationContext private val context: Context,
) : ViewModel() {
    private val appUpdateManager: AppUpdateManager = AppUpdateManagerFactory.create(context)

    private var appUpdateInfo by mutableStateOf<AppUpdateInfo?>(null)
    var updateAvailable by mutableStateOf<Boolean>(false)
        private set

    init {
        checkForAppUpdate()
    }

    private fun checkForAppUpdate() {
        appUpdateManager.appUpdateInfo.addOnSuccessListener {
            val isUpdateAvailable = it.updateAvailability() == UpdateAvailability.UPDATE_AVAILABLE
            val isUpdateAllowed = it.isFlexibleUpdateAllowed

            updateAvailable = isUpdateAvailable && isUpdateAllowed
            appUpdateInfo = it
        }
    }

    fun startUpdateFlow(activity: Activity) {
        if (updateAvailable && appUpdateInfo != null) {
            appUpdateManager.startUpdateFlowForResult(
                appUpdateInfo!!,
                activity,
                AppUpdateOptions.newBuilder(AppUpdateType.FLEXIBLE).build(),
                100
            )
        }
    }
}