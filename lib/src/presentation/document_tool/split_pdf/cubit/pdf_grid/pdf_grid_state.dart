import 'dart:io';
import 'dart:typed_data';

class PageModel {
  PageModel({
    required this.filePath,
    this.isSelected = false,
    required this.originalIndex,
  });

  final String filePath; // Đường dẫn đến file ảnh của trang PDF
  final bool isSelected;
  final int originalIndex;

  PageModel copyWith({
    String? filePath,
    bool? isSelected,
    int? originalIndex,
  }) {
    return PageModel(
      filePath: filePath ?? this.filePath,
      isSelected: isSelected ?? this.isSelected,
      originalIndex: originalIndex ?? this.originalIndex,
    );
  }
}

enum PdfGridStatus { initial, preparing, ready, loading, error, disposed }

class PdfGridState {
  PdfGridState({
    required this.status,
    required this.pageCount,
    required this.pages,
    required this.nextPageIndex,
    required this.isLoading,
    required this.error,
    required this.sessionDir,
    required this.unlockedBytes,
    required this.dpi,
    required this.batchSize,
  });

  factory PdfGridState.initial() => PdfGridState(
        status: PdfGridStatus.initial,
        pageCount: 0,
        pages: <PageModel>[],
        nextPageIndex: 0,
        isLoading: false,
        error: null,
        sessionDir: null,
        unlockedBytes: null,
        dpi: 150,
        batchSize: 12,
      );

  final PdfGridStatus status;
  final int pageCount;
  final List<PageModel> pages; // null = chưa render xong
  final int nextPageIndex; // 0-based
  final bool isLoading;
  final String? error;
  final Directory? sessionDir;
  final Uint8List? unlockedBytes;
  final double dpi;
  final int batchSize;

  bool get hasMore => nextPageIndex < pageCount;

  PdfGridState copyWith({
    PdfGridStatus? status,
    int? pageCount,
    List<PageModel>? pages,
    int? nextPageIndex,
    bool? isLoading,
    String? error,
    Directory? sessionDir,
    Uint8List? unlockedBytes,
    double? dpi,
    int? batchSize,
  }) {
    return PdfGridState(
      status: status ?? this.status,
      pageCount: pageCount ?? this.pageCount,
      pages: pages ?? this.pages,
      nextPageIndex: nextPageIndex ?? this.nextPageIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sessionDir: sessionDir ?? this.sessionDir,
      unlockedBytes: unlockedBytes ?? this.unlockedBytes,
      dpi: dpi ?? this.dpi,
      batchSize: batchSize ?? this.batchSize,
    );
  }
}
