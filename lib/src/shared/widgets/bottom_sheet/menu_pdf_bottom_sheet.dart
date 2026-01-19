import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../module/file_system/file_system_manage.dart';
import '../../../../module/log_event_app/bottom_sheet_event.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../presentation/all_documents/cubit/base_cubit.dart';
import '../../../presentation/all_documents/cubit/pdf_cubit.dart';
import '../../../presentation/document/widgets/item_folder_widget.dart';
import '../../../presentation/document_tool/utils/pdf_util.dart';
import '../../../services/default_app_checker.dart';
import '../../constants/app_colors.dart';
import '../../enum/app_enum.dart';
import '../../enum/pdf_action.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';
import '../../utils/debouncer.dart';
import '../../utils/share_util.dart';
import '../../utils/style_utils.dart';
import '../../utils/utils.dart';
import '../dialog/dialog_widget.dart';
import '../dialog/loading_dialog.dart';
import 'file_details_bottom_sheet.dart';
import 'password_bottom_sheet.dart';

class MenuPdfBottomSheet extends StatefulLoggableWidget {
  const MenuPdfBottomSheet({
    super.key,
    required this.file,
    required this.tabBarType,
    required this.renameCallback,
    required this.callBackDelete,
    required this.baseFileCubit,
  });

  final FileModel file;
  final TabBarType tabBarType;
  final Function(FileModel) renameCallback;
  final VoidCallback callBackDelete;
  final BaseFileCubit baseFileCubit;

  @override
  _MenuPdfBottomSheetState createState() => _MenuPdfBottomSheetState();
}

class _MenuPdfBottomSheetState extends State<MenuPdfBottomSheet> {
  late FileModel fileModel;
  TabBarType type = TabBarType.all;

  @override
  void initState() {
    super.initState();
    fileModel = widget.file;
    if (widget.tabBarType == TabBarType.all) {
      type = FileSystemManager.instance.getTypeFile(fileModel.file);
    }
    type = widget.tabBarType;
  }

  Future<void> unLockPDF() async {
    await context.maybePop();
    final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
    if (currentCtx == null) {
      return;
    }
    AnalyticLogger.instance
        .logEventWithScreen(event: BottomSheetEvent.user_click_unLock);
    final pass = await showPasswordBottomSheet(
      pdfFile: fileModel.file,
      typePassword: TypePassword.remove,
      isOpen: true,
    );

    if (pass != null && currentCtx.mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      LoadingOverlay.show();
      final newFile =
          await PdfUtil.removePasswordPdf(file: fileModel.file, password: pass);
      if (newFile == null) {
        return;
      }
      final newFileModel = fileModel.copyWith(
        file: newFile,
        isLock: false,
      );
      getIt<PdfCubit>().updateFile(newFileModel);
      LoadingOverlay.hide();
      if (currentCtx.mounted) {
        currentCtx.pushRoute(
          FileSuccessRoute(
            fileModel: newFileModel,
            title: currentCtx.l10n.unlockPdfSuccess,
          ),
        );
      }
    }
  }

  Future<void> lockPDF() async {
    await context.maybePop(); //pop bottom menu
    final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
    if (currentCtx == null) {
      return;
    }
    AnalyticLogger.instance
        .logEventWithScreen(event: BottomSheetEvent.user_click_lock);
    final pass = await showPasswordBottomSheet(
      typePassword: TypePassword.set,
      isOpen: true,
    );
    if (pass != null && currentCtx.mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      LoadingOverlay.show();

      final newFile =
          await PdfUtil.setPasswordPdf(file: fileModel.file, password: pass);

      if (!currentCtx.mounted) {
        return;
      }
      if (newFile == null) {
        LoadingOverlay.hide();
        return;
      }
      final newFileModel = fileModel.copyWith(file: newFile, isLock: true);
      getIt<PdfCubit>().updateFile(newFileModel);
      LoadingOverlay.hide();
      currentCtx.pushRoute(
        FileSuccessRoute(
          fileModel: newFileModel,
          title: currentCtx.l10n.lockPdfSuccess,
        ),
      );
    }
  }

