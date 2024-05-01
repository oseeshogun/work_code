package com.oseemasuaku.codedutravail.domain.entities

data class ChapterData(
    val number: Int,
    val text: String,
    val titleNumber: Int,
    val articles: List<Int>,
)
