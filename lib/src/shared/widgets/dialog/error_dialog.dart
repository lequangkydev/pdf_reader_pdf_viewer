import 'package:flutter/material.dart';

import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../extension/context_extension.dart';

Future<void> showErrorDialog(String error, String description) async {
  final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
  if (currentCtx == null) {
    return;
  }
  return showDialog<dynamic>(
    context: currentCtx,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(error),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            child: Text(context.l10n.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
