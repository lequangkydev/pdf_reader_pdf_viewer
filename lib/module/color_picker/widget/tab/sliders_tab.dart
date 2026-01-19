part of '../../color_picker.dart';

class _SliderTab extends StatelessWidget {
  const _SliderTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      child: BlocBuilder<SelectedColorCubit, Color>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColorSlider(
                value: state.red / 255,
                colorType: ColorType.red,
                onChanged: (double value) => context
                    .read<SelectedColorCubit>()
                    .updateRed((value * 255).toInt()),
              ),
              ColorSlider(
                value: state.green / 255,
                colorType: ColorType.green,
                onChanged: (double value) => context
                    .read<SelectedColorCubit>()
                    .updateGreen((value * 255).toInt()),
              ),
              ColorSlider(
                value: state.blue / 255,
                colorType: ColorType.blue,
                onChanged: (double value) => context
                    .read<SelectedColorCubit>()
                    .updateBlue((value * 255).toInt()),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.displayP3HexColor,
                      style: const TextStyle(
                        color: Color(0xFF007AFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    padding: const EdgeInsets.all(8).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    width: 108.w,
                    child: BlocBuilder<SelectedColorCubit, Color>(
                      builder: (context, state) {
                        return Text(
                          state.hex,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
