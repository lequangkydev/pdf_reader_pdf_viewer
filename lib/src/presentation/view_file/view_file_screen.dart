import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

import '../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../module/log_event_app/shell_event.dart';
import '../../../module/log_event_app/view_file_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/app_config.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../global/global.dart';
import '../../services/default_app_checker.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/extension/string_extension.dart';
import '../../shared/mixin/system_ui_mixin.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';
import '../../shared/widgets/bottom_sheet/action_file_bottom_sheet.dart';
import '../../shared/widgets/bottom_sheet/guide_set_default_app.dart';
import '../permission/cubit/storage_status_cubit.dart';

@RoutePage()
class ViewFileScreen extends StatefulLoggableWidget {
  const ViewFileScreen({
    super.key,
    required this.fileModel,
    required this.type,
    required this.file,
    this.fromReload = false,
  });

  final FileModel fileModel;
  final File file;
  final TabBarType type;
  final bool fromReload;

  @override
  State<ViewFileScreen> createState() => _ViewPptScreenState();
}

class _ViewPptScreenState extends State<ViewFileScreen> with SystemUiMixin {
  late FileModel fileUpdate;
  static const String viewType = 'openFile';

  @override
  void initState() {
    super.initState();
    DefaultAppChecker.viewFile(true);
    fileUpdate = widget.fileModel;
    requestPermissionDefault();
    fileUpdate.file.setLastModified(DateTime.now());
    Global.instance.viewFile = true;
    SharedPreferencesManager.instance.increaseViewFileCount();
  }

  @override
  void didUpdateWidget(covariant ViewFileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (fileUpdate != widget.fileModel) {
      setState(() {
        fileUpdate = widget.fileModel;
      });
    }
  }

  Future<void> requestPermissionDefault() async {
    await showGuideAppDefaultBottomSheet(
      file: widget.fileModel,
      type: widget.type,
      context: context,
    );
  }

  void moveToHome() {
    AnalyticLogger.instance
        .logEventWithScreen(event: ViewFileEvent.user_click_back_view_file);
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
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'pathFile': widget.fileModel.file.path,
      'nameFile': path.basename(widget.fileModel.file.path),
    };
    final a = Global.instance.sharedFiles;
    final b = !widget.fromReload;
    return PopScope(
      canPop: !widget.fromReload && Global.instance.sharedFiles == null,
      onPopInvokedWithResult: (didPop, result) async {
        if (Global.instance.isFullAds) {
          await InterFileBackTabUtil.instance.show(
            enable: InterFileBackTabUtil.instance.config.interTab,
            nativeFullConfig: adUnitsConfig.nativeFullInterBack,
          );
        }

        if (didPop) {
          return;
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
          color: AppColors.divider,
          title: path
              .basenameWithoutExtension(fileUpdate.file.path)
              .shortenFileName(path.extension(fileUpdate.file.path)),
          onBack: moveToHome,
          actionWidget: [
            IconButton(
              onPressed: () async {
                AnalyticLogger.instance.logEventWithScreen(
                    event: ViewFileEvent.user_click_icon_additional_options);
                await showActionFileBottomSheet(
                    context: context,
                    file: fileUpdate,
                    tabType: widget.type,
                    callBack: (file) {
                      setState(() {
                        fileUpdate = file;
                      });
                      if (context.read<StoragePermissionCubit>().state) {
                        DefaultAppChecker.setRecentFilePath(file.file.path);
                      }
                    },
                    callBackDelete: () async {
                      await context.maybePop();
                    });
              },
              icon: Assets.icons.icThreeDot
                  .svg(color: const Color(0xFF808080), width: 24, height: 24),
            )
          ],
        ),
        body: PlatformViewLink(
          viewType: viewType,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        ),
        bottomNavigationBar: Global.instance.isFullAds
            ? SafeArea(
                child: CachedBannerAd(
                  cachedAdUtil: BannerViewFileUtil.instance,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
