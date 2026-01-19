import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.padding,
    this.margin,
    required this.child,
    this.decoration,
    this.width,
    this.height,
  });

  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  final Decoration? decoration;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: margin,
        width: width,
        height: height,
        decoration: decoration,
        padding: padding,
        child: child,
      ),
    );
  }
}
