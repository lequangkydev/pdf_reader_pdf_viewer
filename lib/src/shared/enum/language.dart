import '../../gen/assets.gen.dart';

enum Languages {
  french(
    code: 'fr',
    name: 'Français',
    note: 'French',
    scriptCode: 'fr',
    countryCode: 'FR',
  ),
  brazilianPortuguese(
    code: 'pt',
    name: 'Português',
    note: 'Brasil',
    scriptCode: null,
    countryCode: 'BR',
  ),
  spanish(
    code: 'es',
    name: 'Español',
    note: 'Spanish',
    scriptCode: 'es',
    countryCode: 'ES',
  ),
  english(
    code: 'en',
    name: 'English',
    note: 'English',
    scriptCode: 'en',
    countryCode: 'EN',
  ),
  hindi(
    code: 'hi',
    name: 'हिन्दी',
    note: 'Hindi',
    scriptCode: 'hi',
    countryCode: 'IN',
  ),
  indonesian(
    code: 'id',
    name: 'Bahasa Indonesia',
    note: 'Indonesian',
    scriptCode: 'id',
    countryCode: 'ID',
  ),
  korean(
    code: 'ko',
    name: '한국어',
    note: 'Korean',
    scriptCode: 'ko',
    countryCode: 'KR',
  ),
  japanese(
    code: 'ja',
    name: '日本語',
    note: 'Japanese',
    scriptCode: 'ja',
    countryCode: 'JP',
  ),
  german(
    code: 'de',
    name: 'Deutsch',
    note: 'German',
    scriptCode: 'de',
    countryCode: 'DE',
  ),
  portuguese(
    code: 'pt',
    name: 'Português',
    note: 'Portugal',
    scriptCode: 'pt',
    countryCode: 'PT',
  ),
  arabic(
    code: 'ar',
    name: 'العربية',
    note: 'Arabic',
    scriptCode: 'ar',
    countryCode: 'SA',
  ),
  bengal(
    code: 'bn',
    name: 'বাংলা',
    note: 'Bengali',
    scriptCode: 'bn',
    countryCode: 'BD',
  ),
  russian(
    code: 'ru',
    name: 'Русский',
    note: 'Russian',
    scriptCode: 'ru',
    countryCode: 'RU',
  ),
  turkish(
    code: 'tr',
    name: 'Türkçe',
    note: 'Turkish',
    scriptCode: 'tr',
    countryCode: 'TR',
  ),
  chineseSimplified(
    code: 'zh',
    name: '简体中文',
    note: 'Chinese Simplified',
    scriptCode: 'Hans',
    countryCode: 'CN',
  ),
  chineseTraditional(
    code: 'zh',
    name: '中文 (繁體)',
    note: 'Chinese Traditional',
    scriptCode: 'Hant',
    countryCode: 'TW',
  );

  final String code;
  final String name;
  final String note;
  final String? scriptCode;
  final String? countryCode;

  const Languages({
    required this.code,
    required this.name,
    required this.note,
    this.scriptCode,
    this.countryCode,
  });

  String get flagPath {
    switch (this) {
      case Languages.english:
        return Assets.images.languages.english.path;
      case Languages.french:
        return Assets.images.languages.french.path;
      case Languages.german:
        return Assets.images.languages.german.path;
      case Languages.hindi:
        return Assets.images.languages.hindi.path;
      case Languages.chineseSimplified:
        return Assets.images.languages.china.path;
      case Languages.chineseTraditional:
        return Assets.images.languages.china.path;
      case Languages.spanish:
        return Assets.images.languages.spanish.path;
      case Languages.brazilianPortuguese:
        return Assets.images.languages.brazil.path;
      case Languages.portuguese:
        return Assets.images.languages.portuguese.path;
      case Languages.arabic:
        return Assets.images.languages.arabic.path;
      case Languages.bengal:
        return Assets.images.languages.bengal.path;
      case Languages.russian:
        return Assets.images.languages.russia.path;
      case Languages.japanese:
        return Assets.images.languages.japan.path;
      case Languages.turkish:
        return Assets.images.languages.turkish.path;
      case Languages.korean:
        return Assets.images.languages.korea.path;
      case Languages.indonesian:
        return Assets.images.languages.indonesia.path;
    }
  }
}
