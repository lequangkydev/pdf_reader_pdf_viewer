import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';

import '../../../../module/log_event_app/scan_pdf_event.dart';
import '../../../../module/tracking_screen/screen_logger.dart';

class ScanPdfCubit extends Cubit<String?> {
  ScanPdfCubit() : super(null);

  Future<void> scanDocument() async {
    AnalyticLogger.instance
        .logEventWithScreen(event: ScanPdfEvent.user_start_scan);
    try {
      final scannedDocuments = await FlutterDocScanner().getScanDocuments();
      if (scannedDocuments == null || !scannedDocuments.containsKey('pdfUri')) {
        return;
      }

      final pathCacheFile = scannedDocuments['pdfUri'] as String;
      AnalyticLogger.instance
          .logEventWithScreen(event: ScanPdfEvent.user_save_file);
      emit(pathCacheFile);
    } on PlatformException {
      return;
    }
  }
}
