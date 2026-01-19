part of '../uninstall_screen.dart';

class _ItemCard extends Container {
  _ItemCard({
    super.child,
    super.padding,
    super.margin,
  });

  @override
  Decoration? get decoration => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xffF7DCDC),
            width: 1.r,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A000000),
              offset: const Offset(0, 2),
              blurRadius: 15.r,
            )
          ]);
}
