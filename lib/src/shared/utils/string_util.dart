class StringUtil {
  StringUtil._();

  static bool hasSpecialCharacter(String input) {
    final trimmedInput = input.trim();
    final forbiddenPattern = RegExp(r'[\\/:*?"<>|]');
    return forbiddenPattern.hasMatch(trimmedInput);
  }

  static String trimSpaces(String input) {
    return input.trim();
  }
}
