extension StringExtension on String? {
  bool get isValid {
    if (this != null && this!.isNotEmpty) {
      return true;
    }
    return false;
  }

  String get formatFileNamePdf {
    if (this != null && this!.isEmpty) {
      return '';
    }
    if (this!.length <= 12) {
      return this!;
    }

    final String prefix = this!.substring(0, 12);
    final String suffix = this!.substring(this!.length - 7);
    final String formattedName = '$prefix...$suffix';

    return formattedName;
  }

  String shortenFileName(String extension, {int maxLength = 15}) {
    if (this!.length <= maxLength) {
      return this! + extension;
    }
    final String shortenedName =
        '${this!.substring(0, maxLength - 3)}...${this!.substring(this!.length - 3)}';
    return shortenedName + extension;
  }

  bool containsDiacritics(String value) {
    const withDiacritics =
        'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ'
        'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮ'
        'ỲÝỴỶỸĐ';
    return value.split('').any((ch) => withDiacritics.contains(ch));
  }
}
