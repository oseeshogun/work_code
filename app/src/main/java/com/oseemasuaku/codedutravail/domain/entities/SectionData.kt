package com.oseemasuaku.codedutravail.domain.entities

data class SectionData(
    val number: Int,
    val text: String,
    val chapterNumber: Int,
    val titleNumber: Int,
    val articles: List<Int>,
)
