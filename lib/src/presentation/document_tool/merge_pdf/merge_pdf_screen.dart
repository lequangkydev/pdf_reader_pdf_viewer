import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../../module/admob/utils/native_all_util.dart';
import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../../module/admob/widget/ads/native_all_ad.dart';
import '../../../../module/log_event_app/merge_pdf_event.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/extension/string_extension.dart';
import '../../../shared/widgets/app_bar/search_app_bar.dart';
import '../../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../../shared/widgets/bottom_sheet/rename_bottom_sheet.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../../../shared/widgets/loading/indicator_loading.dart';
import '../../all_documents/cubit/pdf_cubit.dart';
import '../cubit/pdf_list_cubit.dart';
import '../widget/pdf_item.dart';
import 'cubit/merge_pdf_cubit.dart';
import 'cubit/merge_pdf_state.dart';

@RoutePage()
class MergePdfScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const MergePdfScreen({
    super.key,
    this.pdfFile,
    this.password,
  });

  final File? pdfFile;
  final String? password;

  @override
  State<MergePdfScreen> createState() => _MergePdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MergePdfCubit(),
        ),
        BlocProvider(
          create: (context) => PdfListCubit()..fetchPdf(file: pdfFile),
        ),
      ],
      child: this,
    );
  }
}

class _MergePdfScreenState extends State<MergePdfScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pdfFile != null) {
        handleLockedPdf();
      }
    });
  }

  Future<void> handleLockedPdf() async {
    if (widget.pdfFile == null) {
      return;
    }
    final bytes = widget.pdfFile!.readAsBytesSync();
    try {
      PdfDocument(inputBytes: bytes);
      context.read<MergePdfCubit>().toggleSelection(
            file: widget.pdfFile,
            isFirst: true,
          );
    } catch (e) {
      if (e is ArgumentError && e.message.contains('password')) {
        final password = await showPasswordBottomSheet(
          pdfFile: widget.pdfFile,
          typePassword: TypePassword.enter,
          isOpen: false,
        );
        if (password.isValid && mounted) {
          context.read<MergePdfCubit>().toggleSelection(
                file: widget.pdfFile,
                password: password,
                isFirst: true,
              );
        } else {
          context.maybePop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${context.l10n.anError}$e')),
          );
        }
      }
    }
  }

  Future<void> handlePdfProtection(File filePdf) async {
    final existFile = context.read<MergePdfCubit>().isExistFile(filePdf);
    //remove khỏi list
    if (existFile != null) {
      context.read<MergePdfCubit>().toggleSelection(file: filePdf);
      return;
    }

    // Kiểm tra xem file có bị khóa không
    final isProtected =
        context.read<MergePdfCubit>().isProtectPdf(file: filePdf);

    if (isProtected) {
      // Nếu file bị khóa, hiển thị bottom sheet để người dùng nhập mật khẩu
      final password = await showPasswordBottomSheet(
        pdfFile: filePdf,
        typePassword: TypePassword.enter,
        isOpen: false,
      );

      // Nếu người dùng nhập mật khẩu
      if (password != null && password.isNotEmpty) {
        // Kiểm tra lại file với mật khẩu đã nhập
        final isProtectedWithPassword = context
            .read<MergePdfCubit>()
            .isProtectPdf(file: filePdf, password: password);

        // Nếu file không còn bị khóa, thêm file vào danh sách
        if (!isProtectedWithPassword) {
          context
              .read<MergePdfCubit>()
              .toggleSelection(file: filePdf, password: password);
        }
      }
    } else {
      // Nếu file không bị khóa, thêm file vào danh sách
      context.read<MergePdfCubit>().toggleSelection(file: filePdf);
    }
  }

  Future<void> _mergePdf(
      BuildContext context, MergePdfCubit cubit, String newName) async {
    LoadingOverlay.show();
    try {
      final resultFile = await cubit.mergePDF(newName);
      LoadingOverlay.hide();

      if (resultFile != null && context.mounted) {
        final fileModel = FileModel(id: const Uuid().v1(), file: resultFile);
        getIt<PdfCubit>().addFile(fileModel);
        context.replaceRoute(
          FileSuccessRoute(
            fileModel: fileModel,
            title: context.l10n.mergePdfSuccess,
          ),
        );
      }
    } catch (e) {
      LoadingOverlay.hide();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            context.l10n.tryAnotherFile,
            style: const TextStyle(color: Colors.red),
          )),
        );
      }
    }
  }

  Future<void> _handleMergeButtonPress(
      BuildContext context, MergePdfState state) async {
    if (state.selectedFiles.length < 2) {
      return;
    }

    final cubit = context.read<MergePdfCubit>();

    if (!state.isMerging) {
      cubit.toggleMerge();
      return;
    }
    AnalyticLogger.instance
        .logEventWithScreen(event: MergePdfEvent.user_click_button_merge);
    final newName = await showRenameDialog(
      context: context,
      defaultName: context.l10n.mergePDF,
    );
    if (newName == null) {
      return;
    }

    await _mergePdf(context, cubit, newName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MergePdfCubit, MergePdfState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              return;
            }
            if (Global.instance.isFullAds) {
              await InterFileBackTabUtil.instance.show(
                enable: InterFileBackTabUtil.instance.config.interBack,
                nativeFullConfig: adUnitsConfig.nativeFullInterBack,
              );
            }
            Navigator.pop(context);
          },
          child: Scaffold(
            appBar: SearchAppBar(
              key: searchKey,
              title: context.l10n.mergePDF,
              onSearchChanged: (value) =>
                  context.read<PdfListCubit>().searchPdf(query: value),
              onSearchDone: (value) => context
                  .read<PdfListCubit>()
                  .searchPdf(query: value, isDone: true),
              actionWidget: state.isMerging
                  ? IconButton(
                      onPressed: () {
                        context.read<MergePdfCubit>().toggleMerge();
                        AnalyticLogger.instance.logEventWithScreen(
                            event: MergePdfEvent.user_click_add_file_merge);
                      },
                      icon: const Icon(Icons.add, size: 24),
                      color: AppColors.pr,
                    )
                  : null,
              onBack: () async {
                AnalyticLogger.instance.logEventWithScreen(
                    event: MergePdfEvent.user_click_back_merge);
                context.maybePop();
              },
              tapSearch: () {
                AnalyticLogger.instance.logEventWithScreen(
                    event: MergePdfEvent.user_click_search_merge);
              },
            ),
            body: BlocBuilder<MergePdfCubit, MergePdfState>(
              builder: (context, state) {
                if (state.isMerging) {
                  return buildReorderListView(state.selectedFiles);
                }
                return BlocBuilder<PdfListCubit, PdfListState>(
                  builder: (context, state) {
                    return _buildPdfList();
                  },
                );
              },
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: FilledButton(
                    onPressed: () {
                      context.read<PdfListCubit>().searchPdf(query: '');
                      searchKey.currentState?.closeSearch();
                      _handleMergeButtonPress(context, state);
                      if (state.selectedFiles.length > 1) {
                        AnalyticLogger.instance.logEventWithScreen(
                            event: MergePdfEvent.user_click_continue_selected);
                      } else {
                        AnalyticLogger.instance.logEventWithScreen(
                            event: MergePdfEvent.user_click_continue_notSelect);
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: state.selectedFiles.length > 1
                          ? AppColors.pr
                          : AppColors.b15,
                    ),
                    child: Text(state.isMerging
                        ? context.l10n.merge
                        : '(${state.selectedFiles.length}) ${context.l10n.continuePer}'),
                  ),
                ),
                if (state.isMerging)
                  CachedBannerAd(
                    cachedAdUtil: BannerAllUtil.instance,
                  )
                else
                  BlocBuilder<PdfListCubit, PdfListState>(
                      builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      loaded: (data) {
                        if (data.isNotEmpty && data.length >= 3) {
                          return NativeAllAd(
                            isAdEnabled:
                                NativeAllUtil.instance.config.nativePdfToolList,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPdfList() {
    return BlocBuilder<PdfListCubit, PdfListState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const IndicatorLoading(),
          loaded: (data) {
            if (data.isEmpty) {
              return Center(child: Text(context.l10n.empty));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    context.l10n.guideMerge,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.color80,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final filePdf = data[index];
                      return GestureDetector(
                        onTap: () {
                          if (context
                                  .read<MergePdfCubit>()
                                  .isExistFile(filePdf.file) !=
                              null) {
                            AnalyticLogger.instance.logEventWithScreen(
                                event:
                                    MergePdfEvent.user_click_remove_file_merge);
                          } else {
                            AnalyticLogger.instance.logEventWithScreen(
                                event: MergePdfEvent.user_select_file_merge);
                          }
                          // searchKey.currentState?.closeSearch();
                          handlePdfProtection(filePdf.file);
                        },
                        child: PdfItem(
                          pdfFile: filePdf.file,
                          isLock: filePdf.isLock,
                          trailing: SvgPicture.asset(
                            context.read<MergePdfCubit>().state.isMerging
                                ? Assets.icons.delete.path
                                : (context
                                            .read<MergePdfCubit>()
                                            .isExistFile(filePdf.file) !=
                                        null
                                    ? Assets.icons.checkboxFill.path
                                    : Assets.icons.unCheckbox.path),
                            width: 20,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(left: 44 + 32, right: 16),
                      child: Divider(
                        color: Color(0xffF2F2F2),
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget buildReorderListView(List<PdfFileWithPassword> selectedFiles) {
    return ReorderableListView(
      children: [
        for (var index = 0; index < selectedFiles.length; index++)
          buildItemReorder(selectedFiles[index].file),
      ],
      onReorder: (int oldIndex, int newIndex) {
        AnalyticLogger.instance
            .logEventWithScreen(event: MergePdfEvent.user_press_move_file);
        context.read<MergePdfCubit>().reorderFiles(oldIndex, newIndex);
      },
    );
  }

  Widget buildItemReorder(File file) {
    final cubit = context.read<MergePdfCubit>();
    final state = cubit.state;
    return PdfItem(
      key: Key(file.path),
      pdfFile: file,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.isMerging) ...[Assets.icons.menu.svg(width: 24), 4.hSpace],
          SvgPicture.asset(Assets.icons.file.pdf.path, width: 44),
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          cubit.removeFile(file);
          AnalyticLogger.instance.logEventWithScreen(
              event: MergePdfEvent.user_click_remove_file_merge);
        },
        child: SvgPicture.asset(
          Assets.icons.delete.path,
          width: 20,
        ),
      ),
    );
  }
}
