import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/utils/file_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../module/file_system/file_system_manage.dart';
import '../../../module/log_event_app/search_event.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../presentation/all_documents/cubit/all_file_cubit.dart';
import '../../presentation/document/widgets/item_folder_widget.dart';
import '../enum/app_enum.dart';
import '../extension/context_extension.dart';
import '../extension/number_extension.dart';
import '../utils/style_utils.dart';
import '../widgets/bottom_sheet/action_file_bottom_sheet.dart';
import '../widgets/empty_data.dart';
import '../widgets/input_search/input_search.dart';

@RoutePage()
class SearchScreen extends StatefulLoggableWidget {
  const SearchScreen({
    super.key,
    required this.tabBarType,
  });

  final TabBarType tabBarType;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String textSearch = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CachedBannerAd(cachedAdUtil: BannerAllUtil.instance),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: context.maybePop,
                    child: Assets.icons.arrowBack.svg(),
                  ),
                  12.hSpace,
                  Expanded(
                    child: InputSearch(onChanged: (value) {
                      setState(() {
                        textSearch = value;
                      });
                    }),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<AllFileCubit, List<FileModel>>(
                  builder: (context, state) {
                    List<FileModel> listSearch = state.map((fileModel) {
                      return fileModel;
                    }).toList();
                    if (textSearch.isNotEmpty) {
                      listSearch = listSearch
                          .where((element) => path
                              .basename(element.file.path)
                              .toLowerCase()
                              .contains(textSearch.toLowerCase()))
                          .toList();
                    } else {
                      listSearch = state
                          .map((fileModel) {
                            return fileModel;
                          })
                          .toList()
                          .sublist(0, state.length > 5 ? 5 : state.length);
                    }
                    if (listSearch.isEmpty) {
                      return const EmptyData();
                    }

                    return Column(
                      children: [
                        const SizedBox(height: 8),
                        Text(context.l10n.valueResults(listSearch.length),
                            style: StyleUtils.style.s14.regular.b50),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemBuilder: (context, index) {
                              final type = FileSystemManager.instance
                                  .getTypeFile(listSearch[index].file);
                              return ItemFolderWidget(
                                tabBarType: type,
                                fileModel: listSearch[index],
                                onTapThreeDot: () async {
                                  AnalyticLogger.instance.logEventWithScreen(
                                      event: SearchEvent
                                          .user_click_icon_additional_options);
                                  await showActionFileBottomSheet(
                                    context: context,
                                    file: listSearch[index],
                                    tabType: type,
                                  );
                                },
                                onTapSaveOrCheckBox: () async {
                                  AnalyticLogger.instance.logEventWithScreen(
                                      event:
                                          SearchEvent.user_click_icon_bookmark);
                                  await type.valueCubit
                                      .toggleBookmark(listSearch[index].file);
                                },
                                onTapOpenFile: () {
                                  AnalyticLogger.instance.logEventWithScreen(
                                      event: SearchEvent.user_open_file_search);
                                  FileUtils.openFileRoute(
                                      context, listSearch[index], type, true);
                                },
                                itemFolderType: ItemFolderType.itemSave,
                              );
                            },
                            itemCount: listSearch.length,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
