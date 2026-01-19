import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'ios_file_reader.dart';

class IOSFileReaderView extends StatefulWidget {
  // MARK: - Properties
  final File file;
  final Function(bool)? openSuccess;
  final Widget? loadingWidget;
  final Widget? unSupportFileWidget;

  const IOSFileReaderView({
    super.key,
    required this.file,
    this.openSuccess,
    this.loadingWidget,
    this.unSupportFileWidget,
  });

  @override
  State<IOSFileReaderView> createState() => _FileReaderViewState();
}

class _FileReaderViewState extends State<IOSFileReaderView> {
  static const String _viewType = 'FileReader';
  static const String _unsupportedPlatform = 'Unsupported platform';

  FileReaderState _status = FileReaderState.LOADING_ENGINE;

  @override
  void initState() {
    super.initState();
    _checkEngineLoad();
  }

  void _checkEngineLoad() {
    IOSFileReader.instance.engineLoadStatus((success) {
      _setStatus(success
          ? FileReaderState.ENGINE_LOAD_SUCCESS
          : FileReaderState.ENGINE_LOAD_FAIL);
    });
  }

  void _setStatus(FileReaderState status) {
    if (!mounted) {
      return;
    }
    setState(() => _status = status);
  }

  void _onPlatformViewCreated(int id) {
    IOSFileReader.instance.openFile(id, widget.file.path, (success) {
      if (!success) {
        _setStatus(FileReaderState.UNSUPPORT_FILE);
      }
      widget.openSuccess?.call(success);
    });
  }

  String _getFileExtension(String filePath) {
    if (filePath.isEmpty) {
      return '';
    }

    final int lastDotIndex = filePath.lastIndexOf('.');
    if (lastDotIndex <= -1) {
      return '';
    }

    return filePath.substring(lastDotIndex + 1);
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return const Center(child: Text(_unsupportedPlatform));
    }

    return _buildContentBasedOnStatus();
  }

  Widget _buildContentBasedOnStatus() {
    switch (_status) {
      case FileReaderState.LOADING_ENGINE:
        return _buildLoadingWidget();
      case FileReaderState.UNSUPPORT_FILE:
        return _buildUnsupportedFileWidget();
      case FileReaderState.ENGINE_LOAD_SUCCESS:
        return _buildIOSView();
      case FileReaderState.ENGINE_LOAD_FAIL:
        return _buildEngineLoadFailWidget();
      case FileReaderState.FILE_NOT_FOUND:
        return _buildFileNotFoundWidget();
    }
  }

  Widget _buildUnsupportedFileWidget() {
    return widget.unSupportFileWidget ??
        Center(
          child: Text(
              'Unable to open file with ${_getFileExtension(widget.file.path)} extension'),
        );
  }

  Widget _buildFileNotFoundWidget() {
    return const Center(
      child: Text('File does not exist'),
    );
  }

  Widget _buildEngineLoadFailWidget() {
    return const Center(
      child: Text('Engine loading failed. Please try again'),
    );
  }

  Widget _buildLoadingWidget() {
    return widget.loadingWidget ??
        const Center(
          child: CupertinoActivityIndicator(),
        );
  }

  Widget _buildIOSView() {
    return UiKitView(
      viewType: _viewType,
      onPlatformViewCreated: _onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
