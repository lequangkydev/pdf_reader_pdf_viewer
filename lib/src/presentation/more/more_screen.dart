import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../module/admob/utils/inter_ad_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/common_native_ad.dart';
import '../../../module/file_system/file_path_manager.dart';
import '../../../module/log_event_app/home_event.dart';
import '../../../module/log_event_app/setting_event.dart';
import '../../../module/remote_config/remote_config.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/model/document_tool_model.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../global/global.dart';
import '../../services/default_app_checker.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/cubit/shell_document_tab_cubit.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/enum/success_type.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../shared/screen/widget/search_file.dart';
import '../../shared/utils/share_util.dart';
import '../../shared/widgets/bottom_sheet/rename_bottom_sheet.dart';
import '../../shared/widgets/dialog/rate_dialog.dart';
import '../../shared/widgets/storage_permission_widget.dart';
import '../all_documents/cubit/pdf_cubit.dart';
import '../document_tool/cubit/scan_pdf_cubit.dart';
import '../permission/cubit/storage_status_cubit.dart';
import 'widgets/ai_section.dart';
import 'widgets/item_setting.dart';

class MoreScreen extends StatelessLoggableWidget {
  const MoreScreen({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ScanPdfCubit()),
      ],
      child: MoreScreenUI(
        pageController: pageController,
      ),
    );
  }
}

