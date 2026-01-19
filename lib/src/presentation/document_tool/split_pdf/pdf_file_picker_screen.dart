import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../../../../module/admob/utils/native_all_util.dart';
import '../../../../../../module/admob/utils/utils.dart';
import '../../../../../../module/admob/widget/ads/native_all_ad.dart';
import '../../../../../../module/log_event_app/split_pdf_event.dart';
import '../../../../../../module/tracking_screen/loggable_widget.dart';
import '../../../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/navigation/app_router.dart';
import '../../../global/global.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/widgets/app_bar/search_app_bar.dart';
import '../../../shared/widgets/loading/indicator_loading.dart';
import '../cubit/pdf_list_cubit.dart';
import '../widget/pdf_list_view.dart';

@RoutePage()
class PdfFilePickerScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const PdfFilePickerScreen(
      {this.isAI = false, this.isAITranslate = true, super.key});

  final bool isAI;
  final bool isAITranslate;

  @override
  State<PdfFilePickerScreen> createState() => _SplitPdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfListCubit()),
      ],
      child: this,
    );
  }
}

class _SplitPdfScreenState extends State<PdfFilePickerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PdfListCubit>().fetchPdf();
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
        appBar: SearchAppBar(
          title: widget.isAI ? '' : context.l10n.splitPDF,
          onSearchChanged: (value) =>
              context.read<PdfListCubit>().searchPdf(query: value),
          onSearchDone: (value) => context
              .read<PdfListCubit>()
              .searchPdf(query: value, isDone: true),
          onBack: () {
            AnalyticLogger.instance
                .logEventWithScreen(event: SplitPdfEvent.user_click_back_split);
            context.maybePop();
          },
          tapSearch: () {
            AnalyticLogger.instance.logEventWithScreen(
                event: SplitPdfEvent.user_click_search_split);
          },
        ),
        body: _buildPdfList(),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<PdfListCubit, PdfListState>(builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                loaded: (data) {
                  if (data.isNotEmpty && data.length >= 3) {
                    return NativeAllAd(
                        isAdEnabled:
                            NativeAllUtil.instance.config.nativePdfToolList);
                  }
                  return const SizedBox.shrink();
                },
              );
            })
          ],
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
              onTapPdf: (file) {
                if (widget.isAI) {
                  context.pushRoute(SelectPageRoute(
                    pdfModel: file,
                    isAITranslate: widget.isAITranslate,
                  ));
                  return;
                }
                context.pushRoute(SplitPdfRoute(pdfModel: file));
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
