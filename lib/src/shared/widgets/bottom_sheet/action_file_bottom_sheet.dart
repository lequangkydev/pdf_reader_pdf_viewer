import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

import '../../../../module/file_system/file_system_manage.dart';
import '../../../../module/log_event_app/bottom_sheet_event.dart';
import '../../../../module/log_event_app/screen_event_enum.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../presentation/all_documents/cubit/base_cubit.dart';
import '../../../presentation/document/widgets/item_folder_widget.dart';
import '../../../presentation/document_tool/utils/pdf_util.dart';
import '../../../services/default_app_checker.dart';
import '../../enum/app_enum.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';
import '../../utils/debouncer.dart';
import '../../utils/share_util.dart';
import '../../utils/style_utils.dart';
import '../../utils/utils.dart';
import '../dialog/dialog_rename.dart';
import '../dialog/dialog_widget.dart';
import '../dialog/loading_dialog.dart';
import 'file_details_bottom_sheet.dart';
import 'password_bottom_sheet.dart';

class ActionFileBottomSheet extends StatefulLoggableWidget {
  const ActionFileBottomSheet({
    super.key,
    required this.file,
    required this.tabBarType,
    required this.callBack,
    required this.callBackDelete,
  });

  final FileModel file;
  final TabBarType tabBarType;
  final Function(FileModel) callBack;
  final VoidCallback callBackDelete;

  @override
  _ActionFileBottomSheetState createState() => _ActionFileBottomSheetState();
}

class _ActionFileBottomSheetState extends State<ActionFileBottomSheet> {
  late FileModel fileModel;
  TabBarType type = TabBarType.all;
  BaseFileCubit? baseFileCubit;

  @override
  void initState() {
    super.initState();
    fileModel = widget.file;
    baseFileCubit = widget.tabBarType.getCubitForFile(widget.file.file);
    if (widget.tabBarType == TabBarType.all) {
      type = FileSystemManager.instance.getTypeFile(fileModel.file);
    }
    type = widget.tabBarType;
  }

