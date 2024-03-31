package com.oseemasuaku.codedutravail.data.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "titles")
data class Title (
    @PrimaryKey(autoGenerate = false)
    val number: Int,
    val name: String
)