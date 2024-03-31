package com.oseemasuaku.codedutravail.data.entities

import androidx.room.Entity
import androidx.room.ForeignKey
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
    ]
)
data class Chapter(
    @PrimaryKey(autoGenerate = false)
    val number: Int,
    val name: String,
    val title: Int,
)