  Future<void> unLockPDF() async {
    await context.maybePop(); //pop bottom menu
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

    if (pass != null) {
      await Future.delayed(const Duration(milliseconds: 200));
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
      baseFileCubit?.updateFile(newFileModel);
      LoadingOverlay.hide();
      if (appContext.mounted) {
        appContext.pushRoute(
          FileSuccessRoute(
            fileModel: newFileModel,
            title: appContext.l10n.unlockPdfSuccess,
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
    if (pass != null) {
      await Future.delayed(const Duration(milliseconds: 200));
      LoadingOverlay.show();
      final newFile =
          await PdfUtil.setPasswordPdf(file: fileModel.file, password: pass);

      if (newFile == null) {
        LoadingOverlay.hide();
        return;
      }
      final newFileModel = fileModel.copyWith(
        file: newFile,
        isLock: true,
      );
      baseFileCubit?.updateFile(newFileModel);
      LoadingOverlay.hide();
      if (appContext.mounted) {
        currentCtx.pushRoute(
          FileSuccessRoute(
            fileModel: newFileModel,
            title: currentCtx.l10n.lockPdfSuccess,
          ),
        );
      }
    }
  }

  Future<void> printFile() async {
    AnalyticLogger.instance
        .logEventWithScreen(event: BottomSheetEvent.user_click_print);
    DeBouncer.run(() async {
      if (type == TabBarType.pdf) {
        if (fileModel.isLock) {
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

  Future<void> _handleAction(AppEvent event, VoidCallback action) async {
    AnalyticLogger.instance.logEventWithScreen(event: event);
    await context.maybePop();
    action();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 32,
              decoration: BoxDecoration(
                color: const Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ItemFolderWidget(
            fileModel: fileModel,
            tabBarType: type,
            onTapThreeDot: () {},
            showThreeDot: false,
            inBottomSheet: true,
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
          const Divider(color: Color(0xffF2F2F2)),
          20.vSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: itemAction(
                  isVertical: true,
                  Assets.icons.bottomSheet.rename.path,
                  context.l10n.rename,
                  onTap: () => _handleAction(BottomSheetEvent.user_click_rename,
                      () async {
                    final result = await const DialogRename().show(
                      defaultName:
                          path.basenameWithoutExtension(fileModel.file.path),
                      file: fileModel,
                    );

                    if (result != null && result is FileModel) {
                      //cần lấy file cũ
                      if (Global.instance.sharedFiles != null) {
                        final exactFile = baseFileCubit
                            ?.findFileByName(Global.instance.sharedFiles!.path);
                        if (exactFile != null) {
                          //cập nhật tên mới
                          final newFile =
                              await FileSystemManager.instance.renameFile(
                            exactFile,
                            path.basenameWithoutExtension(result.file.path),
                          );
                          if (newFile == null) {
                            return;
                          }

                          baseFileCubit?.updateFile(newFile);
                        } else {
                          baseFileCubit?.updateFile(result);
                        }
                        widget.callBack(result);
                      } else {
                        baseFileCubit?.updateFile(result);
                        widget.callBack(result);
                      }
                    }
                  }),
                ),
              ),
              6.hSpace,
              Expanded(
                child: itemAction(
                  isVertical: true,
                  Assets.icons.bottomSheet.share.path,
                  context.l10n.share,
                  onTap: () async {
                    DefaultAppChecker.blockNotify();
                    AnalyticLogger.instance.logEventWithScreen(
                        event: BottomSheetEvent.user_click_share);
                    await context.maybePop();
                    DeBouncer.run(() async {
                      await ShareUtil.shareFiles([XFile(fileModel.file.path)]);
                      DefaultAppChecker.unBlockNotify();
                    });
                  },
                ),
              ),
              if (type == TabBarType.pdf) ...[
                6.hSpace,
                Expanded(
                  child: itemAction(
                    isVertical: true,
                    Assets.icons.bottomSheet.print.path,
                    context.l10n.print,
                    onTap: () async {
                      await context.maybePop();
                      printFile();
                    },
                  ),
                ),
              ],
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
          20.vSpace,
          const Divider(color: Color(0xffF2F2F2)),
          20.vSpace,
          if (type == TabBarType.pdf) ...[
            itemAction(
              Assets.icons.bottomSheet.mergePdf.path,
              context.l10n.mergePDF,
              onTap: () async {
                AnalyticLogger.instance.logEventWithScreen(
                    event: BottomSheetEvent.user_click_merge);
                await context.maybePop();
                if (appContext.mounted) {
                  appContext.pushRoute(
                    MergePdfRoute(
                      pdfFile: fileModel.file,
                    ),
                  );
                }
              },
            ),
            24.vSpace,
            itemAction(
              Assets.icons.bottomSheet.splitPdf.path,
              context.l10n.splitPDF,
              onTap: () async {
                AnalyticLogger.instance.logEventWithScreen(
                    event: BottomSheetEvent.user_click_split);
                await context.maybePop();
                if (appContext.mounted) {
                  context.pushRoute(SplitPdfRoute(pdfModel: fileModel));
                }
              },
            ),
            24.vSpace,
            itemAction(
              fileModel.isLock
                  ? Assets.icons.bottomSheet.unlockPdf.path
                  : Assets.icons.bottomSheet.lockPdf.path,
              fileModel.isLock ? context.l10n.unlockPDF : context.l10n.lockPDF,
              onTap: () async {
                if (fileModel.isLock) {
                  unLockPDF();
                } else {
                  lockPDF();
                }
              },
            ),
            24.vSpace,
            itemAction(
              Assets.icons.bottomSheet.pdfToImage.path,
              context.l10n.pdfToImages,
              onTap: () async {
                AnalyticLogger.instance.logEventWithScreen(
                    event: BottomSheetEvent.user_click_convert);
                await context.maybePop();

                if (appContext.mounted) {
                  appContext.pushRoute(PdfToImagePreviewRoute(
                    pdfModel: fileModel,
                  ));
                }
              },
            ),
            24.vSpace,
            itemAction(
              Assets.icons.bottomSheet.pdfToLongImage.path,
              context.l10n.pdfToLongImages,
              onTap: () async {
                AnalyticLogger.instance.logEventWithScreen(
                    event: BottomSheetEvent.user_click_convert);
                await context.maybePop();
                if (appContext.mounted) {
                  appContext.pushRoute(PdfToImagePreviewRoute(
                      pdfModel: fileModel, isLong: true));
                }
              },
            ),
          ],
          if (type == TabBarType.pdf) ...[
            20.vSpace,
            const Divider(color: Color(0xffF2F2F2)),
          ],
          TextButton.icon(
            onPressed: () async {
              await context.maybePop();
              AnalyticLogger.instance.logEventWithScreen(
                  event: BottomSheetEvent.user_click_delete);
              if (appContext.mounted) {
                const DialogWidget().show(
                  title: appContext.l10n.deleteIt,
                  confirmText: appContext.l10n.delete,
                  onDelete: () async {
                    final result = await FileSystemManager.instance
                        .deleteFile(fileModel.file);
                    if (result == true) {
                      baseFileCubit?.deleteFile(fileModel);
                      widget.callBackDelete();
                    }
                    if (!fileModel.file.existsSync()) {
                      widget.callBackDelete();
                    }
                  },
                );
              }
            },
            label: Text(
              context.l10n.deleteFromDevice,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            icon: Assets.icons.delete.svg(),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  Widget itemAction(String icon, String action,
      {required VoidCallback onTap, bool isVertical = false}) {
    final content = [
      8.hSpace,
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

Future<String?> showActionFileBottomSheet({
  required BuildContext context,
  required FileModel file,
  required TabBarType tabType,
  Function(FileModel)? callBack,
  VoidCallback? callBackDelete,
}) async {
  AnalyticLogger.instance
      .logEventWithScreen(event: BottomSheetEvent.user_click_open);
  return showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return ActionFileBottomSheet(
        file: file,
        tabBarType: tabType,
        callBack: (file) => callBack?.call(file),
        callBackDelete: () => callBackDelete?.call(),
      );
    },
  );
}
