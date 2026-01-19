import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../../module/admob/utils/native_all_util.dart';
import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/native_all_ad.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/widgets/app_bar/search_app_bar.dart';
import '../../../shared/widgets/loading/indicator_loading.dart';
import '../cubit/pdf_list_cubit.dart';
import '../widget/pdf_item.dart';

@RoutePage()
class PdfToImageScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const PdfToImageScreen({super.key, required this.isLongImage});

  final bool isLongImage;

  @override
  State<PdfToImageScreen> createState() => _PdfToImageScreenState();

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

class _PdfToImageScreenState extends State<PdfToImageScreen> {
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
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: SearchAppBar(
          key: searchKey,
          title: context.l10n.pdfToImages,
          onSearchChanged: (value) =>
              context.read<PdfListCubit>().searchPdf(query: value),
          onSearchDone: (value) => context
              .read<PdfListCubit>()
              .searchPdf(query: value, isDone: true),
          onBack: context.maybePop,
        ),
        body: _buildPdfList(),
        bottomNavigationBar:
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
        }),
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
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final filePdf = data[index];
                return GestureDetector(
                  onTap: () {
                    searchKey.currentState?.closeSearch();
                    context.pushRoute(
                      PdfToImagePreviewRoute(
                        pdfModel: filePdf,
                        isLong: widget.isLongImage,
                      ),
                    );
                  },
                  child: PdfItem(
                    pdfFile: filePdf.file,
                    isLock: filePdf.isLock,
                    trailing: Assets.icons.arrowRight.svg(),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(left: 44 + 32, right: 16),
                child: Divider(
                  color: Color(0xffF2F2F2),
                  height: 0,
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
