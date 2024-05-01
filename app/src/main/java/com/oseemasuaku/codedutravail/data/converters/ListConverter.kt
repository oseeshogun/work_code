package com.oseemasuaku.codedutravail.data.converters

import androidx.room.TypeConverter

class ListConverter {
    @TypeConverter
    fun fromListInt(value: String): List<Int> {
        return value.split(',').map { it.toInt() }
    }

    @TypeConverter
    fun listIntToString(value: List<Int>): String {
        return value.joinToString(separator = ",")
    }
}