import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../../module/log_event_app/split_pdf_event.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/enum/success_type.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/extension/string_extension.dart';
import '../../../shared/widgets/app_bar/custom_appbar.dart';
import '../../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../split_pdf/cubit/pdf_grid/pdf_grid_cubit.dart';
import '../split_pdf/cubit/pdf_grid/pdf_grid_state.dart';
import '../split_pdf/widgets/page_list.dart';
import 'cubit/pdf_to_image_cubit.dart';

@RoutePage()
class PdfToImagePreviewScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const PdfToImagePreviewScreen({
    super.key,
    required this.pdfModel,
    this.isLong = false,
  });

  final FileModel pdfModel;
  final bool isLong;

  @override
  State<PdfToImagePreviewScreen> createState() =>
      _PdfToImagePreviewScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfGridCubit()),
        BlocProvider(create: (context) => PdfToImageCubit()),
      ],
      child: this,
    );
  }
}

class _PdfToImagePreviewScreenState extends State<PdfToImagePreviewScreen> {
  String? password;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _handleLockedPdf);
  }

  Future<void> _handleLockedPdf() async {
    final bytes = widget.pdfModel.file.readAsBytesSync();
    try {
      PdfDocument(inputBytes: bytes);
      context.read<PdfGridCubit>().prepare(original: bytes);
    } catch (e) {
      if (e is ArgumentError && e.message.contains('password')) {
        password = await showPasswordBottomSheet(
          pdfFile: widget.pdfModel.file,
          typePassword: TypePassword.enter,
          isOpen: false,
        );
        if (password.isValid && mounted) {
          context
              .read<PdfGridCubit>()
              .prepare(original: bytes, password: password);
        } else {
          context.maybePop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${context.l10n.anError}$e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (Global.instance.isFullAds) {
          await InterFileBackTabUtil.instance.show(
            enable: InterFileBackTabUtil.instance.config.interBack,
            nativeFullConfig: adUnitsConfig.nativeFullInterBack,
          );
        }

        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l10n.previewConvert,
          onBack: () {
            AnalyticLogger.instance
                .logEventWithScreen(event: SplitPdfEvent.user_click_back_split);
            context.maybePop();
          },
          actionWidget: [
            GestureDetector(
              onTap: context.read<PdfGridCubit>().toggleSelectAll,
              child: Assets.icons.checkAll.svg(),
            ),
            16.hSpace,
          ],
        ),
        body: buildReorderListView(),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBottomNavigationBar(),
            CachedBannerAd(cachedAdUtil: BannerAllUtil.instance)
          ],
        ),
      ),
    );
  }

  Widget buildReorderListView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            context.l10n.selectThePage,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.color80,
            ),
          ),
        ),
        12.vSpace,
        const Expanded(child: PageList()),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            16.hSpace,
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  LoadingOverlay.show();

                  final pdfCubit = context.read<PdfToImageCubit>();
                  final gridCubit = context.read<PdfGridCubit>();
                  final pages = gridCubit.state.pages;
                  if (pages.isEmpty) {
                    return;
                  }
                  final fileName =
                      widget.isLong ? 'pdfToLongImage' : 'pdfToImage';
                  if (widget.isLong) {
                    final result = await pdfCubit.convertPdfToLongImage(
                      fileName: fileName,
                      pages: pages,
                      convertAll: true,
                    );
                    LoadingOverlay.hide();
                    if (result == null || !context.mounted) {
                      return;
                    }
                    context.pushRoute(FileSuccessRoute(
                      fileModel: FileModel(
                        id: const Uuid().v1(),
                        file: File(''),
                      ),
                      title: context.l10n.convertedSuccess,
                      successType: SuccessType.photo,
                      imageLong: result,
                      subtitle: context.l10n.imageExported(1),
                    ));
                    return;
                  }
                  final result = await pdfCubit.convertToSeparateImages(
                    fileName: fileName,
                    pages: pages,
                    convertAll: true,
                  );
                  LoadingOverlay.hide();
                  if (result == null || !context.mounted) {
                    return;
                  }
                  context.pushRoute(FileSuccessRoute(
                    fileModel: FileModel(
                      id: const Uuid().v1(),
                      file: File(''),
                    ),
                    images: result,
                    title: context.l10n.convertedSuccess,
                    successType: SuccessType.photo,
                    subtitle: result.length > 1
                        ? context.l10n.imagesExported(result.length)
                        : context.l10n.imageExported(result.length),
                  ));
                  return;
                },
                child: BlocBuilder<PdfGridCubit, PdfGridState>(
                  builder: (context, state) {
                    return Text(
                      context.l10n.convertAll,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: state.pages.isEmpty ? Colors.grey : AppColors.pr,
                      ),
                    );
                  },
                ),
              ),
            ),
            12.hSpace,
            Expanded(
              child: BlocBuilder<PdfGridCubit, PdfGridState>(
                builder: (context, state) {
                  return FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          state.pages.any((element) => element.isSelected)
                              ? AppColors.pr
                              : Colors.grey,
                    ),
                    onPressed: () async {
                      final pdfCubit = context.read<PdfToImageCubit>();
                      final gridCubit = context.read<PdfGridCubit>();
                      final pages = gridCubit.state.pages;
                      if (!state.pages.any((element) => element.isSelected)) {
                        return;
                      }
                      if (widget.isLong) {
                        LoadingOverlay.show();
                        final result = await context
                            .read<PdfToImageCubit>()
                            .convertPdfToLongImage(
                                fileName: 'pdfToLongImage', pages: pages);
                        LoadingOverlay.hide();
                        if (result != null && context.mounted) {
                          context.replaceRoute(
                            FileSuccessRoute(
                              fileModel: FileModel(
                                id: const Uuid().v1(),
                                file: File(''),
                              ),
                              imageLong: result,
                              title: context.l10n.convertedSuccess,
                              successType: SuccessType.photo,
                              subtitle: context.l10n.imageExported(1),
                            ),
                          );
                        }
                      } else {
                        LoadingOverlay.show();
                        final result = await context
                            .read<PdfToImageCubit>()
                            .convertToSeparateImages(
                                fileName: 'pdfToImage', pages: pages);
                        LoadingOverlay.hide();
                        if (result != null && context.mounted) {
                          context.replaceRoute(
                            FileSuccessRoute(
                              fileModel: FileModel(
                                id: Uuid().v1(),
                                file: File(''),
                              ),
                              images: result,
                              title: context.l10n.convertedSuccess,
                              successType: SuccessType.photo,
                              subtitle: result.length < 2
                                  ? context.l10n.imageExported(result.length)
                                  : context.l10n.imagesExported(result.length),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      context.l10n.convertSelect,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            16.hSpace,
          ],
        ),
        30.vSpace,
      ],
    );
  }
}
