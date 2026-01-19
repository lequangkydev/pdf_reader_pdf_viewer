import 'dart:async';
import 'dart:ui';

class DeBouncer {
  VoidCallback? action;

  static Timer? timer;

  static void run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
