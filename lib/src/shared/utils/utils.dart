import 'package:flutter/material.dart';

import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';

BuildContext get appContext => getIt<AppRouter>().navigatorKey.currentContext!;
