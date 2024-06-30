package com.oseemasuaku.codedutravail.domain.usecases

import com.oseemasuaku.codedutravail.data.PreferencesManager
import org.threeten.bp.LocalDate
import javax.inject.Inject

class NoMoreArticleTodayUseCase @Inject constructor(private val preferencesManager: PreferencesManager) {
    operator fun invoke(): Unit {
        val today = LocalDate.now().toString()
        preferencesManager.saveBool("no_more_$today", true)
    }
}