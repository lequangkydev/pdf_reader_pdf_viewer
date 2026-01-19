import 'package:hive_ce/hive.dart';

import '../../src/presentation/signature/model/stroke.dart';
import 'hive_box.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Signature>(),
  AdapterSpec<Stroke>(),
  AdapterSpec<Point>(),
])
// This is for code generation
// ignore: unused_element
class HiveAdapters {}
