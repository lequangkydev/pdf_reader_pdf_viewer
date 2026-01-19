import 'package:flutter/services.dart';

mixin SystemUiMixin {
  void hideNavigationBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: <SystemUiOverlay>[]);
  }
}
