import 'dart:async';

import 'isolate_controller.dart';


class IsolateHandler<T> {
  IsolateHandler({required this.entryPoint});

  EntryPointType entryPoint;

  IsolateController? isolateController;
  StreamController<T?>? streamController;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }
    isolateController = await IsolateController.spawn(
      callback: (message) {
        if (message is T) {
          streamController?.add(message);
        } else {
          streamController?.add(null);
        }
      },
      entryPoint: entryPoint,
    );
    _initialized = true;
  }

  Future<T?> execute<T2>(T2 data) async {
    streamController = StreamController();
    final Completer<T?> completer = Completer();
    isolateController?.send(data);
    streamController?.stream.listen((event) {
      completer.complete(event);
      streamController?.close();
      streamController = null;
    });
    return completer.future;
  }

  void dispose() {
    isolateController?.close();
  }
}
