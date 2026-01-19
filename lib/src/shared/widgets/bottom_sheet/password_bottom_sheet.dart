import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../constants/app_colors.dart';
import '../../cubit/ad_visibility_cubit.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';

enum TypePassword { set, remove, enter }

class PasswordBottomSheet extends StatefulLoggableWidget {
  const PasswordBottomSheet({
    super.key,
    this.pdfFile,
    this.typePassword = TypePassword.enter,
    required this.isOpen,
  });

  final File? pdfFile;
  final TypePassword? typePassword;
  final bool isOpen;

  @override
  _PasswordBottomSheetState createState() => _PasswordBottomSheetState();
}

class _PasswordBottomSheetState extends State<PasswordBottomSheet> {
  bool _isObscured = true;
  final _passwordCtrl = TextEditingController();
  String? _errorMessage;

  String getTitle() {
    if (widget.typePassword == TypePassword.remove) {
      return context.l10n.removePassword;
    }
    if (widget.typePassword == TypePassword.enter) {
      return context.l10n.enterPassword;
    }
    if (widget.typePassword == TypePassword.set) {
      return context.l10n.setPassword;
    }
    return '';
  }

  String getSubTitle() {
    if (widget.isOpen) {
      if (widget.typePassword == TypePassword.remove) {
        return context.l10n.removePwTo;
      }
      if (widget.typePassword == TypePassword.enter) {
        return context.l10n.enterThePassword;
      }
      if (widget.typePassword == TypePassword.set) {
        return context.l10n.setPwTo;
      }
    }

    return context.l10n.enterPassSelect;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Text(
                getTitle(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.color40),
              ),
            ),
            24.vSpace,
            if (widget.typePassword == TypePassword.enter)
              Text(
                context.l10n.passwordProtected(
                    path.basename(widget.pdfFile?.path ?? '')),
                style: const TextStyle(fontSize: 14),
              ),
            10.vSpace,
            Text(
              getSubTitle(),
              style: const TextStyle(fontSize: 14, color: AppColors.color80),
            ),
            20.vSpace,
            TextField(
              controller: _passwordCtrl,
              obscureText: _isObscured,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: context.l10n.password,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorE6E6E6,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorE6E6E6,
                  ),
                ),
                errorText: _errorMessage,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
              ),
            ),
            20.vSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: Navigator.of(context).pop,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      context.l10n.cancel,
                      style: const TextStyle(
                        color: AppColors.color80,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                10.hSpace,
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      if (_passwordCtrl.text.isEmpty) {
                        return;
                      }
                      //trường hợp set password
                      if (widget.pdfFile == null) {
                        context.maybePop(_passwordCtrl.text);
                        return;
                      }

                      //trường hợp open file hoặc remove password
                      if (widget.pdfFile != null &&
                          (widget.typePassword == TypePassword.enter ||
                              widget.typePassword == TypePassword.remove)) {
                        try {
                          final List<int> bytes =
                              widget.pdfFile!.readAsBytesSync();
                          PdfDocument(
                              inputBytes: bytes, password: _passwordCtrl.text);
                          Navigator.of(context).pop(_passwordCtrl.text);
                        } catch (e) {
                          setState(() {
                            _errorMessage = context.l10n.wrongPassword;
                          });
                        }
                        return;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _passwordCtrl.text.isNotEmpty
                          ? AppColors.pr
                          : Colors.grey[300],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      context.l10n.confirm,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> showPasswordBottomSheet({
  required bool isOpen,
  File? pdfFile,
  TypePassword? typePassword,
}) async {
  final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
  if (currentCtx == null) {
    return null;
  }
  getIt<AdVisibilityCubit>().update(false);
  return showModalBottomSheet<String>(
    context: currentCtx,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return PasswordBottomSheet(
        pdfFile: pdfFile,
        typePassword: typePassword,
        isOpen: isOpen,
      );
    },
  ).then((value) {
    getIt<AdVisibilityCubit>().update(true);
    return value;
  });
}
