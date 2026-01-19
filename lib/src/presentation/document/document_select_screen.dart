import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../module/file_system/file_system_manage.dart';
import '../../../module/log_event_app/select_document_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/enum/language.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/utils/debouncer.dart';
import '../../shared/utils/share_util.dart';
import '../../shared/widgets/dialog/dialog_widget.dart';
import '../../shared/widgets/dialog/loading_dialog.dart';
import '../all_documents/cubit/all_file_cubit.dart';
import '../all_documents/cubit/base_cubit.dart';
import '../language/cubit/language_cubit.dart';
import 'cubit/sort_cubit.dart';
import 'widgets/item_folder_widget.dart';

@RoutePage()
class DocumentSelectScreen extends StatefulLoggableWidget {
  const DocumentSelectScreen({
    super.key,
    required this.tabBarType,
  });

  final TabBarType tabBarType;

  @override
  State<DocumentSelectScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentSelectScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ValueNotifier<bool> isSaveNotifier = ValueNotifier(false);
  late final BaseFileCubit cubit;

  @override
  void initState() {
    cubit = widget.tabBarType.valueCubit;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit.resetSelection();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BlocBuilder<BaseFileCubit, List<FileModel>>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(color: AppColors.divider, height: 1),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        icon: Assets.icons.icShare.svg(width: 24),
                        onPressed: () {
                          DeBouncer.run(() async {
                            final list = state
                                .where((e) => e.isSelect)
                                .toList()
                                .map((e) => e.file)
                                .toList();
                            if (list.isEmpty) {
                              AnalyticLogger.instance.logEventWithScreen(
                                  event: SelectDocumentEvent
                                      .user_click_share_notSelect);
                              return;
                            }
                            AnalyticLogger.instance.logEventWithScreen(
                                event: SelectDocumentEvent
                                    .user_click_share_selected);
                            final List<XFile> xFiles =
                                list.map((file) => XFile(file.path)).toList();
                            ShareUtil.shareFiles(xFiles);
                          });
                        },
                        label: Text(
                          context.l10n.share,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    10.hSpace,
                    Expanded(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: Colors.transparent,
                        ),
                        icon: Assets.icons.delete.svg(),
                        onPressed: () {
                          final list = state
                              .where((e) => e.isSelect)
                              .toList()
                              .map((e) => e.file)
                              .toList();
                          if (list.isEmpty) {
                            AnalyticLogger.instance.logEventWithScreen(
                                event: SelectDocumentEvent
                                    .user_click_delete_notSelect);
                          } else {
                            AnalyticLogger.instance.logEventWithScreen(
                                event: SelectDocumentEvent
                                    .user_click_delete_selected);
                          }

                          if (list.isNotEmpty) {
                            const DialogWidget().show(
                              title: context.l10n.deleteIt,
                              confirmText: context.l10n.delete,
                              onDelete: () async {
                                LoadingOverlay.show();
                                await FileSystemManager.instance
                                    .deleteListFile(list);
                                LoadingOverlay.hide();
                                getIt<AllFileCubit>().reloadFile();
                              },
                            );
                          }
                        },
                        label: Text(
                          context.l10n.delete,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CachedBannerAd(cachedAdUtil: BannerAllUtil.instance),
            ],
          );
        },
      ),
      body: BlocBuilder<BaseFileCubit, List<FileModel>>(
        bloc: cubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          AnalyticLogger.instance.logEventWithScreen(
                              event:
                                  SelectDocumentEvent.user_click_back_select);
                          if (cubit.selectedFileCount == 0) {
                            getIt<AppRouter>().maybePop();
                          } else {
                            const DialogWidget().show(
                              title: context.l10n.exitAndDiscard,
                              confirmText: context.l10n.discard,
                              onDelete: getIt<AppRouter>().back,
                            );
                          }
                        },
                        child: Assets.icons.icClose.svg()),
                    Text(() {
                      final currentLanguage =
                          context.read<LanguageCubit>().state.language;
                      final isPtBr =
                          currentLanguage == Languages.brazilianPortuguese;

                      return context.l10n
                              .fileSelected(cubit.selectedFileCount) +
                          (isPtBr && cubit.selectedFileCount > 1 ? 's' : '');
                    }()),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (state.isEmpty) {
                          AnalyticLogger.instance.logEventWithScreen(
                              event: SelectDocumentEvent.user_select_all_file);
                        } else {
                          AnalyticLogger.instance.logEventWithScreen(
                              event:
                                  SelectDocumentEvent.user_unSelect_all_file);
                        }
                        cubit.toggleCheckAll();
                      },
                      child: SizedBox(
                        height: 30,
                        child: cubit.isCheckAll
                            ? Assets.icons.checkboxFill
                                .svg(width: 24, height: 24)
                            : Assets.icons.icCheckBoxOff
                                .svg(width: 24, height: 24),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<SortCubit, SortType>(
                    builder: (context, stateSort) {
                      final currentFiles = SortType.sortFiles(state, stateSort);
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final indexState =
                              state.indexWhere((e) => e == currentFiles[index]);
                          return ItemFolderWidget(
                            itemFolderType: ItemFolderType.itemCheckBox,
                            tabBarType: widget.tabBarType,
                            isCheck: state[indexState].isSelect,
                            fileModel: currentFiles[index],
                            onTapSaveOrCheckBox: () {
                              cubit.toggleSelection(indexState);
                            },
                            onTapOpenFile: () {},
                          );
                        },
                        itemCount: state.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