  Future<void> printFile() async {
    AnalyticLogger.instance
        .logEventWithScreen(event: BottomSheetEvent.user_click_print);
    DeBouncer.run(() async {
      if (type == TabBarType.pdf) {
        final isProtect = await PdfUtil.isPdfProtected(fileModel.file);
        if (isProtect) {
          final password = await showPasswordBottomSheet(
            typePassword: TypePassword.enter,
            pdfFile: fileModel.file,
            isOpen: true,
          );
          if (password == null) {
            return;
          } else {
            PdfUtil.printToPdf(file: fileModel.file, password: password);
            return;
          }
        }

        PdfUtil.printToPdf(file: fileModel.file);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemFolderWidget(
            fileModel: fileModel,
            tabBarType: type,
            inBottomSheet: true,
            onTapThreeDot: () {},
            showThreeDot: false,
            onTapSaveOrCheckBox: () async {
              final cubit = widget.tabBarType.getCubitForFile(fileModel.file);
              if (cubit != null) {
                await cubit.toggleBookmark(fileModel.file);
              }
              fileModel = fileModel.copyWith(isBookmark: !fileModel.isBookmark);
              setState(() {});
            },
            itemFolderType: ItemFolderType.itemSave,
            onTapOpenFile: () {},
          ),
          const Divider(color: AppColors.b7),
          20.vSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.rename.path,
                  context.l10n.rename,
                  onTap: () async {
                    AnalyticLogger.instance.logEventWithScreen(
                        event: BottomSheetEvent.user_click_rename);
                    await context.maybePop<PdfActionEnum>(PdfActionEnum.rename);
                  },
                ),
              ),
              6.hSpace,
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.share.path,
                  context.l10n.share,
                  onTap: () async {
                    DefaultAppChecker.blockNotify();
                    AnalyticLogger.instance.logEventWithScreen(
                        event: BottomSheetEvent.user_click_share);
                    DeBouncer.run(() async {
                      await ShareUtil.shareFiles([XFile(fileModel.file.path)]);
                      DefaultAppChecker.unBlockNotify();
                    });
                  },
                ),
              ),
              6.hSpace,
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.print.path,
                  context.l10n.print,
                  isVertical: true,
                  onTap: () async {
                    DefaultAppChecker.blockNotify();
                    await printFile();
                    DefaultAppChecker.unBlockNotify();
                  },
                ),
              ),
              6.hSpace,
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.detail.path,
                  context.l10n.detail,
                  isVertical: true,
                  onTap: () async {
                    AnalyticLogger.instance.logEventWithScreen(
                        event: BottomSheetEvent.user_click_detail);
                    await context.maybePop();
                    showFileDetailsBottomSheet(fileModel.file);
                  },
                ),
              ),
            ],
          ),
          32.vSpace,
          const Divider(color: AppColors.b7),
          32.vSpace,
          Row(
            children: [
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.mergePdf.path,
                  context.l10n.mergePDF,
                  onTap: () {
                    AnalyticLogger.instance.logEventWithScreen(
                        event: BottomSheetEvent.user_click_merge);
                    context.pushRoute(MergePdfRoute(pdfFile: fileModel.file));
                  },
                ),
              ),
              6.hSpace,
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.splitPdf.path,
                  context.l10n.splitPDF,
                  onTap: () {
                    AnalyticLogger.instance.logEventWithScreen(
                        event: BottomSheetEvent.user_click_split);
                    context.pushRoute(SplitPdfRoute(pdfModel: fileModel));
                  },
                ),
              ),
              6.hSpace,
              Expanded(
                child: (fileModel.isLock)
                    ? itemAction(
                        Assets.icons.bottomSheet.unlockPdf.path,
                        context.l10n.unlockPDF,
                        onTap: unLockPDF,
                      )
                    : itemAction(
                        Assets.icons.bottomSheet.lockPdf.path,
                        context.l10n.lockPDF,
                        onTap: lockPDF,
                      ),
              )
            ],
          ),
          32.vSpace,
          Row(
            children: [
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.pdfToImage.path,
                  context.l10n.pDFToImage,
                  onTap: () => context.pushRoute(
                    PdfToImagePreviewRoute(pdfModel: fileModel),
                  ),
                ),
              ),
              6.hSpace,
              Expanded(
                child: itemAction(
                  Assets.icons.bottomSheet.pdfToLongImage.path,
                  context.l10n.pdfToLongImages,
                  onTap: () => context.pushRoute(
                    PdfToImagePreviewRoute(pdfModel: fileModel, isLong: true),
                  ),
                ),
              ),
            ],
          ),
          32.vSpace,
          const Divider(color: AppColors.b7),
          20.vSpace,
          TextButton.icon(
            onPressed: () async {
              await context.maybePop();
              AnalyticLogger.instance.logEventWithScreen(
                  event: BottomSheetEvent.user_click_delete);
              const DialogWidget().show(
                  title: context.l10n.deleteIt,
                  confirmText: context.l10n.delete,
                  onDelete: () async {
                    final result = await FileSystemManager.instance
                        .deleteFile(fileModel.file);
                    if (result == true && context.mounted) {
                      getIt<PdfCubit>().deleteFile(fileModel);
                      widget.callBackDelete();
                    }
                    if (!fileModel.file.existsSync()) {
                      appContext.maybePop();
                      widget.callBackDelete();
                    }
                  });
            },
            icon: Assets.icons.delete.svg(width: 24),
            label: Text(
              context.l10n.deleteFromDevice,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAction(String icon, String action,
      {required VoidCallback onTap, bool isVertical = true}) {
    final content = [
      SvgPicture.asset(icon, width: 24),
      if (isVertical) 4.vSpace else 12.hSpace,
      Text(
        action,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: StyleUtils.style.medium.s14.copyWith(
          color: const Color(0xff404040),
        ),
      ),
    ];

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: isVertical ? Column(children: content) : Row(children: content),
    );
  }
}

Future<dynamic> showMenuPdfViewFile({
  required BuildContext context,
  required FileModel file,
  required TabBarType tabType,
  required BaseFileCubit baseFileCubit,
  Function(FileModel)? renameCallback,
  VoidCallback? callBackDelete,
}) {
  AnalyticLogger.instance
      .logEventWithScreen(event: BottomSheetEvent.user_click_open);
  return showModalBottomSheet<dynamic>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return MenuPdfBottomSheet(
        file: file,
        tabBarType: tabType,
        baseFileCubit: baseFileCubit,
        renameCallback: (file) => renameCallback?.call(file),
        callBackDelete: () => callBackDelete?.call(),
      );
    },
  );
}
