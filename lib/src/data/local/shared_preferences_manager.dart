import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKeys {
  adNetwork,
  isFirstPermissionShown,
  settingSortAllType,
  settingSortTimeType,
  settingSortTitleType,
  settingSortSizeType,
  settingSortActivity,
  fileSave,
  fontSize,
  isFirstUseApp,
  countOpenFile,
  isFirstToSplash,
  viewFileCount,
  showAISummaryGuide,
  showAITranslateGuide,
}

enum PremiumType { isPremium, isWeeklyPremium, isMonthlyPremium }

class SharedPreferencesManager {
  SharedPreferencesManager._();

  static final instance = SharedPreferencesManager._();
  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Đánh đấu là màn Permission đã được hiển thị
  Future<void> markFirstPermissionAsShown() async {
    await _prefs?.setBool(PreferenceKeys.isFirstPermissionShown.name, false);
  }

  /// Kiểm tra xem có hiển thị màn permission không
  bool shouldShowPermissionScreen() {
    final bool? showScreen =
        _prefs?.getBool(PreferenceKeys.isFirstPermissionShown.name);
    return showScreen ?? true;
  }

  Future<void> saveAdNetwork(String network) async {
    await _prefs?.setString(PreferenceKeys.adNetwork.name, network);
  }

  String? getAdNetwork() {
    return _prefs?.getString(PreferenceKeys.adNetwork.name);
  }

  Future<void> setPremiumStatus(PremiumType type, bool status) async {
    await _prefs?.setBool(type.name, status);
  }

  bool getPremiumStatus(PremiumType type) {
    return _prefs?.getBool(type.name) ?? false;
  }

  Future<void> setSortAllType(int value) async {
    await _prefs?.setInt(PreferenceKeys.settingSortAllType.name, value);
  }

  int? getSortAllType() {
    return _prefs?.getInt(PreferenceKeys.settingSortAllType.name);
  }

  Future<void> setSortTimeType(int value) async {
    await _prefs?.setInt(PreferenceKeys.settingSortTimeType.name, value);
  }

  int? getSortTimeType() {
    return _prefs?.getInt(PreferenceKeys.settingSortTimeType.name);
  }

  Future<void> setSortTitleType(int value) async {
    await _prefs?.setInt(PreferenceKeys.settingSortTitleType.name, value);
  }

  int? getSortTitleType() {
    return _prefs?.getInt(PreferenceKeys.settingSortTitleType.name);
  }

  Future<void> setSortSizeType(int value) async {
    await _prefs?.setInt(PreferenceKeys.settingSortSizeType.name, value);
  }

  int? getSortSizeType() {
    return _prefs?.getInt(PreferenceKeys.settingSortSizeType.name);
  }

  Future<void> setSortActivityType(int value) async {
    await _prefs?.setInt(PreferenceKeys.settingSortActivity.name, value);
  }

  int? getSortActivityType() {
    return _prefs?.getInt(PreferenceKeys.settingSortActivity.name);
  }

  Future<void> setSaveList(List<String> value) async {
    await _prefs?.setStringList(PreferenceKeys.fileSave.name, value);
  }

  List<String> getSaveList() {
    return _prefs?.getStringList(PreferenceKeys.fileSave.name) ?? [];
  }

  Future<void> setFontSize(int value) async {
    await _prefs?.setInt(PreferenceKeys.fontSize.name, value);
  }

  int? getFontSize() {
    return _prefs?.getInt(PreferenceKeys.fontSize.name);
  }

  bool isFirstUseApp() {
    return _prefs?.getBool(PreferenceKeys.isFirstUseApp.name) ?? true;
  }

  Future<void> setFirstUseApp() async {
    await _prefs?.setBool(PreferenceKeys.isFirstUseApp.name, false);
  }

  int countOpenFile() {
    return _prefs?.getInt(PreferenceKeys.countOpenFile.name) ?? 1;
  }

  Future<void> setCountOpenFile(int value) async {
    await _prefs?.setInt(PreferenceKeys.countOpenFile.name, value);
  }

  bool isFirstToSplash() {
    return _prefs?.getBool(PreferenceKeys.isFirstToSplash.name) ?? true;
  }

  Future<void> setFirstToSplash() async {
    await _prefs?.setBool(PreferenceKeys.isFirstToSplash.name, false);
  }

  Future<void> increaseViewFileCount() async {
    await _prefs?.setInt(PreferenceKeys.viewFileCount.name, viewFileCount + 1);
  }

  int get viewFileCount {
    return _prefs?.getInt(PreferenceKeys.viewFileCount.name) ?? 0;
  }

  bool showAiSummaryGuide() {
    return _prefs?.getBool(PreferenceKeys.showAISummaryGuide.name) ?? true;
  }

  Future<void> setShowAISummaryGuide() async {
    await _prefs?.setBool(PreferenceKeys.showAISummaryGuide.name, false);
  }

  bool showAiTranslateGuide() {
    return _prefs?.getBool(PreferenceKeys.showAITranslateGuide.name) ?? true;
  }

  Future<void> setShowAITranslateGuide() async {
    await _prefs?.setBool(PreferenceKeys.showAITranslateGuide.name, false);
  }
}
