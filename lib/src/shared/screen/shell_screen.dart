import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../module/file_system/file_path_manager.dart';
import '../../../module/log_event_app/home_event.dart';
import '../../../module/log_event_app/shell_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../global/global.dart';
import '../../presentation/ai/widgets/ai_assistant.dart';
import '../../presentation/all_documents/cubit/all_file_cubit.dart';
import '../../presentation/all_documents/cubit/pdf_cubit.dart';
import '../../presentation/bookmark/bookmark_screen.dart';
import '../../presentation/document/document_screen.dart';
import '../../presentation/document_tool/cubit/scan_pdf_cubit.dart';
import '../../presentation/more/more_screen.dart';
import '../../presentation/permission/cubit/storage_status_cubit.dart';
import '../../presentation/recent/recent_screen.dart';
import '../../services/default_app_checker.dart';
import '../constants/app_colors.dart';
import '../enum/success_type.dart';
import '../extension/context_extension.dart';
import '../extension/number_extension.dart';
import '../helpers/permission_util.dart';
import '../mixin/permission_mixin.dart';
import '../utils/style_utils.dart';
import '../widgets/bottom_sheet/rename_bottom_sheet.dart';
import '../widgets/dialog/dialog_exit.dart';
import 'cubit/bottom_tab_cubit.dart';

part 'widget/navigation_bar.dart';

@RoutePage()
class ShellScreen extends StatefulLoggableWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen>
    with
        AutoRouteAwareStateMixin,
        PermissionMixin,
        SingleTickerProviderStateMixin {
  late final PageController pageController;

  @override
  void initState() {
    context.read<AllFileCubit>().initAll();
    AnalyticLogger.instance
        .logEventWithScreen(event: ShellEvent.Enter_FROM_ALL);
    if (Global.instance.notificationAction == null) {
      getIt<BottomTabCubit>().changeTab(BottomTab.document);
      pageController = PageController();
    } else {
      final tab = getIt<BottomTabCubit>().state;
      pageController = PageController(initialPage: tab.index);
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        requestNotificationPermission();
        BannerViewFileUtil.instance.preloadAd();
      },
    );
    InterFileBackTabUtil.instance.init();
  }

  void requestNotificationPermission() {
    if (!SharedPreferencesManager.instance.isFirstUseApp()) {
      PermissionUtil.instance.requestNotificationHome();
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
    BannerViewFileUtil.instance.preloadAd();
    final viewFileCount = SharedPreferencesManager.instance.viewFileCount;
    final validViewFileCount = viewFileCount == 2 ||
        viewFileCount == 5 ||
        viewFileCount == 10 ||
        viewFileCount == 20;
    if (validViewFileCount && Global.instance.viewFile) {
      Global.instance.viewFile = false;
      PermissionUtil.instance.requestNotificationHome(forceRequest: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !Global.instance.isFullAds,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        await _showExitDialog();
        return;
      },
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: _buildContent(),
      floatingActionButton: const AIAssistant(),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildContent() => BlocConsumer<BottomTabCubit, BottomTab>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          pageController.jumpToPage(state.index);
        },
        builder: (context, state) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              DocumentScreen(pageController: pageController),
              RecentScreen(pageController: pageController),
              BookmarkScreen(pageController: pageController),
              MoreScreen(pageController: pageController),
            ],
          );
        },
      );

  Widget _buildNavigationBar() => BlocBuilder<BottomTabCubit, BottomTab>(
        builder: (context, state) {
          return MainNavigationBar(
            selectedTab: state,
            onTabChange: (index) {
              final evenKey = switch (index) {
                0 => ShellEvent.user_click_tab_document,
                1 => ShellEvent.user_click_tab_recent,
                2 => ShellEvent.user_click_tab_bookmark,
                3 => ShellEvent.user_click_tab_more,
                _ => null,
              };
              if (evenKey != null) {
                AnalyticLogger.instance.logEventWithScreen(event: evenKey);
                context
                    .read<BottomTabCubit>()
                    .changeTab(BottomTab.values[index]);

                if (Global.instance.isFullAds) {
                  InterFileBackTabUtil.instance.show(
                    enable: InterFileBackTabUtil.instance.config.interTab,
                    nativeFullConfig: adUnitsConfig.nativeFullInterTab,
                  );
                }
              }
            },
          );
        },
      );

  // MARK: - Dialog Methods
  Future<void> _showExitDialog() async {
    await DialogWidgetExit.showDialogExit(
      padding: EdgeInsets.fromLTRB(0, 24.h, 0, 16.h),
      context: context,
      title: '',
      contentWidget: _buildExitDialogContent(),
      onConfirm: context.maybePop,
      onCancel: _exitApp,
      firstButtonHot: false,
      confirmText: context.l10n.cancel,
      cancelText: context.l10n.exit,
    );
  }

  Widget _buildExitDialogContent() => Text(
        context.l10n.doYouWantExitApp,
        style: StyleUtils.style.s16.semiBold.b75,
      );

  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}
