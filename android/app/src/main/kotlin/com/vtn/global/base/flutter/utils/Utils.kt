package com.vtn.global.base.flutter.utils

val String.isPdf: Boolean
    get() = this == "application/pdf"

val String.isWord: Boolean
    get() = this == "application/msword" ||
            this == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"

val String.isExcel: Boolean
    get() = this == "application/vnd.ms-excel" ||
            this == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

val String.isPowerPoint: Boolean
    get() = this == "application/vnd.ms-powerpoint" ||
            this == "application/vnd.openxmlformats-officedocument.presentationml.presentation"

val String.isImage: Boolean
    get() = this.startsWith("image/")