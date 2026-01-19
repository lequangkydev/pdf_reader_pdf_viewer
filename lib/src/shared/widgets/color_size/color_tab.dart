import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';
import '../../extension/number_extension.dart';
import 'color_picker_button.dart';
import 'cubit/select_color_cubit.dart';

final List<Color> backgroundColors = [
  const Color(0xFF000000),
  const Color(0xFFFEFFFE),
  const Color(0xFF01C7FC),
  const Color(0xFF3A87FD),
  const Color(0xFF5E30EB),
  const Color(0xFFBE38F3),
  const Color(0xFFE63B7A),
  const Color(0xFFFE6250),
  const Color(0xFFFE8648),
  const Color(0xFFFEB43F),
  const Color(0xFFFECB3E),
  const Color(0xFFFFF76B),
  const Color(0xFFE4EF65),
  const Color(0xFF96D35F),
];

class ColorsTab extends StatefulWidget {
  const ColorsTab({
    super.key,
    required this.selectColorCubit,
    this.initialColor,
  });

  final SelectColorCubit selectColorCubit;
  final Color? initialColor;

  @override
  State<ColorsTab> createState() => _ColorsTabState();
}

class _ColorsTabState extends State<ColorsTab> {
  @override
  void initState() {
    if (widget.initialColor != null) {
      widget.selectColorCubit.update(widget.initialColor!);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ColorsTab oldWidget) {
    if (widget.initialColor != null) {
      widget.selectColorCubit.update(widget.initialColor!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.r,
      child: _ColorsList(selectColorCubit: widget.selectColorCubit),
    );
  }
}

class _ColorsList extends StatelessWidget {
  const _ColorsList({
    required this.selectColorCubit,
  });

  final SelectColorCubit selectColorCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectColorCubit, Color?>(
      bloc: selectColorCubit,
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: backgroundColors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final color = backgroundColors[index];
            if (index == 0) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox.square(
                      dimension: 32,
                      child: ColorPickerButton(
                        onTap: () async {
                          // Code for custom color picker button
                        },
                        context: context,
                        onPickedColor: (pickedColor) {
                          selectColorCubit.update(pickedColor);
                        },
                      ),
                    ),
                  ),
                  12.hSpace,
                  _ColorItem(
                    color: color,
                    onTap: () => selectColorCubit.update(color),
                    isSelected: state == color,
                  ),
                ],
              );
            } else {
              return _ColorItem(
                color: color,
                onTap: () => selectColorCubit.update(color),
                isSelected: state == color,
              );
            }
          },
          separatorBuilder: (context, index) => 12.hSpace,
        );
      },
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.pr : Colors.transparent,
            width: 2.r,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cerebralGrey.withOpacity(0.2),
              spreadRadius: 1.r,
              blurRadius: 5.r,
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: color,
        ),
      ),
    );
  }
}
