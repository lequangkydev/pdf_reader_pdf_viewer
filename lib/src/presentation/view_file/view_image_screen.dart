import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;

import '../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../module/log_event_app/shell_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/app_config.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../data/model/file_model.dart';
import '../../global/global.dart';
import '../../services/default_app_checker.dart';
import '../../shared/extension/string_extension.dart';
import '../../shared/mixin/system_ui_mixin.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';

@RoutePage()
class ViewImageScreen extends StatefulLoggableWidget {
  const ViewImageScreen({
    super.key,
    required this.fileModel,
    this.fromReload = false,
  });

  final FileModel fileModel;
  final bool fromReload;

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> with SystemUiMixin {
  late FileModel fileUpdate;

  @override
  void didUpdateWidget(covariant ViewImageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (fileUpdate != widget.fileModel) {
      setState(() {
        fileUpdate = widget.fileModel;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fileUpdate = widget.fileModel;
    DefaultAppChecker.viewFile(true);
    Global.instance.viewFile = true;
    SharedPreferencesManager.instance.increaseViewFileCount();
  }

  void moveToHome() {
    AnalyticLogger.instance
        .logEventWithScreen(event: ShellEvent.Enter_FROM_ViewFILE);
    if (Global.instance.sharedFiles != null ||
        widget.fromReload ||
        getIt<AppRouter>().stack.length == 1) {
      Global.instance.sharedFiles = null;
      context.replaceRoute(const ShellRoute());
    } else {
      context.maybePop();
    }
  }

  @override
  void dispose() {
    DefaultAppChecker.viewFile(false);
    super.dispose();
    AppConfig.getInstance().settingSystemUI();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.fromReload,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (Global.instance.isFullAds) {
          await InterFileBackTabUtil.instance.show(
            enable: InterFileBackTabUtil.instance.config.interTab,
            nativeFullConfig: adUnitsConfig.nativeFullInterBack,
          );
        }
        if (Global.instance.sharedFiles != null ||
            widget.fromReload ||
            getIt<AppRouter>().stack.length == 1) {
          moveToHome();
          return;
        } else {
          AnalyticLogger.instance
              .logEventWithScreen(event: ShellEvent.Enter_FROM_ViewFILE);
          context.router.back();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: path
              .basenameWithoutExtension(fileUpdate.file.path)
              .shortenFileName(path.extension(fileUpdate.file.path)),
          onBack: moveToHome,
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 10.h),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: InteractiveViewer(
                panEnabled: false, // Set it to false
                minScale: 0.5,
                maxScale: 2,
                child: Image.file(
                  fileUpdate.file,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Global.instance.isFullAds
            ? SafeArea(
                top: false,
                child: CachedBannerAd(
                  cachedAdUtil: BannerViewFileUtil.instance,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
