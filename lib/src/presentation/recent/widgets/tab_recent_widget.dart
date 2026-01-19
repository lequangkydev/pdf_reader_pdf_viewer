import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../module/file_system/file_system_manage.dart';
import '../../../../module/log_event_app/recent_event.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../data/model/file_model.dart';
import '../../../shared/enum/app_enum.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/helpers/logger_utils.dart';
import '../../../shared/utils/file_utils.dart';
import '../../../shared/utils/style_utils.dart';
import '../../../shared/utils/toast_util.dart';
import '../../../shared/widgets/bottom_sheet/action_file_bottom_sheet.dart';
import '../../all_documents/cubit/all_file_cubit.dart';
import '../../all_documents/cubit/base_cubit.dart';
import '../../document/cubit/sort_cubit.dart';
import '../../document/widgets/item_folder_widget.dart';

class TabRecentWidget extends StatefulLoggableWidget {
  const TabRecentWidget({
    super.key,
    required this.onFilter,
    required this.onAll,
    required this.tabBarType,
  });

  final VoidCallback onFilter;
  final VoidCallback onAll;
  final TabBarType tabBarType;

  @override
  State<TabRecentWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabRecentWidget>
    with AutomaticKeepAliveClientMixin {
  late final BaseFileCubit cubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    cubit = widget.tabBarType.valueCubit;
  }

  List<List<FileModel>> categorizeFiles(List<FileModel> files) {
    final List<FileModel> limitedFiles = files.take(20).toList();

    final DateTime now = DateTime.now();
    final DateTime startOfToday = DateTime(now.year, now.month, now.day);
    final DateTime startOfYesterday =
        startOfToday.subtract(const Duration(days: 1));

    final List<FileModel> today = [];
    final List<FileModel> yesterday = [];
    final List<FileModel> last7Days = [];
    final List<FileModel> lastMonth = [];

    for (final file in limitedFiles) {
      DateTime lastModifiedDate = DateTime.now();
      try {
        lastModifiedDate = file.file.lastModifiedSync();
      } catch (e) {
        logger.e(e);
      }
      if (lastModifiedDate.isAfter(startOfToday)) {
        today.add(file);
      } else if (lastModifiedDate.isAfter(startOfYesterday) &&
          lastModifiedDate.isBefore(startOfToday)) {
        yesterday.add(file);
      } else if (lastModifiedDate
          .isAfter(now.subtract(const Duration(days: 7)))) {
        last7Days.add(file);
      } else if (lastModifiedDate
          .isAfter(now.subtract(const Duration(days: 30)))) {
        lastMonth.add(file);
      }
    }
    return [today, yesterday, last7Days, lastMonth];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<BaseFileCubit, List<FileModel>>(
        bloc: cubit,
        builder: (context, state) {
          final fileModels = SortType.sortFiles(state, SortType.timeNewOld);
          final List<FileModel> files = fileModels.map((fileModel) {
            return fileModel;
          }).toList();
          final categorizedFiles = categorizeFiles(files);
          final List<Map<String, List<FileModel>>> sections = [
            {context.l10n.today: categorizedFiles[0]},
            {context.l10n.yesterday: categorizedFiles[1]},
            {context.l10n.last7Day: categorizedFiles[2]},
            {context.l10n.monthAgo: categorizedFiles[3]},
          ];

          return RefreshIndicator(
            onRefresh: () => context.read<AllFileCubit>().reloadFile(),
            child: Column(
              children: [
                if (state.isEmpty || sections.isEmpty)
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
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: sections.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox.shrink(),
                      itemBuilder: (context, sectionIndex) {
                        final section = sections[sectionIndex];
                        final title = section.keys.first;
                        final files = section[title]!;
                        if (files.isEmpty) {
                          if (sectionIndex != 0) {
                            return const SizedBox();
                          }
                          return ItemFolderWidget(
                            itemFolderType: ItemFolderType.itemSave,
                            tabBarType: widget.tabBarType,
                            fileModel: FileModel(file: File(''), id: ''),
                            onTapSaveOrCheckBox: () {
                              ToastUtil.showMess(
                                  mess: context.l10n.thisSampleFile);
                            },
                            onTapOpenFile: () {
                              ToastUtil.showMess(
                                  mess: context.l10n.thisSampleFile);
                            },
                            onTapThreeDot: () {
                              ToastUtil.showMess(
                                  mess: context.l10n.thisSampleFile);
                            },
                            isSample: true,
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (files.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title,
                                  style: StyleUtils.style.b65.s12,
                                ),
                              ),
                              ...files.map((file) {
                                var type = widget.tabBarType;
                                if (widget.tabBarType == TabBarType.all) {
                                  type = FileSystemManager.instance
                                      .getTypeFile(file.file);
                                }
                                return ItemFolderWidget(
                                  itemFolderType: ItemFolderType.itemSave,
                                  tabBarType: type,
                                  fileModel: file,
                                  isCheck: file.isBookmark,
                                  onTapSaveOrCheckBox: () async {
                                    AnalyticLogger.instance.logEventWithScreen(
                                      event: RecentEvent
                                          .user_click_icon_bookmark_recent,
                                    );
                                    await cubit.toggleBookmark(file.file);
                                  },
                                  onTapThreeDot: () async {
                                    AnalyticLogger.instance.logEventWithScreen(
                                      event: RecentEvent
                                          .user_click_icon_expand_recent,
                                    );
                                    await showActionFileBottomSheet(
                                      context: context,
                                      file: file,
                                      tabType: type,
                                    );
                                  },
                                  onTapOpenFile: () {
                                    AnalyticLogger.instance.logEventWithScreen(
                                      event: RecentEvent
                                          .user_click_open_file_recent,
                                    );
                                    FileUtils.openFileRoute(
                                        context, file, type, true);
                                  },
                                );
                              }),
                            ],
                          ],
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
}
