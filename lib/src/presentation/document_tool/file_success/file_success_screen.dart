import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../module/admob/utils/inter_ad_util.dart';
import '../../../../module/admob/utils/native_all_util.dart';
import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/native_all_ad.dart';
import '../../../../module/file_system/file_path_manager.dart';
import '../../../../module/log_event_app/successfully_event.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/enum/success_type.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../../shared/utils/debouncer.dart';
import '../../../shared/utils/share_util.dart';
import '../../../shared/utils/style_utils.dart';
import '../../../shared/utils/utils.dart';

@RoutePage()
class FileSuccessScreen extends StatefulLoggableWidget {
  const FileSuccessScreen({
    super.key,
    required this.fileModel,
    required this.title,
    this.imageLong,
    this.images,
    this.successType = SuccessType.pdf,
    this.subtitle,
    this.aiSuccess = false,
  });

  final FileModel fileModel;
  final List<Uint8List>? images;
  final Uint8List? imageLong;
  final String title;
  final SuccessType successType;
  final String? subtitle;
  final bool aiSuccess;

  @override
  State<FileSuccessScreen> createState() => _SplitSuccessScreenState();
}

class _SplitSuccessScreenState extends State<FileSuccessScreen> {
  Future<void> shareFile() async {
    AnalyticLogger.instance
        .logEventWithScreen(event: SuccessfullyEvent.user_click_button_share);
    DeBouncer.run(() async {
      MyAds.instance.appLifecycleReactor?.setShouldShow(false);
      if (widget.images != null && widget.images!.isNotEmpty) {
        final data = await convertImagesToXFiles(widget.images!);
        ShareUtil.shareFiles(data);
      } else {
        if (widget.fileModel.file.existsSync()) {
          ShareUtil.shareFiles([XFile(widget.fileModel.file.path)]);
        }
      }
    });
    MyAds.instance.appLifecycleReactor?.setShouldShow(true);
  }

  Future<List<XFile>> convertImagesToXFiles(List<Uint8List> images) async {
    final dir = await getTemporaryDirectory();
    final List<XFile> xFiles = [];

    for (int i = 0; i < images.length; i++) {
      final filePath = '${dir.path}/shared_image_$i.png';
      final file = File(filePath);
      await file.writeAsBytes(images[i]);
      xFiles.add(XFile(file.path));
    }
    return xFiles;
  }

  Future<void> openFile() async {
    AnalyticLogger.instance
        .logEventWithScreen(event: SuccessfullyEvent.user_click_button_open);
    await InterAdUtil.instance.showInterWithNativeFull(
      interAdConfig: adUnitsConfig.interSuccessfully,
      nativeFullConfig: adUnitsConfig.nativeFullInterSuccess,
      checkFullAds: false,
    );
    final String fileExtension =
        path.extension(widget.fileModel.file.path).toLowerCase();
    if (mounted) {
      if (fileExtension == '.pdf') {
        context.router.pushAndPopUntil(
          ViewPdfRoute(pdfFile: widget.fileModel),
          predicate: (route) => route.data?.name == ShellRoute.name,
        );
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: [
            GestureDetector(
              child: Assets.icons.backHome.svg(),
              onTap: () async {
                AnalyticLogger.instance.logEventWithScreen(
                    event: SuccessfullyEvent.user_click_button_go_home);
                await InterAdUtil.instance.showInterWithNativeFull(
                  interAdConfig: adUnitsConfig.interSuccessfully,
                  nativeFullConfig: adUnitsConfig.nativeFullInterSuccess,
                  checkFullAds: false,
                );
                if (context.mounted) {
                  getIt<BottomTabCubit>().changeTab(BottomTab.document);
                  context.router.popUntilRoot();
                }
              },
            ),
            16.hSpace,
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                40.vSpace,
                if (widget.aiSuccess)
                  Assets.images.downloadSuccess.image(width: 200)
                else
                  Assets.images.success.image(width: 200),
                if (widget.successType != SuccessType.photo)
                  Text(
                    path.basename(widget.fileModel.file.path),
                    textAlign: TextAlign.center,
                  )
                else
                  Text(
                    widget.subtitle ?? '',
                    textAlign: TextAlign.center,
                  ),
                12.vSpace,
                if (widget.successType != SuccessType.photo)
                  Text(
                    '📑 ${widget.fileModel.file.path}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xffBFBFBF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                else
                  Center(
                    child: Text(
                      () {
                        // Tách đường dẫn thư mục bằng cách chia đường dẫn tệp và loại bỏ phần tử cuối cùng (tên tệp).
                        final list = widget.fileModel.file.path.split('/');
                        // Loại bỏ phần tử cuối cùng trong danh sách.
                        list.removeLast();
                        // Ghép các phần tử còn lại để tái tạo đường dẫn thư mục.
                        return list.join('/');
                      }(),
                      style: TextStyle(
                        color: AppColors.color40.withOpacity(0.5),
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.successType != SuccessType.photo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FilledButton.icon(
                  onPressed: openFile,
                  label: Text(
                    context.l10n.open,
                    style: StyleUtils.style.s16.white,
                  ),
                  icon: Assets.icons.share.svg(
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            12.vSpace,
            if (widget.successType == SuccessType.photo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FilledButton.icon(
                  label: Text(
                    context.l10n.saveToAlbum,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleUtils.style.s16.semiBold.white,
                  ),
                  icon: Assets.icons.download.svg(),
                  onPressed: () async {
                    try {
                      getIt<BottomTabCubit>().changeTab(BottomTab.document);

                      final images = widget.images;
                      final imageLong = widget.imageLong;

                      // Tạo timestamp duy nhất để tránh trùng tên file
                      final timestamp = DateTime.now().millisecondsSinceEpoch;

                      if (images != null && images.isNotEmpty) {
                        // Lưu hàng loạt ảnh song song
                        Future.wait(List.generate(images.length, (i) async {
                          final Uint8List imageData = images[i];
                          final String name = 'img_${timestamp}_$i';
                          await FilePathManager.instance
                              .saveLocalImage(imageData, name);
                        }));

                        Future.delayed(
                          const Duration(milliseconds: 900),
                          () => showToast(
                            appContext.l10n.imagesSaved(images.length),
                            colorBg: const Color(0xffE8E8E8),
                            colorText: const Color(0xff252525),
                          ),
                        );
                        context.router.popUntilRoot();
                      } else {
                        if (imageLong != null) {
                          final String name = 'longImagePdf_$timestamp';
                          FilePathManager.instance
                              .saveLocalImage(imageLong, name);
                          Future.delayed(
                            const Duration(milliseconds: 900),
                            () => showToast(
                              appContext.l10n.imagesSaved(1),
                              colorBg: const Color(0xffE8E8E8),
                              colorText: const Color(0xff252525),
                            ),
                          );
                          context.router.popUntilRoot();
                        }
                      }
                    } catch (error, stackTrace) {
                      // In log chi tiết khi debug
                      debugPrint('Save image error: $error\n$stackTrace');
                      showToast(error.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pr, // Background color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: const Color(0xffE52120).withValues(alpha: .1),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  backgroundColor:
                      const Color(0xffE52120).withValues(alpha: .05),
                ),
                onPressed: shareFile,
                label: Text(context.l10n.share, style: StyleUtils.style.s16.pr),
                icon: Assets.icons.icShare.svg(
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.pr,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            20.vSpace,
            NativeAllAd(
              isAdEnabled: NativeAllUtil.instance.config.nativeSuccessfully,
            )
          ],
        ),
      ),
    );
  }
}
