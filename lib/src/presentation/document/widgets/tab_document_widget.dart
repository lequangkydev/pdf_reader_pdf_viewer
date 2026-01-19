import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../module/file_system/file_system_manage.dart';
import '../../../../module/log_event_app/bookmark_event.dart';
import '../../../../module/log_event_app/document_event.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../data/model/file_model.dart';
import '../../../shared/enum/app_enum.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/utils/file_utils.dart';
import '../../../shared/utils/toast_util.dart';
import '../../../shared/widgets/bottom_sheet/action_file_bottom_sheet.dart';
import '../../all_documents/cubit/all_file_cubit.dart';
import '../../all_documents/cubit/base_cubit.dart';
import '../cubit/sort_cubit.dart';
import '../document_screen.dart';
import 'item_folder_widget.dart';

class TabDocumentWidget extends StatefulWidget {
  const TabDocumentWidget({
    super.key,
    required this.tabBarType,
    required this.documentType,
    this.fromDocumentScreen = false,
  });

  final TabBarType tabBarType;
  final DocumentType documentType;
  final bool fromDocumentScreen;

  @override
  State<TabDocumentWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabDocumentWidget>
    with AutomaticKeepAliveClientMixin {
  late final BaseFileCubit cubit;

  @override
  void initState() {
    cubit = widget.tabBarType.valueCubit;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BaseFileCubit, List<FileModel>>(
      bloc: cubit,
      builder: (context, state) {
        if (state.isEmpty) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ItemFolderWidget(
                  itemFolderType: ItemFolderType.itemSave,
                  tabBarType: widget.tabBarType,
                  fileModel: FileModel(file: File(''), id: ''),
                  onTapSaveOrCheckBox: () {
                    ToastUtil.showMess(mess: context.l10n.thisSampleFile);
                  },
                  onTapOpenFile: () {
                    ToastUtil.showMess(mess: context.l10n.thisSampleFile);
                  },
                  onTapThreeDot: () {
                    ToastUtil.showMess(mess: context.l10n.thisSampleFile);
                  },
                  isSample: true,
                  isBookmark: widget.documentType == DocumentType.bookmark,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<AllFileCubit>().reloadFile(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<SortCubit, SortType>(
              builder: (context, stateSort) {
                final List<FileModel> fileModels = state;
                final sortedFiles = SortType.sortFiles(fileModels, stateSort);
                final validFiles = sortedFiles.where((currentFile) {
                  return !(widget.documentType == DocumentType.bookmark &&
                      !currentFile.isBookmark);
                }).toList();
                if (validFiles.isEmpty) {
                  return Column(
                    children: [
                      ItemFolderWidget(
                        itemFolderType: ItemFolderType.itemSave,
                        tabBarType: widget.tabBarType,
                        fileModel: FileModel(file: File(''), id: ''),
                        onTapSaveOrCheckBox: () {
                          ToastUtil.showMess(mess: context.l10n.thisSampleFile);
                        },
                        onTapOpenFile: () {
                          ToastUtil.showMess(mess: context.l10n.thisSampleFile);
                        },
                        onTapThreeDot: () {
                          ToastUtil.showMess(mess: context.l10n.thisSampleFile);
                        },
                        isSample: true,
                        isBookmark:
                            widget.documentType == DocumentType.bookmark,
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    var type = widget.tabBarType;
                    if (type == TabBarType.all) {
                      type = FileSystemManager.instance
                          .getTypeFile(validFiles[index].file);
                    }
                    final currentFile = validFiles[index];
                    return ItemFolderWidget(
                      itemFolderType: ItemFolderType.itemSave,
                      tabBarType: type,
                      isCheck: currentFile.isBookmark,
                      fileModel: currentFile,
                      onTapSaveOrCheckBox: () async {
                        if (widget.fromDocumentScreen) {
                          AnalyticLogger.instance.logEventWithScreen(
                            event:
                                DocumentEvent.user_click_icon_bookmark_document,
                          );
                        } else {
                          AnalyticLogger.instance.logEventWithScreen(
                            event:
                                BookmarkEvent.user_click_icon_bookmark_bookmark,
                          );
                        }
                        final cubit =
                            widget.tabBarType.getCubitForFile(currentFile.file);
                        if (cubit != null) {
                          await cubit.toggleBookmark(
                            currentFile.file,
                          );
                        }
                      },
                      onTapThreeDot: () async {
                        if (widget.fromDocumentScreen) {
                          AnalyticLogger.instance.logEventWithScreen(
                            event:
                                DocumentEvent.user_click_icon_expand_document,
                          );
                        } else {
                          AnalyticLogger.instance.logEventWithScreen(
                            event:
                                BookmarkEvent.user_click_icon_expand_bookmark,
                          );
                        }
                        await showActionFileBottomSheet(
                          context: context,
                          file: currentFile,
                          tabType: type,
                        );
                      },
                      onTapOpenFile: () async {
                        if (widget.fromDocumentScreen) {
                          AnalyticLogger.instance.logEventWithScreen(
                            event: DocumentEvent.user_click_open_file_document,
                          );
                        } else {
                          AnalyticLogger.instance.logEventWithScreen(
                            event: BookmarkEvent.user_click_open_file_bookmark,
                          );
                        }
                        FileUtils.openFileRoute(
                            context, currentFile, type, true);
                      },
                    );
                  },
                  itemCount: validFiles.length,
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(left: 52),
                    child: Divider(
                      color: Color(0xffF2F2F2),
                      height: 0,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
