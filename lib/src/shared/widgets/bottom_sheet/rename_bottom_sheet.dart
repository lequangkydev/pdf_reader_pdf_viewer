import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../config/di/di.dart';
import '../../../gen/assets.gen.dart';
import '../../constants/app_colors.dart';
import '../../cubit/ad_visibility_cubit.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';
import '../../utils/string_util.dart';

class RenameBottomSheet extends StatefulWidget {
  const RenameBottomSheet({super.key, this.defaultName});

  final String? defaultName;

  @override
  _RenameBottomSheetState createState() => _RenameBottomSheetState();
}

class _RenameBottomSheetState extends State<RenameBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller.text =
        "${widget.defaultName ?? 'ScanPdf'}${DateTime.now().millisecondsSinceEpoch}";
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(context.l10n.fileName,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: _controller.clear,
                icon: Assets.icons.cleanText.svg(width: 24),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xffE6E6E6),
                  width: 1.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xffE6E6E6),
                  width: 1.6,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red, // màu khi error
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ),
        20.vSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) {
                      Fluttertoast.showToast(
                          msg: context.l10n.fileNameCannotBeEmpty,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: AppColors.pr,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    if (StringUtil.hasSpecialCharacter(_controller.text)) {
                      Fluttertoast.showToast(
                        msg: context.l10n.errorCharacter,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.pr,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }
                    final String lastName =
                        StringUtil.trimSpaces(_controller.text);

                    Navigator.of(context).pop(lastName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isButtonEnabled ? AppColors.pr : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    context.l10n.save,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        20.vSpace,
      ],
    );
  }
}

Future<String?> showRenameDialog({
  required BuildContext context,
  String? defaultName,
}) async {
  getIt<AdVisibilityCubit>().update(false);

  final result = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RenameBottomSheet(
            defaultName: defaultName,
          ),
        ),
      );
    },
  );

  getIt<AdVisibilityCubit>().update(true);
  return result;
}
