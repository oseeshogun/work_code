package com.oseemasuaku.codedutravail.data.entities

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(
    tableName = "articles",
    foreignKeys = [
        ForeignKey(
            entity = Title::class,
            parentColumns = arrayOf("number"),
            childColumns = arrayOf("title"),
            onDelete = ForeignKey.SET_NULL
        ),
        ForeignKey(
            entity = Chapter::class,
            parentColumns = arrayOf("number"),
            childColumns = arrayOf("chapter"),
            onDelete = ForeignKey.SET_NULL
        ),
        ForeignKey(
            entity = Section::class,
            parentColumns = arrayOf("number"),
            childColumns = arrayOf("section"),
            onDelete = ForeignKey.SET_NULL
        ),
    ]
)
data class Article (
    @PrimaryKey(autoGenerate = false)
    val number: Int,
    val text: String,
    val title: Int?,
    val chapter: Int?,
    val section: Int?
)