class MoreScreenUI extends StatefulWidget {
  const MoreScreenUI({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<MoreScreenUI> createState() => _MoreScreenUIState();
}

class _MoreScreenUIState extends State<MoreScreenUI> {
  @override
  void initState() {
    MyAds.instance.appLifecycleReactor?.setShouldShow(true);
    super.initState();
    // NativeHomeUtil.instance.initController();
    // NativeAllUtil.instance.preloadAd();

    // đổi màu header theo tab đang chọn
    context.read<ShellDocumentTabCubit>().update(TabBarType.all);
    widget.pageController.addListener(() {
      if (widget.pageController.page == BottomTab.more.index && mounted) {
        context.read<ShellDocumentTabCubit>().update(TabBarType.all);
      }
    });
  }

  bool isSharing = false;

  Future<void> _launchUrl(String url) async {
    MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<ScanPdfCubit, String?>(
        listener: (context, state) async {
          if (state != null && state.isNotEmpty) {
            final newName = await showRenameDialog(
                context: context, defaultName: context.l10n.scanPDF);
            if (newName == null && context.mounted) {
              return;
            }
            final pathFile = await FilePathManager.instance
                .saveFileToDownloads(state, '$newName.pdf');
            final newFile = File(pathFile);
            final fileModel = FileModel(id: const Uuid().v1(), file: newFile);
            getIt<PdfCubit>().addFile(fileModel);
            if (context.mounted) {
              context.pushRoute(
                FileSuccessRoute(
                  fileModel: fileModel,
                  title: context.l10n.scanPdfSuccess,
                  successType: SuccessType.scan,
                ),
              );
            }
          }
        },
        child: BlocBuilder<StoragePermissionCubit, bool>(
          builder: (context, state) {
            if (!state) {
              return const StoragePermissionWidget();
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 85,
                  decoration: BoxDecoration(
                    gradient: TabBarType.pdf.backgroundGradient,
                  ),
                  child: const SafeArea(
                    child: SearchFile(),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const AiAssistantSection(),
                      if (Global.instance.isFullAds)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CommonNativeAd(
                            adConfig: adUnitsConfig.nativeTabMores,
                            border: Border.all(color: AppColors.adBorder),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      else
                        16.vSpace,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.l10n.tools,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: const Color(0xff404040),
                          ),
                        ),
                      ),
                      12.vSpace,
                      Container(
                        // padding: const EdgeInsets.fromLTRB(12, 12, 16, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: DocumentToolItem.values.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 16.h,
                            childAspectRatio: 0.9,
                          ),
                          itemBuilder: (context, index) {
                            final item = DocumentToolItem.values[index];
                            return GestureDetector(
                              onTap: () async {
                                if (index == 0) {
                                  MyAds.instance.appLifecycleReactor
                                      ?.setIsExcludeScreen(true);
                                  if (context.mounted) {
                                    AnalyticLogger.instance.logEventWithScreen(
                                        event: HomeEvent.user_click_scan_pdf);
                                    DefaultAppChecker.blockNotify();
                                    await context
                                        .read<ScanPdfCubit>()
                                        .scanDocument();
                                    DefaultAppChecker.unBlockNotify();
                                  }
                                  return;
                                }
                                final eventMap = {
                                  1: HomeEvent.user_click_pdf_to_image,
                                  2: HomeEvent.click_pdf_to_LImage,
                                  3: HomeEvent.user_click_merge_pdf,
                                  4: HomeEvent.user_click_split_pdf,
                                  5: HomeEvent.user_click_unlock_pdf,
                                  6: HomeEvent.user_click_lock_pdf,
                                };

                                final routeMap = <int, PageRouteInfo>{
                                  1: PdfToImageRoute(isLongImage: false),
                                  2: PdfToImageRoute(isLongImage: true),
                                  3: MergePdfRoute(),
                                  4: PdfFilePickerRoute(),
                                  5: const UnlockPdfRoute(),
                                  6: const LockPdfRoute(),
                                  7: const ImageToPdfRoute(),
                                };
                                if (eventMap.containsKey(index)) {
                                  AnalyticLogger.instance.logEventWithScreen(
                                      event: eventMap[index]!);
                                }
                                await InterAdUtil.instance
                                    .showInterWithNativeFull(
                                  interAdConfig: adUnitsConfig.interTabMores,
                                  nativeFullConfig:
                                      adUnitsConfig.nativeFullInterTabMores,
                                );
                                if (context.mounted) {
                                  context.pushRoute(routeMap[index]!);
                                }
                              },
                              child: itemGridView(
                                title: item.name,
                                iconPath: item.pathImage,
                              ),
                            );
                          },
                        ),
                      ),
                      4.vSpace,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.l10n.setting,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      12.vSpace,
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xffEDEDED),
                          ),
                        ),
                        child: Column(
                          children: [
                            ItemSetting(
                              text: context.l10n.language,
                              icon: Assets.icons.setting.icLanguage.path,
                              onTap: () {
                                AnalyticLogger.instance.logEventWithScreen(
                                    event: SettingEvent.user_click_language);
                                context
                                    .pushRoute(LanguageRoute(isFirst: false));
                              },
                            ),
                            ItemSetting(
                              text: context.l10n.rate,
                              icon: Assets.icons.setting.icRate.path,
                              onTap: () {
                                AnalyticLogger.instance.logEventWithScreen(
                                    event: SettingEvent.user_click_rate);
                                showRatingDialog(fromSetting: true);
                              },
                            ),
                            ItemSetting(
                              text: context.l10n.share,
                              icon: Assets.icons.setting.icShare.path,
                              onTap: () {
                                AnalyticLogger.instance.logEventWithScreen(
                                    event: SettingEvent.user_click_share);
                                ShareUtil.shareApp();
                              },
                            ),
                            ItemSetting(
                              text: context.l10n.policy,
                              icon: Assets.icons.setting.icPolicy.path,
                              onTap: () {
                                AnalyticLogger.instance.logEventWithScreen(
                                    event: SettingEvent.user_click_policy);
                                final url = RemoteConfigManager
                                    .instance.appConfig.urlPolicy;
                                _launchUrl(
                                    url.isEmpty ? AppConstants.urlPolicy : url);
                              },
                              divider: false,
                            ),
                          ],
                        ),
                      ),
                      50.vSpace,
                    ],
                  ),
                ))
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemGridView({required title, required iconPath}) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 52,
            height: 52,
          ),
          8.vSpace,
          Expanded(
            child: AutoSizeText(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
