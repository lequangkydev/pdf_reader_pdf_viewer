import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../module/log_event_app/recent_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/navigation/app_router.dart';
import '../../shared/cubit/shell_document_tab_cubit.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../shared/widgets/bottom_sheet/sort_bottom_sheet.dart';
import '../../shared/widgets/storage_permission_widget.dart';
import '../../shared/widgets/tabbar_widget/tabbar_widget.dart';
import '../permission/cubit/storage_status_cubit.dart';
import 'widgets/tab_recent_widget.dart';

class RecentScreen extends StatefulLoggableWidget {
  const RecentScreen({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: TabBarType.values.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _updateTabHeader(_tabController.index);
    widget.pageController.addListener(() {
      if (widget.pageController.page == BottomTab.recent.index) {
        _updateTabHeader(_tabController.index);
      }
    });
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      return;
    }

    final eventMap = {
      TabBarType.all: RecentEvent.user_click_all_recent,
      TabBarType.pdf: RecentEvent.user_click_pdf_recent,
      TabBarType.word: RecentEvent.user_click_doc_recent,
      TabBarType.excel: RecentEvent.user_click_xlsx_recent,
      TabBarType.ppt: RecentEvent.user_click_ppt_recent,
    };

    final event = eventMap[TabBarType.values[_tabController.index]];
    if (event != null) {
      AnalyticLogger.instance.logEventWithScreen(event: event);
    }
  }

  void _updateTabHeader(int index) {
    context.read<ShellDocumentTabCubit>().update(TabBarType.values[index]);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
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
          return _buildRecentTabs();
        },
      ),
    );
  }

  Widget _buildRecentTabs() {
    final tabWidgets = List.generate(
      TabBarType.values.length,
      (index) {
        final type = TabBarType.values[index];
        return (
          tab: CustomTab(tabBarType: type),
          view: TabRecentWidget(
            onFilter: showSortBottomSheet,
            onAll: () =>
                context.pushRoute(DocumentSelectRoute(tabBarType: type)),
            tabBarType: type,
          ),
        );
      },
    );

    return CommonTabBar(
      tabController: _tabController,
      tabs: tabWidgets.map((e) => e.tab).toList(),
      tabViews: tabWidgets.map((e) => e.view).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
