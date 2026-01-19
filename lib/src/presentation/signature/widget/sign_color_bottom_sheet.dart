import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../cubit/signature_pad_setting_cubit.dart';

class SignColorBottomSheet extends StatefulWidget {
  const SignColorBottomSheet({
    super.key,
    required this.parentContext,
    required this.color,
  });

  final BuildContext parentContext;
  final Color color;

  static void show({required BuildContext context, required Color color}) {
    showBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxWidth: 1.sw,
      ),
      builder: (_) {
        return SignColorBottomSheet(
          parentContext: context,
          color: color,
        );
      },
    );
  }

  @override
  State<SignColorBottomSheet> createState() => _SignColorBottomSheetState();
}

class _SignColorBottomSheetState extends State<SignColorBottomSheet> {
  List<Color> get colors => [
        Color(0xFF000000),
        Color(0xFF444444),
        Color(0xFF777777),
        Color(0xFFAAAAAA),
        Color(0xFFCCCCCC),
        Color(0xFFFFFFFF),
        Color(0xFFD76263),
        Color(0xFFEB5757),
        Color(0xFFE62238),
        Color(0xFFFFC09D),
        Color(0xFFF2994A),
        Color(0xFFFCF485),
        Color(0xFFF2C94C),
        Color(0xFFC5FB72),
        Color(0xFF6BD928),
        Color(0xFF0000FE),
        Color(0xFFFB88FF),
        Color(0xFF9B51E0),
        Color(0xFFA42F87),
        Color(0xFFFF809D),
      ];

  late Color selectedColor = widget.color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 8).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 32.r,
                  height: 3.r,
                  decoration: BoxDecoration(
                    color: AppColors.colorE6E6E6,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
              SizedBox(height: 12.r),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16).r,
                child: SizedBox(
                  height: 26.r,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final color = colors[index];
                      return _ColorButton(
                        onTap: () {
                          widget.parentContext
                              .read<SignaturePadSettingCubit>()
                              .updateColor(color);
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        color: color,
                        isSelected: color == selectedColor,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 12.r);
                    },
                    itemCount: colors.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorButton extends StatelessWidget {
  const _ColorButton({
    super.key,
    required this.onTap,
    required this.color,
    this.isSelected = false,
  });

  final VoidCallback onTap;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: 26.r,
      height: 26.r,
      onTap: onTap,
      padding: isSelected ? EdgeInsets.all(1.5.r) : EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: () {
          if (isSelected) {
            return Border.all(
              color: AppColors.pr,
              width: 1.5.r,
            );
          }
          if (color == Colors.white) {
            return Border.all(
              color: AppColors.colorE6E6E6,
              width: 1.r,
            );
          }
          return null;
        }(),
      ),
      child: CircleAvatar(
        backgroundColor: color,
      ),
    );
  }
}
