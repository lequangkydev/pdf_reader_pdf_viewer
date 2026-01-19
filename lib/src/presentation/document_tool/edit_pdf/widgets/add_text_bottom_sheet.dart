import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/extension/context_extension.dart';
import '../../../../shared/extension/number_extension.dart';
import '../../../../shared/widgets/color_size/color_tab.dart';
import '../../../../shared/widgets/color_size/cubit/select_color_cubit.dart';

Future<void> showTextEditorBottomSheet({
  required BuildContext context,
  required String title,
  required String text,
  required Color color,
  required ValueChanged<String> onTextChanged,
  required ValueChanged<Color> onColorChanged,
  String? Function(String)? validator, // 👈 nhận validator từ ngoài
}) {
  final textController = TextEditingController(text: text);
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.color222,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.enterText,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.color222,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.vSpace,
              Builder(builder: (context) {
                String? errorText;
                return StatefulBuilder(
                  builder: (context, setState) {
                    void validateNow(String value) {
                      errorText = validator?.call(value);
                      setState(() {});
                    }

                    return TextField(
                      controller: textController,
                      onChanged: (val) {
                        onTextChanged(val);
                        validateNow(val);
                      },
                      decoration: InputDecoration(
                        hintText: context.l10n.addText,
                        errorText: errorText,
                        suffixIcon: textController.text.isNotEmpty
                            ? IconButton(
                                icon: Assets.icons.closeSmall.svg(width: 20),
                                onPressed: () {
                                  textController.clear();
                                  setState(() {});
                                  onTextChanged('');
                                },
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.f2f2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.f2f2),
                        ),
                      ),
                    );
                  },
                );
              }),
              12.vSpace,
              Text(
                context.l10n.color,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.color222,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.vSpace,
              BlocProvider(
                create: (context) => SelectColorCubit()..update(color),
                child: Builder(builder: (context) {
                  return BlocListener<SelectColorCubit, Color?>(
                    listenWhen: (previous, current) => previous != current,
                    listener: (_, color1) {
                      if (color1 == null) {
                        return;
                      }
                      onColorChanged(color1);
                    },
                    child: ColorsTab(
                      selectColorCubit: context.read<SelectColorCubit>(),
                    ),
                  );
                }),
              ),
              16.vSpace,
            ],
          ),
        ),
      );
    },
  );
}
