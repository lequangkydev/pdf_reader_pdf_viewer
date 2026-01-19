import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../../module/log_event_app/un_lock_pdf_event.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../global/global.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/widgets/app_bar/search_app_bar.dart';
import '../../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../../../shared/widgets/loading/indicator_loading.dart';
import '../../all_documents/cubit/pdf_cubit.dart';
import '../cubit/pdf_list_cubit.dart';
import '../widget/pdf_list_view.dart';
import 'cubit/unlock_pdf_cubit.dart';

@RoutePage()
class UnlockPdfScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const UnlockPdfScreen({super.key});

  @override
  State<UnlockPdfScreen> createState() => _UnlockPdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PdfListCubit()..fetchPdf(all: false, unProtectedPdfs: false),
        ),
        BlocProvider(
          create: (context) => UnLockPdfCubit(),
        ),
      ],
      child: this,
    );
  }
}

class _UnlockPdfScreenState extends State<UnlockPdfScreen> {
  Future<void> _onPdfTap(FileModel filePdf) async {
    AnalyticLogger.instance
        .logEventWithScreen(event: UnLockPdfEvent.user_click_file_unlock);
    final unLockCubit = context.read<UnLockPdfCubit>();
    unLockCubit.update(filePdf);

    final password = await showPasswordBottomSheet(
      pdfFile: filePdf.file,
      typePassword: TypePassword.remove,
      isOpen: true,
    );

    if (password == null) {
      return;
    }
    LoadingOverlay.show();
    final result = await Future.wait([
      unLockCubit.removePasswordPdf(password),
      Future.delayed(const Duration(milliseconds: 350)),
    ]).then((values) => values.first as FileModel?);

    AnalyticLogger.instance
        .logEventWithScreen(event: UnLockPdfEvent.user_remove_password);
    LoadingOverlay.hide();
    if (result != null && context.mounted) {
      getIt<PdfCubit>().updateFile(result);

      context.replaceRoute(
        FileSuccessRoute(
          fileModel: result,
          title: context.l10n.unlockPdfSuccess,
        ),
      );
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
        AnalyticLogger.instance
            .logEventWithScreen(event: UnLockPdfEvent.user_click_back_unlock);
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: SearchAppBar(
          title: context.l10n.unlockPDF,
          onSearchChanged: (value) {
            context.read<PdfListCubit>().searchPdf(query: value);
          },
          onSearchDone: (value) => context
              .read<PdfListCubit>()
              .searchPdf(query: value, isDone: true),
          onBack: () {
            context.maybePop();
          },
          tapSearch: () {
            AnalyticLogger.instance.logEventWithScreen(
                event: UnLockPdfEvent.user_click_search_unlock);
          },
        ),
        body: _buildPdfList(),
        bottomNavigationBar: CachedBannerAd(
          cachedAdUtil: BannerAllUtil.instance,
        ),
      ),
    );
  }

  Widget _buildPdfList() {
    return BlocBuilder<PdfListCubit, PdfListState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const IndicatorLoading(),
          loaded: (data) {
            if (data.isEmpty) {
              return Center(child: Text(context.l10n.empty));
            }
            return PdfListView(
              pdfList: data,
              onTapPdf: _onPdfTap,
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
