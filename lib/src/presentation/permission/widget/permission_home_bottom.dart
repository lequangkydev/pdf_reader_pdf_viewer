import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/cubit/value_cubit.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/helpers/permission_util.dart';
import '../../../shared/mixin/permission_mixin.dart';
import '../../../shared/utils/style_utils.dart';
import '../../../shared/widgets/custom_switch.dart';

Future<dynamic> showBottomSheetPermission(
    BuildContext context, Widget child) async {
  var result = await showModalBottomSheet(
    backgroundColor: Colors.black,
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
    context: context,
    builder: (context) => child,
  );
  return result;
}

class LocationBottomScreen extends StatefulLoggableWidget {
  const LocationBottomScreen({
    super.key,
    required this.type,
  });

  final int type;

  @override
  State<LocationBottomScreen> createState() => _LocationBottomScreenState();
}

class _LocationBottomScreenState extends State<LocationBottomScreen>
    with PermissionMixin, WidgetsBindingObserver {
  final ValueCubit<bool> locationCubit = ValueCubit(true);

  FutureOr<void> _onLocationSwitchChanged(BuildContext context) async {
    final reject = await Permission.locationWhenInUse.isPermanentlyDenied;
    if (reject) {
      MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
      showGoToSetting();
      return;
    }
    await PermissionUtil.instance.requestStoragePermission();
  }

  Future<void> showGoToSetting() async {
    await showDialogGoToSetting(
        title: 'context.l10n.requestLocationPermission',
        content: 'context.l10n.pleaseGrantLocationPermission',
        image: Assets.images.permission.path,
        callback: () {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final statusLocation = await checkPermissionLocationStatus();
      locationCubit.update(statusLocation.isGranted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff121315)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.verticalSpace,
            Text(context.l10n.permission,
                style: StyleUtils.style.s20.bold.white),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    10.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        _onLocationSwitchChanged(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: AppColors.pr),
                        child: Text(
                          'context.l10n.location',
                          style: StyleUtils.style.white.s16,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'context.l10n.requestLocationPermission',
                        textAlign: TextAlign.center,
                        style: StyleUtils.style.s18.white.bold,
                      ),
                    ),
                    4.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        '${'context.l10n.requiresPermissionBottom'} ${'context.l10n.location'}',
                        textAlign: TextAlign.center,
                        style: StyleUtils.style.s16.white.regular,
                      ),
                    ),
                    24.verticalSpace,
                    Image.asset(
                      Assets.images.permission.path,
                      height: 140.h,
                      width: 140.h,
                    ),
                    24.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE4ECFF),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                '${'context.l10n.youCanSelect'} ${'context.l10n.location'}',
                                style: StyleUtils.style.s16.regular.white),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: CustomSwitch(
                                value: true,
                                onChanged: (value) {
                                  /*
                            Fluttertoast.showToast(msg: context.l10n.plsClickLocation)*/
                                  ;
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            /*16.verticalSpace,
            Visibility(
              visible: !getIt<SettingBloc>().state.rotate,
              child: CommonNativeAd(
                maintainSize: true,
                adId: adUnitId.nativePopupPermission,
                remoteKey: AdRemoteKeys.nativePopupPermission,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
