import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../shared/extension/context_extension.dart';
import '../../../../shared/extension/number_extension.dart';

Future<bool?> showImagePreviewDialog(
  BuildContext context, {
  required String imagePath,
  required bool isSelect,
}) async {
  return showDialog<bool?>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.7),
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                16.vSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xff808080),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(context.l10n.cancel),
                      ),
                    ),
                    10.hSpace,
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          context.maybePop(!isSelect);
                        },
                        child: Text(
                          isSelect
                              ? context.l10n.unSelect
                              : context.l10n.select,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}
