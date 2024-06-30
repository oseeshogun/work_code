package com.oseemasuaku.codedutravail.domain.errors

enum class SaveOfflineError: Error {
    DID_NOT_LOAD_ASSET,
    ERROR_IN_DB
}

enum class RandomArticleOfTheDayError: Error {
    ERROR_IN_DB,
    NO_MORE_TODAY
}