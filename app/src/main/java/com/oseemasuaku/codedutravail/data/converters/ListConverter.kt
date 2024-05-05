package com.oseemasuaku.codedutravail.data.converters

import androidx.room.TypeConverter

class ListConverter {
    @TypeConverter
    fun fromListInt(value: String): List<Int> {
        if (value.isBlank() || value.isEmpty()) return emptyList()
        return value.split(',').filter {
            it.isNotEmpty()
        }.map { it.toInt() }
    }

    @TypeConverter
    fun listIntToString(value: List<Int>): String {
        return value.joinToString(separator = ",")
    }
}