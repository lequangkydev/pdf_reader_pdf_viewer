import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../module/file_system/file_system_manage.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';
import '../../utils/string_util.dart';
import '../../utils/style_utils.dart';

class DialogRename extends StatefulWidget {
  const DialogRename({
    super.key,
    this.defaultName,
    this.file,
    this.confirmText,
  });

  final String? defaultName;
  final FileModel? file;
  final String? confirmText;

  @override
  State<DialogRename> createState() => _DialogRenameState();

  Future<dynamic> show({
    required String defaultName,
    required FileModel file,
    String? confirmText,
  }) async {
    final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
    if (currentCtx == null) {
      return null;
    }
    final result = await showDialog<FileModel>(
      barrierColor: Colors.black.withValues(alpha: .25),
      context: currentCtx,
      builder: (context) {
        return DialogRename(
          confirmText: confirmText,
          defaultName: defaultName,
          file: file,
        );
      },
    );
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }
}

class _DialogRenameState extends State<DialogRename> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.defaultName ?? '';
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
    return Dialog(
      elevation: 0,
      // update color theo design
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Text(
            context.l10n.fileName,
            style: StyleUtils.style.b75.s16.regular,
          ),
          16.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              cursorColor: AppColors.pr,
              decoration: InputDecoration(
                hintStyle: StyleUtils.style.b25.s14,
                hintText: context.l10n.pleaseEnterFileName,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(Assets.icons.icCloseRounded.path),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.b10,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.b10,
                  ),
                ),
              ),
            ),
          ),
          20.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: AppColors.b15,
              border: const Border(top: BorderSide(color: AppColors.b15)),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.router.maybePop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                        ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(context.l10n.cancel,
                          style: StyleUtils.style.b50.s16.semiBold),
                    ),
                  ),
                ),
                const SizedBox(width: 1),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (_controller.text.isEmpty) {
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
                            fontSize: 16.0);
                        return;
                      }
                      final String lastName =
                          StringUtil.trimSpaces(_controller.text);
                      final file = await FileSystemManager.instance
                          .renameFile(widget.file!, lastName);
                      if (context.mounted) {
                        context.maybePop(file);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.r),
                        ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(widget.confirmText ?? context.l10n.save,
                          style: StyleUtils.style.pr.s16.semiBold.copyWith(
                            color:
                                _isButtonEnabled ? AppColors.pr : Colors.grey,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
