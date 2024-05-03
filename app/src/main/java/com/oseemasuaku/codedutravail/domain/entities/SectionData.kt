package com.oseemasuaku.codedutravail.domain.entities

data class SectionData(
    val id: Int = 0,
    val number: Int,
    val text: String,
    val chapterNumber: Int,
    val titleNumber: Int,
    val articles: List<Int>,
)
