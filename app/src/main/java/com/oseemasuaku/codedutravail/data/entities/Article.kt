package com.oseemasuaku.codedutravail.data.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(
    tableName = "articles"
)
data class Article(
    @PrimaryKey(autoGenerate = false)
    val number: Int,
    val text: String,
)