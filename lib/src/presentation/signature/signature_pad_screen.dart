import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/widgets/custom_button.dart';
import 'cubit/draw/draw_cubit.dart';
import 'cubit/signature_pad_setting_cubit.dart';
import 'model/signature_pad_setting.dart';
import 'utils/signature_pad_controller.dart';
import 'widget/sign_color_bottom_sheet.dart';
import 'widget/sign_pad_background_painter.dart';
import 'widget/sign_width_bottom_sheet.dart';
import 'widget/signature_pad.dart';

part 'widget/bottom_bar.dart';
part 'widget/header_actions.dart';

@RoutePage()
class SignaturePadScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const SignaturePadScreen({
    super.key,
  });

  @override
  State<SignaturePadScreen> createState() => _CreatingSignatureScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SignaturePadController(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignaturePadSettingCubit(),
          ),
          BlocProvider(
            create: (context) => DrawCubit(),
          ),
        ],
        child: this,
      ),
    );
  }
}

class _CreatingSignatureScreenState extends State<SignaturePadScreen> {
  late final controller = context.read<SignaturePadController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeaderAction(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 33.r),
                child: CustomPaint(
                  painter: SignPadBackgroudPainter(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SignaturePad(),
                  ),
                ),
              ),
            ),
            const _BottomBar(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
