part of '../signature_pad_screen.dart';

class _BottomBar extends StatefulWidget {
  const _BottomBar();

  @override
  State<_BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<_BottomBar> {
  late final controller = context.read<SignaturePadController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 24).r,
      child: Row(
        children: [
          Expanded(
            child: BlocSelector<SignaturePadSettingCubit, SignaturePadSetting,
                double>(
              selector: (state) => state.strokeWidth / maxStrokeWidth,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _LineButton(
                      onTap: () {
                        context
                            .read<SignaturePadSettingCubit>()
                            .setWidthRatio(0.1);
                      },
                      icon: Assets.icons.lineLv1.svg(width: 24.r),
                      isSelected: state == 0.1,
                    ),
                    _LineButton(
                      onTap: () {
                        context
                            .read<SignaturePadSettingCubit>()
                            .setWidthRatio(0.5);
                      },
                      icon: Assets.icons.lineLv2.svg(width: 24.r),
                      isSelected: state == 0.5,
                    ),
                    _LineButton(
                      onTap: () {
                        context
                            .read<SignaturePadSettingCubit>()
                            .setWidthRatio(1);
                      },
                      icon: Assets.icons.lineLv3.svg(width: 24.r),
                      isSelected: state == 1,
                    ),
                    _LineButton(
                      onTap: () {
                        SignWidthBottomSheet.show(
                          context: context,
                          value: state,
                        );
                      },
                      icon: Assets.icons.tuning.svg(width: 24.r),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 16.r,
            child: VerticalDivider(
              color: const Color(0xffDDDDDD),
              thickness: 1.r,
              width: 48.r,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 26.r,
                child: Builder(builder: (context) {
                  final colors = context.select(
                      (SignaturePadSettingCubit bloc) =>
                          bloc.state.recentColors);
                  final selectedColor = context.select(
                      (SignaturePadSettingCubit bloc) => bloc.state.signColor);
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CustomButton(
                          onTap: () {
                            SignColorBottomSheet.show(
                              context: context,
                              color: selectedColor,
                            );
                          },
                          width: 26.r,
                          height: 26.r,
                          child: CircleAvatar(
                            child: Assets.images.colorPicker.image(),
                          ),
                        );
                      }
                      final color = colors[index - 1];
                      return _ColorButton(
                        onTap: () {
                          context
                              .read<SignaturePadSettingCubit>()
                              .updateColor(color);
                        },
                        color: color,
                        isSelected: color == selectedColor,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 12.r);
                    },
                    itemCount: 5,
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LineButton extends StatelessWidget {
  const _LineButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.isSelected = false,
  });

  final VoidCallback onTap;
  final Widget icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xfff2f2f2) : Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
      onTap: onTap,
      width: 36.r,
      height: 23.r,
      child: Center(child: icon),
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
