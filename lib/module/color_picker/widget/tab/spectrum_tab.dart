part of '../../color_picker.dart';

class _SpectrumTab extends StatefulWidget {
  const _SpectrumTab({this.spectrumImg});

  final img.Image? spectrumImg;

  @override
  State<_SpectrumTab> createState() => _SpectrumTabState();
}

class _SpectrumTabState extends State<_SpectrumTab> {
  HSVColor hsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);
  final double markerSize = 30.r;
  late final centerMarker = Offset(markerSize / 2, markerSize / 2);

  Size imgSize = Size.zero;
  double imgRatio = 1;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        final Offset localPosition = _handlePosition(details.localPosition);
        updateColorAndPosition(localPosition, context);
      },
      onPointerMove: (event) {
        final Offset localPosition = _handlePosition(event.localPosition);
        updateColorAndPosition(localPosition, context);
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: LayoutBuilder(builder: (context, constraints) {
              imgSize = Size(constraints.maxWidth, constraints.maxHeight);
              if (widget.spectrumImg != null) {
                imgRatio = imgSize.width / widget.spectrumImg!.width;
              }

              return Assets.images.spectum.image(
                fit: BoxFit.fitWidth,
              );
            }),
          ),
          BlocBuilder<SpectrumPositionCubit, Offset>(
            builder: (context, state) {
              return Positioned(
                left: state.dx,
                top: state.dy,
                child: BlocBuilder<SelectedColorCubit, Color>(
                  builder: (context, state) {
                    final useWhiteBorder = state.lightness < 0.7;
                    return Container(
                      width: markerSize,
                      height: markerSize,
                      decoration: BoxDecoration(
                        color: state,
                        border: Border.all(
                          color: useWhiteBorder ? Colors.white : Colors.black,
                          width: 3.r,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Offset _handlePosition(Offset value) {
    final Offset position = Offset(
      value.dx.clamp(20.w, imgSize.width + 10.w),
      value.dy.clamp(20.h, imgSize.height + 10.h),
    );
    return position;
  }

  void updateColorAndPosition(Offset localPosition, BuildContext context) {
    final newPosition = localPosition - centerMarker;
    context.read<SpectrumPositionCubit>().update(newPosition);
    final img.Pixel? pixel = widget.spectrumImg?.getPixel(
      newPosition.dx ~/ imgRatio,
      newPosition.dy ~/ imgRatio,
    );
    if (pixel != null) {
      final Color color = Color.fromARGB(
        pixel.a.toInt(),
        pixel.r.toInt(),
        pixel.g.toInt(),
        pixel.b.toInt(),
      );
      context.read<SelectedColorCubit>().updateColor(color);
    }
  }
}
