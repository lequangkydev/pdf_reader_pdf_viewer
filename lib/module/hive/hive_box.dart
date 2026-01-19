import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../src/presentation/signature/model/stroke.dart';
import 'hive_registrar.g.dart';

class HiveBox {
  HiveBox._();

  static Box<Signature> get signature => Hive.box(BoxKey.signature.name);

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    await Future.wait([
      Hive.openBox<Signature>(BoxKey.signature.name),
    ]);
  }
}

enum BoxKey {
  signature,
}

class Signature extends HiveObject {
  Signature({
    this.strokes = const [],
    this.width = 0,
    this.height = 0,
  });

  final List<Stroke> strokes;
  final double width;
  final double height;
}
