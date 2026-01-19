import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import ' cubit/guide_cubit.dart';
import ' cubit/image_to_pdf_cubit.dart';
import '../../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../services/default_app_checker.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/utils/string_util.dart';
import '../../../shared/widgets/app_bar/custom_appbar.dart';
import '../../../shared/widgets/bottom_sheet/rename_bottom_sheet.dart';
import '../../../shared/widgets/dashed_round_border.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../../all_documents/cubit/pdf_cubit.dart';

@RoutePage()
class ImageToPdfScreen extends StatelessWidget implements AutoRouteWrapper {
  const ImageToPdfScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagePickerCubit(),
          child: this,
        ),
        BlocProvider(
          create: (context) => GuideCubit(),
          child: this,
        ),
      ],
      child: this,
    );
  }

  Future<void> pickImages(BuildContext context) async {
    DefaultAppChecker.blockNotify();
    MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);

    final List<AssetEntity>? results = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 10,
        requestType: RequestType.image,
        themeColor: AppColors.pr,
      ),
    );
    if (results != null && results.isNotEmpty) {
      LoadingOverlay.show();
      final List<File> files = [];
      for (final asset in results) {
        final file = await asset.file;
        if (file != null) {
          files.add(file);
        }
      }

      if (context.mounted) {
        context.read<ImagePickerCubit>().addListImage(files);
      }
      LoadingOverlay.hide();
    }
    DefaultAppChecker.unBlockNotify();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, List<File>>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: context.l10n.imageToPdf,
            actionWidget: [
              if (state.isNotEmpty) ...[
                FilledButton(
                  onPressed: () async {
                    final newName = await showRenameDialog(
                      context: context,
                      defaultName: 'image_to_pdf',
                    );
                    if (newName == null) {
                      return;
                    }
                    if (StringUtil.hasSpecialCharacter(newName)) {
                      showToast(context.l10n.errorCharacter);
                      return;
                    }
                    final String lastName = StringUtil.trimSpaces(newName);
                    LoadingOverlay.show();
                    final file = await context
                        .read<ImagePickerCubit>()
                        .convertImagesToPdf(lastName);

                    if (file == null) {
                      LoadingOverlay.hide();
                      showToast('Error convert to pdf');
                      return;
                    }
                    LoadingOverlay.hide();
                    if (context.mounted) {
                      final fileModel =
                          FileModel(id: const Uuid().v1(), file: file);
                      getIt<PdfCubit>().addFile(fileModel);
                      context.pushRoute(
                        FileSuccessRoute(
                          fileModel: fileModel,
                          title: context.l10n.convertPdfSuccess,
                        ),
                      );
                    }
                  },
                  child: Text(context.l10n.save),
                ),
                16.hSpace,
              ]
            ],
          ),
          body: Column(
            children: [
              24.vSpace,
              BlocBuilder<GuideCubit, bool>(
                builder: (context, state) {
                  if (!state) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Assets.icons.danger.svg(),
                        8.hSpace,
                        Expanded(child: Text(context.l10n.youCanHold)),
                        IconButton(
                          onPressed: () {
                            context.read<GuideCubit>().update(false);
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                  );
                },
              ),
              if (state.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    8.hSpace,
                    Text(context.l10n.selectImage),
                    const Spacer(),
                    TextButton(
                      onPressed: () => pickImages(context),
                      child: Text(
                        context.l10n.addImage,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              if (state.isEmpty)
                Expanded(
                  child: Center(
                    child: DashedRoundedContainer(
                      height: 52,
                      width: 165,
                      child: TextButton.icon(
                        icon: Assets.icons.addImage.svg(),
                        onPressed: () => pickImages(context),
                        label: Text(context.l10n.addImage),
                      ),
                    ),
                  ),
                ),
              if (state.isNotEmpty)
                Expanded(
                  child: ReorderableGridView.count(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 10,
                    ),
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    onReorder: (oldIndex, newIndex) {
                      context
                          .read<ImagePickerCubit>()
                          .reorderImages(oldIndex, newIndex);
                    },
                    children: state.asMap().entries.map((entry) {
                      final index = entry.key;
                      final file = entry.value;
                      return Stack(
                        key: ValueKey('${file.path}_$index'),
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xffE6E6E6),
                                  width: 1.1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 6,
                            left: 6,
                            child: Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.pr,
                              ),
                              child: FittedBox(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<ImagePickerCubit>()
                                    .removeImage(file);
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withValues(alpha: 0.35),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
          bottomNavigationBar:
              CachedBannerAd(cachedAdUtil: BannerAllUtil.instance),
        );
      },
    );
  }
}
