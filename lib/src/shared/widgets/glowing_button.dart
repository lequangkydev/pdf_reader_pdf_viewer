import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../extension/number_extension.dart';

class GlowingButton extends StatefulWidget {
  GlowingButton({
    super.key,
    required this.textBtn,
    required this.onTap,
    required this.isEnable,
  });

  final String textBtn;
  VoidCallback onTap;
  final bool isEnable;

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Animation<double>> _scaleAnimations = [];
  final List<Animation<double>> _opacityAnimations = [];
  final int _numberOfRipples = 3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    for (var i = 0; i < _numberOfRipples; i++) {
      _scaleAnimations.add(
        Tween<double>(begin: 1.0, end: 1.4).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.2 * i,
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );

      _opacityAnimations.add(
        Tween<double>(begin: 0.7, end: 0.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.2 * i,
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width - 80;
    const buttonHeight = 48.0;
    return GestureDetector(
      onTap: widget.onTap,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Các lớp ripple effect
            ...List.generate(_numberOfRipples, (index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimations[index].value,
                    child: Opacity(
                      opacity: _opacityAnimations[index].value,
                      child: Container(
                        width: buttonWidth,
                        height: 50,
                        decoration: BoxDecoration(
                          color: widget.isEnable
                              ? AppColors.pr.withValues(alpha: 0.3)
                              : AppColors.color80.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
            for (int i = 4; i >= 1; i--)
              Container(
                width: MediaQuery.of(context).size.width - 40 + i * 5,
                height: 48 + i * 5,
                decoration: BoxDecoration(
                  color: widget.isEnable
                      ? AppColors.pr.withValues(alpha: 0.05)
                      : AppColors.color80.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            // Nút chính
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 48,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.isEnable ? AppColors.pr : AppColors.color80,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  24.hSpace,
                  Expanded(
                    child: Text(
                      widget.textBtn,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
