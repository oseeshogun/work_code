package com.oseemasuaku.codedutravail.data.entities

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "chapters",
    foreignKeys = [
        ForeignKey(
            entity = Title::class,
            parentColumns = arrayOf("number"),
            childColumns = arrayOf("title"),
            onDelete = ForeignKey.CASCADE
        )
    ],
    indices = [Index(value = ["number", "title"], unique = true)]
)
data class Chapter(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val number: Int,
    val text: String,
    val title: Int,
    val articles: List<Int>,
)