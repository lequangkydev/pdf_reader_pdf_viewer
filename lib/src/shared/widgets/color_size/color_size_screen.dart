import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import 'cubit/silder_cubit.dart';
import 'cubit/size_cubit.dart';

class ColorSizeScreen extends StatelessWidget {
  const ColorSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SizeCubit()),
        BlocProvider(create: (context) => SliderOpacityCubit()),
      ],
      child: buildOpacitySlider(context),
    );
  }

  Widget buildOpacitySlider(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            children: [
              BlocBuilder<SizeCubit, dynamic>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      context.l10n.size,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<SliderOpacityCubit, double>(
                  builder: (context, state) {
                    return CustomSlider(
                      value: state,
                      onChanged: (value) {
                        context.read<SliderOpacityCubit>().update(value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomSlider extends Slider {
  const CustomSlider({
    super.key,
    super.onChanged,
    required super.value,
  });

  @override
  Color? get thumbColor => Colors.white;

  @override
  Color? get activeColor => AppColors.pr;

  @override
  Color? get inactiveColor => Colors.black.withOpacity(0.15);
}
