import 'dart:convert';
import 'dart:io';

import 'package:flutter_plugin_aihub/flutter_plugin_aihub.dart';
import 'package:http/http.dart' as http;

import '../data/model/pdf_language_model.dart';

enum SummaryType {
  informative('Informative'),
  official('Official'),
  academic('Academic'),
  literary('Literary'),
  journalistic('Journalistic'),
  criticalAnalysis('Critical Analysis'),
  persuasive('Persuasive');

  final String label;

  const SummaryType(this.label);
}

/// Hành động AI thực hiện
enum AIAction { summarize, translate }

/// Dịch vụ AIHub — dùng cho summarize và translate PDF
class AIService {
  static final AIService _instance = AIService._internal();

  factory AIService() => _instance;

  AIService._internal();

  bool _initialized = false;
  String? _token;
  List<PdfLanguage> listLanguages = [];

  /// Khởi tạo AIHub SDK (chỉ gọi 1 lần)
  Future<bool> init({
    required String baseUrl,
    required String appId,
    required String secretKey,
  }) async {
    if (_initialized) {
      return true;
    }

    final isInit = await FlutterPluginAihub.init(
      baseUrl: baseUrl,
      appId: appId,
      secretKey: secretKey,
    );

    if (isInit) {
      final tokenData = await FlutterPluginAihub.getApiToken();
      _token = tokenData?['token'];
      _initialized = true;
      listLanguages = await _getPdfLanguages();
    }

    return _initialized;
  }

  Future<List<PdfLanguage>> _getPdfLanguages() async {
    _ensureInitialized();
    const url = 'https://api.code12.cloud/app/v2/pdf-summary/language';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Authorization': token!,
        },
      );

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final result = PdfLanguageResponse.fromJson(jsonMap);
        print('✅ Success: ${result.data.length} languages loaded');
        return result.data;
      } else {
        print('❌ Error ${response.statusCode}: ${response.body}');
        return [];
      }
    } catch (e, s) {
      print('❌ Exception: $e');
      print(s);
      return [];
    }
  }

  /// Lấy token hiện tại
  String? get token => _token;

  /// Tóm tắt PDF
  ///
  /// [language]: Ngôn ngữ cần tóm tắt (mặc định: "english")
  /// [summaryType]: Loại tóm tắt (xem enum [SummaryType])
  Future<dynamic> summarizePdf({
    required File file,
    String language = 'english',
    SummaryType summaryType = SummaryType.informative,
  }) async {
    _ensureInitialized();

    final result = await FlutterPluginAihub.pdfSummary(
      token: _token!,
      file: file,
      language: language,
      summaryType: _mapSummaryType(summaryType),
      action: 'SUMMARIZE',
    );
    return result;
  }

  Future<dynamic> translatePdf({
    required File file,
    required String language,
  }) async {
    _ensureInitialized();

    try {
      final result = await FlutterPluginAihub.pdfSummary(
        token: token!,
        file: file,
        language: language,
        summaryType: '',
        action: 'TRANSLATE',
      );
      print('✅ Result: $result');
      return result;
    } catch (e, s) {
      print('❌ Aihub API error: $e');
      throw Exception('Translation failed: $e');
    }
  }

  /// Kiểm tra đã khởi tạo chưa
  void _ensureInitialized() {
    if (!_initialized || _token == null) {
      throw StateError(
        'AIService chưa được khởi tạo. Hãy gọi await AIService().init(...) trước.',
      );
    }
  }

  /// Map enum sang giá trị string hợp lệ cho API
  String _mapSummaryType(SummaryType type) {
    switch (type) {
      case SummaryType.informative:
        return 'INFORMATIVE';
      case SummaryType.official:
        return 'OFFICIAL';
      case SummaryType.academic:
        return 'ACADEMIC';
      case SummaryType.literary:
        return 'LITERARY';
      case SummaryType.journalistic:
        return 'JOURNALISTIC';
      case SummaryType.criticalAnalysis:
        return 'CRITICAL_ANALYSIS';
      case SummaryType.persuasive:
        return 'PERSUASIVE';
    }
  }
}
