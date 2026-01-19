import 'dart:async';

import '../../remote_config/remote_config.dart';

// class AdEventStream {
//   factory AdEventStream() => _instance;
//   AdEventStream._internal();
//   static final AdEventStream _instance = AdEventStream._internal();
//
//   final _splashDismissController = StreamController<bool>.broadcast();
//
//   Stream<bool> get splashDismissedStream => _splashDismissController.stream;
//
//   void emitSplashDismissed({bool value = true}) {
//     if (RemoteConfigManager.instance.enableReRender) {
//       _splashDismissController.add(value);
//     }
//   }
//
//   void dispose() {
//     _splashDismissController.close();
//   }
// }
