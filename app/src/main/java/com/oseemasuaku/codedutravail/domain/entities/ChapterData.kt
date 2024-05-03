package com.oseemasuaku.codedutravail.domain.entities

data class ChapterData(
    val id: Int = 0,
    val number: Int,
    val text: String,
    val titleNumber: Int,
    val articles: List<Int>,
)
