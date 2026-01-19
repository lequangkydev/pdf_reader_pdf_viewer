import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../module/log_event_app/bookmark_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../shared/cubit/shell_document_tab_cubit.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../shared/widgets/storage_permission_widget.dart';
import '../../shared/widgets/tabbar_widget/tabbar_widget.dart';
import '../document/document_screen.dart';
import '../document/widgets/tab_document_widget.dart';
import '../permission/cubit/storage_status_cubit.dart';

class BookmarkScreen extends StatefulLoggableWidget {
  const BookmarkScreen({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<BookmarkScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<BookmarkScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: TabBarType.values.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final newIndex = _tabController.index;
        if (newIndex == 0) {
          AnalyticLogger.instance.logEventWithScreen(
            event: BookmarkEvent.user_click_all_bookmark,
          );
        }
        if (newIndex == 1) {
          AnalyticLogger.instance.logEventWithScreen(
            event: BookmarkEvent.user_click_pdf_bookmark,
          );
        }
        if (newIndex == 2) {
          AnalyticLogger.instance.logEventWithScreen(
            event: BookmarkEvent.user_click_doc_bookmark,
          );
        }
        if (newIndex == 3) {
          AnalyticLogger.instance.logEventWithScreen(
            event: BookmarkEvent.user_click_xlsx_bookmark,
          );
        }
        if (newIndex == 4) {
          AnalyticLogger.instance.logEventWithScreen(
            event: BookmarkEvent.user_click_ppt_bookmark,
          );
        }
      }
    });
    // đổi màu header theo tab đang chọn
    context
        .read<ShellDocumentTabCubit>()
        .update(TabBarType.values[_tabController.index]);
    widget.pageController.addListener(() {
      if (widget.pageController.page == BottomTab.bookmark.index) {
        context
            .read<ShellDocumentTabCubit>()
            .update(TabBarType.values[_tabController.index]);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<StoragePermissionCubit, bool>(
        builder: (context, state) {
          if (!state) {
            return const StoragePermissionWidget();
          }
          return CommonTabBar(
            documentType: DocumentType.bookmark,
            tabController: _tabController,
            tabs: TabBarType.values
                .map((type) => CustomTab(tabBarType: type))
                .toList(),
            tabViews: TabBarType.values
                .map(
                  (type) => TabDocumentWidget(
                    documentType: DocumentType.bookmark,
                    tabBarType: type,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
