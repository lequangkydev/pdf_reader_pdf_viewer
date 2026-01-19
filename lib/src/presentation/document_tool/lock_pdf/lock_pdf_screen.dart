import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../../module/file_system/file_path_manager.dart';
import '../../../../module/log_event_app/lock_pdf_event.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../global/global.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/widgets/add_file_button.dart';
import '../../../shared/widgets/app_bar/search_app_bar.dart';
import '../../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../../../shared/widgets/loading/indicator_loading.dart';
import '../cubit/pdf_list_cubit.dart';
import '../widget/pdf_list_view.dart';
import 'cubit/lock_pdf_cubit.dart';

@RoutePage()
class LockPdfScreen extends StatefulLoggableWidget implements AutoRouteWrapper {
  const LockPdfScreen({super.key});

  @override
  State<LockPdfScreen> createState() => _LockPdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PdfListCubit()..fetchPdf(all: false),
        ),
        BlocProvider(create: (context) => LockPdfCubit()),
      ],
      child: this,
    );
  }
}

class _LockPdfScreenState extends State<LockPdfScreen> {
  Future<void> _onPdfTap(FileModel filePdf) async {
    AnalyticLogger.instance
        .logEventWithScreen(event: LockPdfEvent.user_click_file_lock);
    final lockCubit = context.read<LockPdfCubit>();
    lockCubit.update(filePdf);

    final password = await showPasswordBottomSheet(
      typePassword: TypePassword.set,
      isOpen: true,
    );

    if (password == null) {
      return;
    }
    AnalyticLogger.instance
        .logEventWithScreen(event: LockPdfEvent.user_set_password);
    LoadingOverlay.show();
    final result = await lockCubit.setPasswordPdf(password);
    LoadingOverlay.hide();
    if (result != null && mounted) {
      context.replaceRoute(
        FileSuccessRoute(
          fileModel: result,
          title: context.l10n.lockPdfSuccess,
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
            .logEventWithScreen(event: LockPdfEvent.user_click_back_lock);
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: SearchAppBar(
          title: context.l10n.lockPDF,
          onSearchChanged: (value) =>
              context.read<PdfListCubit>().searchPdf(query: value),
          onSearchDone: (value) => context
              .read<PdfListCubit>()
              .searchPdf(query: value, isDone: true),
          onBack: () {
            context.maybePop();
          },
          tapSearch: () {
            AnalyticLogger.instance
                .logEventWithScreen(event: LockPdfEvent.user_click_search_lock);
          },
        ),
        body: _buildPdfList(),
        floatingActionButton: AddFileButton(
          onTapAdd: () async {
            final files =
                await FilePathManager.instance.pickMultipleFiles(['pdf']);
            if (files == null) {
              return;
            }
            context.read<PdfListCubit>().fetchPdf();
          },
        ),
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
