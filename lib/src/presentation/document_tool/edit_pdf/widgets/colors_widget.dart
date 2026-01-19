import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/extension/number_extension.dart';

final List<Color> colorsEdit = [
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

class ColorsTab extends StatelessWidget {
  const ColorsTab({
    super.key,
    this.initialColor,
    required this.onColorSelected,
  });

  final Color? initialColor;
  final ValueChanged<Color> onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.r,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _ColorsList(
        colors: colorsEdit,
        initialColor: initialColor,
        onColorSelected: onColorSelected,
      ),
    );
  }
}

class _ColorsList extends StatefulWidget {
  const _ColorsList({
    required this.colors,
    this.initialColor,
    required this.onColorSelected,
  });

  final List<Color> colors;
  final Color? initialColor;
  final ValueChanged<Color> onColorSelected;

  @override
  State<_ColorsList> createState() => _ColorsListState();
}

class _ColorsListState extends State<_ColorsList> {
  Color? selectedColor;
  late List<GlobalKey> _itemKeys;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor ?? widget.colors.first;
    _itemKeys = List.generate(widget.colors.length, (_) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = widget.colors.indexOf(selectedColor!);
      if (index != -1) {
        final context = _itemKeys[index].currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: widget.colors.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final color = widget.colors[index];
        return _ColorItem(
          key: _itemKeys[index],
          color: color,
          isSelected: color == selectedColor,
          onTap: () {
            setState(() => selectedColor = color);
            widget.onColorSelected(color);
          },
        );
      },
      separatorBuilder: (context, index) => 12.hSpace,
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    super.key,
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
        width: 28,
        height: 28,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.pr : Colors.transparent,
            width: 1.5.r,
          ),
        ),
        child: CircleAvatar(backgroundColor: color),
      ),
    );
  }
}
