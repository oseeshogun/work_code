package com.oseemasuaku.codedutravail.data.entities

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(
    tableName = "sections",
    foreignKeys = [
        ForeignKey(
            entity = Chapter::class,
            parentColumns = arrayOf("number"),
            childColumns = arrayOf("chapter"),
            onDelete = ForeignKey.CASCADE
        )
    ]
)
data class Section(
    @PrimaryKey(autoGenerate = false)
    val number: Int,
    val name: String,
    val chapter: Int,
)