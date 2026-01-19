import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../module/admob/model/ad_config/ad_config.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/large_native_ad.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../global/global.dart';
import '../../shared/cubit/ad_visibility_cubit.dart';
import '../../shared/cubit/value_cubit.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/helpers/logger_utils.dart';
import '../../shared/helpers/permission_util.dart';
import '../../shared/utils/style_utils.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';
import '../../shared/widgets/button_widget.dart';
import '../../shared/widgets/custom_switch.dart';
import 'cubit/storage_status_cubit.dart';

part 'widget/permission_appbar.dart';
part 'widget/permission_body.dart';

@RoutePage()
class PermissionScreen extends StatefulLoggableWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoragePermissionCubit(false),
        ),
        BlocProvider(
          create: (context) => CameraPermissionCubit(false),
        ),
      ],
      child: PermissionBody(),
    );
  }
}
