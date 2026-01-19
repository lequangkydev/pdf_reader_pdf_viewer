import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../module/log_event_app/document_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../shared/cubit/shell_document_tab_cubit.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../shared/widgets/storage_permission_widget.dart';
import '../../shared/widgets/tabbar_widget/tabbar_widget.dart';
import '../permission/cubit/storage_status_cubit.dart';
import 'cubit/tab_cubit.dart';
import 'widgets/tab_document_widget.dart';

enum DocumentType { document, bookmark, recent }

class DocumentScreen extends StatefulLoggableWidget {
  const DocumentScreen({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // NativeHomeUtil.instance.initController();
    tabController =
        TabController(length: TabBarType.values.length, vsync: this);
    // đổi màu header theo tab đang chọn
    widget.pageController.addListener(() {
      if (widget.pageController.page == BottomTab.document.index) {
        final currentTab = context.read<TabCubit>().state;
        context.read<ShellDocumentTabCubit>().update(currentTab);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<TabCubit, TabBarType>(
        listener: (context, state) {
          tabController.index = state.index;
          context.read<TabCubit>().update(state);
          final eventName = switch (state) {
            TabBarType.all => DocumentEvent.user_click_all_document,
            TabBarType.pdf => DocumentEvent.user_click_pdf_document,
            TabBarType.word => DocumentEvent.user_click_doc_document,
            TabBarType.excel => DocumentEvent.user_click_xlsx_document,
            TabBarType.ppt => DocumentEvent.user_click_ppt_document,
          };
          AnalyticLogger.instance.logEventWithScreen(
            event: eventName,
          );
        },
        child: BlocBuilder<StoragePermissionCubit, bool>(
          builder: (context, state) {
            if (!state) {
              return const StoragePermissionWidget();
            }
            return CommonTabBar(
              tabController: tabController,
              documentType: DocumentType.document,
              tabs: TabBarType.values
                  .map((type) => CustomTab(tabBarType: type))
                  .toList(),
              tabViews: TabBarType.values
                  .map((type) => TabDocumentWidget(
                        fromDocumentScreen: true,
                        documentType: DocumentType.document,
                        tabBarType: type,
                      ))
                  .toList(),
              initialIndex: context.watch<TabCubit>().state.index,
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
