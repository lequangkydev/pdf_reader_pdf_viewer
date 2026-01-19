library syncfusion_pdfviewer_platform_interface;

import 'dart:async';
import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_pdfviewer.dart';

abstract class PdfViewerPlatform extends PlatformInterface {
  /// Constructs a PdfViewerPlatform.
  PdfViewerPlatform() : super(token: _token);
  static PdfViewerPlatform _instance = MethodChannelPdfViewer();

  static final Object _token = Object();

  /// The default instance of [PdfViewerPlatform] to use.
  ///
  /// Defaults to [MethodChannelPdfViewer]
  static PdfViewerPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PdfViewerPlatform] when they register themselves.
  static set instance(PdfViewerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initializes the PDF renderer instance in respective platform by loading the PDF from the specified path.
  ///
  /// If success, returns page count else returns error message from respective platform
  Future<String?> initializePdfRenderer(
      Uint8List documentBytes, String documentID) async {
    throw UnimplementedError(
        'initializePdfRenderer() has not been implemented.');
  }

  /// Gets the height of all pages in the document.
  Future<List?> getPagesHeight(String documentID) async {
    throw UnimplementedError('getPagesHeight() has not been implemented.');
  }

  /// Gets the width of all pages in the document.
  Future<List?> getPagesWidth(String documentID) async {
    throw UnimplementedError('getPagesWidth() has not been implemented.');
  }

  /// Gets the image's bytes information of the specified page.
  Future<Uint8List?> getImage(
      int pageNumber, double scale, String documentID) async {
    throw UnimplementedError('getImage() has not been implemented.');
  }

  /// Gets the image bytes of the specified page from the document at the specified width and height.
  Future<Uint8List?> getPage(
      int pageNumber, int width, int height, String documentID) async {
    throw UnimplementedError('getPage() has not been implemented.');
  }

  /// Gets the image's bytes information of the specified portion of the page.
  Future<Uint8List?> getTileImage(int pageNumber, double scale, double x,
      double y, double width, double height, String documentID) async {
    throw UnimplementedError('getTileImage() has not been implemented.');
  }

  /// Closes the PDF document.
  Future<void> closeDocument(String documentID) async {
    throw UnimplementedError('closeDocument() has not been implemented.');
  }
}
