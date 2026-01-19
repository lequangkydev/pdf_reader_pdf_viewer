import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../services/default_app_checker.dart';
import '../../../../shared/extension/context_extension.dart';
import '../cubit/add_image_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../enum/pdf_tool_enum.dart';
import 'tool_edit_pdf.dart';

class AddToolWidget extends StatelessWidget {
  const AddToolWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectDetailToolCubit, DetailToolEditEnum?>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: BottomSheetItem(
                icon: Assets.icons.bottomSheet.text,
                label: context.l10n.addText,
                isSelect: state == DetailToolEditEnum.addText,
                onTap: () => context
                    .read<SelectDetailToolCubit>()
                    .selectDetailTool(DetailToolEditEnum.addText),
              ),
            ),
            Expanded(
              child: BottomSheetItem(
                icon: Assets.icons.addImage,
                label: context.l10n.addImage,
                isSelect: state == DetailToolEditEnum.addImage,
                onTap: () async {
                  //pick image từ lib
                  DefaultAppChecker.blockNotify();
                  MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null && context.mounted) {
                    context.read<AddImageCubit>().changeImage(File(image.path));
                  }
                  DefaultAppChecker.unBlockNotify();
                  if (image == null) {
                    return;
                  }
                  context
                      .read<SelectDetailToolCubit>()
                      .selectDetailTool(DetailToolEditEnum.addImage);
                },
              ),
            ),
            Expanded(
              child: BottomSheetItem(
                icon: Assets.icons.bottomSheet.watermarrk,
                label: context.l10n.watermark,
                isSelect: state == DetailToolEditEnum.waterMark,
                onTap: () => context
                    .read<SelectDetailToolCubit>()
                    .selectDetailTool(DetailToolEditEnum.waterMark),
              ),
            ),
          ],
        );
      },
    );
  }
}
