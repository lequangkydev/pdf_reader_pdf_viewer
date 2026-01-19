import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/extension/string_extension.dart';
import '../../../shared/utils/string_util.dart';
import '../../../shared/widgets/app_bar/custom_appbar.dart';
import '../../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../../shared/widgets/bottom_sheet/rename_bottom_sheet.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import 'cubit/pdf_grid/pdf_grid_cubit.dart';
import 'cubit/pdf_grid/pdf_grid_state.dart';
import 'cubit/split_pdf/split_pdf_cubit.dart';
import 'widgets/page_list.dart';

@RoutePage()
class SplitPdfScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const SplitPdfScreen({super.key, required this.pdfModel});

  final FileModel pdfModel;

  @override
  State<SplitPdfScreen> createState() => _SplitPdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfGridCubit()),
        BlocProvider(create: (context) => SplitPdfCubit()),
      ],
      child: this,
    );
  }
}

class _SplitPdfScreenState extends State<SplitPdfScreen> {
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
        if (password.isValid && context.mounted) {
          context
              .read<PdfGridCubit>()
              .prepare(original: bytes, password: password);
        } else {
          context.maybePop();
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${context.l10n.anError}$e')),
          );
        }
        context.maybePop();
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
          title: context.l10n.splitPDF,
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
            _buildSplitBtn(),
            CachedBannerAd(
              cachedAdUtil: BannerAllUtil.instance,
            )
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
        const Expanded(
          child: PageList(),
        ),
      ],
    );
  }

  Widget _buildSplitBtn() {
    return BlocBuilder<PdfGridCubit, PdfGridState>(
      builder: (context, state) {
        final int selectedCount =
            state.pages.where((page) => page.isSelected ?? false).length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: FilledButton(
            onPressed: () async {
              if (selectedCount < 1) {
                AnalyticLogger.instance.logEventWithScreen(
                    event: SplitPdfEvent.user_click_split_notSelect);
                return;
              }
              AnalyticLogger.instance.logEventWithScreen(
                  event: SplitPdfEvent.user_click_split_selected);
              final newName = await showRenameDialog(
                context: context,
                defaultName: context.l10n.splitPDF,
              );
              if (newName == null || !context.mounted) {
                return;
              }
              //check
              if (StringUtil.hasSpecialCharacter(newName)) {
                Fluttertoast.showToast(
                    msg: context.l10n.errorCharacter,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: AppColors.pr,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return;
              }
              final String lastName = StringUtil.trimSpaces(newName);

              LoadingOverlay.show();

              final pages = context.read<PdfGridCubit>().state.pages;
              final bytes = context.read<PdfGridCubit>().state.unlockedBytes;
              final resultFile = await context.read<SplitPdfCubit>().splitPdf(
                    fileName: lastName,
                    bytes: bytes!,
                    pages: pages,
                  );

              LoadingOverlay.hide();
              if (resultFile != null && context.mounted) {
                final fileModel =
                    FileModel(id: const Uuid().v1(), file: resultFile);
                context.replaceRoute(
                  FileSuccessRoute(
                    fileModel: fileModel,
                    title: context.l10n.splitSuccess,
                  ),
                );
              }
              return;
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: selectedCount > 0 ? AppColors.pr : AppColors.b15,
            ),
            child: Text(context.l10n.split),
          ),
        );
      },
    );
  }
}
