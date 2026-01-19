import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart' as img;

import '../../src/config/di/di.dart';
import '../../src/config/navigation/app_router.dart';
import '../../src/gen/assets.gen.dart';
import '../../src/shared/extension/context_extension.dart';
import '../../src/shared/widgets/custom_tab_bar.dart';
import 'cubit/saved_colors_cubit.dart';
import 'cubit/selected_color_cubit.dart';
import 'cubit/selected_picker_tab_cubit.dart';
import 'cubit/spectrum_position_cubit.dart';
import 'util/color_grid_data.dart';
import 'util/utils.dart';
import 'widget/color_slider/color_slider.dart';
import 'widget/eye_drop/eye_dropper.dart';
import 'widget/opacity_slider/opacity_slider.dart';

part 'widget/tab/grid_tab.dart';
part 'widget/tab/sliders_tab.dart';
part 'widget/tab/spectrum_tab.dart';

final sliderThumbRadius = 15.r;

Future<Color?> showColorPicker({
  required BuildContext context,
  Color? selectedColor,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xffEBEBEB),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.r),
      ),
    ),
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    builder: (context) => CustomColorPicker(
      color: selectedColor ?? Colors.white,
      parentContext: context,
    ),
  ).then((value) async {
    if (value == 'pick') {
      await Future.delayed(const Duration(milliseconds: 300));
      final appContext = getIt<AppRouter>().navigatorKey.currentContext!;
      if (appContext.mounted) {
        EyeDropper.enableEyeDropper(appContext, (color) {
          if (color != null) {
            showColorPicker(context: context, selectedColor: color);
          }
        });
      }
    }
    return value == 'pick' ? null : value;
  });
}

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    super.key,
    required this.color,
    required this.parentContext,
  });

  final Color color;
  final BuildContext parentContext;

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker>
    with SingleTickerProviderStateMixin {
  img.Image? spectrumImg;
  late TabController tabController;

  @override
  void initState() {
    super.initState(); // luôn gọi super trước
    tabController = TabController(length: 3, vsync: this);
    loadSpectrumImage();
  }

  Future<void> loadSpectrumImage() async {
    final ByteData byteData = await rootBundle.load(Assets.images.spectum.path);
    final Uint8List bytes = byteData.buffer.asUint8List();
    final img.Image image = img.decodeImage(bytes)!;
    setState(() {
      spectrumImg = image;
    });
  }

  @override
  Widget build(BuildContext _) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectedColorCubit(widget.color),
        ),
        BlocProvider(
          create: (context) => SelectedPickerTabCubit(0),
        ),
        BlocProvider(
          create: (context) => SpectrumPositionCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return SizedBox(
          height: 600.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 9.h,
                  left: 8.w,
                  right: 15.w,
                ),
                child: buildTitle(context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: buildTabBar(
                  tabController: tabController,
                  context: context,
                  onTap: (int index) {
                    context.read<SelectedPickerTabCubit>().update(index);
                  },
                ),
              ),
              SizedBox(
                height: 300.h,
                child: buildTabView(
                  onColorChanged: (color) {
                    context.read<SelectedColorCubit>().updateColor(color);
                  },
                ),
              ),
              buildOpacitySlider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).w,
                child: Divider(
                  color: const Color(0x5C3C3C43),
                  height: 40.h,
                  thickness: 0.5,
                ),
              ),
              buildSavedColorList(),
            ],
          ),
        );
      }),
    );
  }

  Row buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            await context.maybePop('pick');
          },
          icon: Assets.icons.pickColor.svg(
            width: 20.r,
          ),
        ),
        Text(
          context.l10n.colorsOption,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.maybePop(context.read<SelectedColorCubit>().state);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff7F7F7F).withOpacity(0.2),
            ),
            child: Icon(
              Icons.close,
              color: const Color(0xff3D3D3D).withOpacity(0.5),
            ),
          ),
        )
      ],
    );
  }

  CustomTabBar buildTabBar({
    required TabController tabController,
    required BuildContext context,
    required void Function(int index) onTap,
  }) {
    return CustomTabBar(
      controller: tabController,
      isScrollable: false,
      onTap: onTap,
      tabs: [
        Text(
          context.l10n.gridOption,
        ),
        Text(
          context.l10n.spectrumOption,
        ),
        Text(
          context.l10n.slidersOption,
        ),
      ],
    );
  }

  Widget buildTabView({
    required void Function(Color color) onColorChanged,
  }) {
    return BlocBuilder<SelectedPickerTabCubit, int>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: () {
            switch (state) {
              case 0:
                return _GridTab(
                  onChanged: onColorChanged,
                  color: context.read<SelectedColorCubit>().state,
                );
              case 1:
                return _SpectrumTab(spectrumImg: spectrumImg);
              default:
                return const _SliderTab();
            }
          }(),
        );
      },
    );
  }

  Padding buildOpacitySlider() {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.w,
        right: 16.w,
      ),
      child: BlocBuilder<SelectedColorCubit, Color>(
        builder: (context, state) {
          return OpacitySlider(
            opacity: state.opacity,
            selectedColor: state,
            onChange: (value) =>
                context.read<SelectedColorCubit>().updateOpacity(value),
          );
        },
      ),
    );
  }

  Widget buildSavedColorList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              width: 70.r,
              height: 70.r,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.grid.provider(),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: BlocBuilder<SelectedColorCubit, Color>(
                builder: (context, state) {
                  return ColoredBox(
                    color: state,
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Builder(builder: (context) {
              final List<Color> data = context.watch<SavedColorCubit>().state;
              final int length = data.length < 9 ? data.length + 1 : 10;
              final Color selectedColor =
                  context.watch<SelectedColorCubit>().state;
              return GridView.builder(
                padding: EdgeInsets.only(left: 25.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 25.w,
                  mainAxisSpacing: 15.h,
                ),
                shrinkWrap: true,
                itemCount: length,
                itemBuilder: (context, index) {
                  if (index == length - 1) {
                    return GestureDetector(
                      onTap: () => context
                          .read<SavedColorCubit>()
                          .addToHead(selectedColor),
                      child: Assets.icons.addCircle.svg(),
                    );
                  }
                  final item = data[index];
                  final selected = selectedColor == item;
                  return GestureDetector(
                    onTap: () =>
                        context.read<SelectedColorCubit>().update(item),
                    child: buildItem(color: item, selected: selected),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildItem({required Color color, bool selected = false}) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        if (selected)
          Positioned(
            left: 2.r,
            top: 2.r,
            right: 2.r,
            bottom: 2.r,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.white,
                  width: 2.r,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
