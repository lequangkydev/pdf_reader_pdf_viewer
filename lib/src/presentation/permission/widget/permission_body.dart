part of '../permission_screen.dart';

class PermissionBody extends StatefulWidget {
  const PermissionBody({super.key});

  @override
  State<PermissionBody> createState() => _PermissionContentState();
}

class _PermissionContentState extends State<PermissionBody>
    with WidgetsBindingObserver {
  NativeAdController? currentCtrl;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
    super.initState();
  }

  Future<void> loadNativeAd(AdUnitConfig adConfig) async {
    if (adConfig.isEnable && Global.instance.isFullAds) {
      final tempController = NativeAdController(
        adId: adConfig.id,
        adId2: adConfig.id2,
        adId2RequestPercentage: adConfig.id2RequestPercentage,
        factoryId: largeNativeAdFactory,
      );
      await tempController.load();
      setState(() {
        currentCtrl = tempController;
      });
    }
  }

  // void loadNativeCamera() {
  //   loadNativeAd(adUnitsConfig.nativePermissionCamera);
  // }
  //
  // void loadNativeStorage() {
  //   loadNativeAd(adUnitsConfig.nativePermissionStorage);
  // }

  Future<void> _checkPermission() async {
    await _checkStoragePermission();
    await _checkCameraPermission();
  }

  Future<void> _checkStoragePermission() async {
    final status = await PermissionUtil.instance.checkStoragePermission();
    if (mounted) {
      context.read<StoragePermissionCubit>().update(status);
    }
  }

  Future<void> _checkCameraPermission() async {
    final PermissionStatus status =
        await PermissionUtil.instance.checkCameraPermission();
    if (mounted) {
      context
          .read<CameraPermissionCubit>()
          .update(status.isGranted || status.isLimited);
    }
  }

  FutureOr<void> _onStorageSwitchChanged(bool value) async {
    if (value) {
      // loadNativeStorage();
      _toggleAd(false);
      context.read<AdVisibilityCubit>().update(false);
      final status = await PermissionUtil.instance.requestStoragePermission();
      if (mounted) {
        context.read<StoragePermissionCubit>().update(status);
        context.read<AdVisibilityCubit>().update(true);
      }
      _toggleAd(true);
    }
  }

  FutureOr<void> _onCameraSwitchChanged(bool value) async {
    if (value) {
      // loadNativeCamera();
      _toggleAd(false);
      final PermissionStatus status =
          await PermissionUtil.instance.requestCameraPermission(context);
      logger.e("_onCameraSwitchChanged: $status");

      if (mounted) {
        context
            .read<CameraPermissionCubit>()
            .update(status.isGranted || status.isLimited);
      }
      _toggleAd(true);
    }
  }

  void _toggleAd(bool status) {
    context.read<AdVisibilityCubit>().update(status);
  }

  Widget _buildItem({
    required String title,
    required String path,
    required ValueCubit<bool> cubit,
    required FutureOr<void> Function(bool value) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEDEDED)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(path),
              12.horizontalSpace,
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.sFProDisplay,
                  fontSize: 16,
                  color: MyColors.p75,
                ),
              ),
            ],
          ),
          BlocBuilder<ValueCubit<bool>, bool>(
            bloc: cubit,
            builder: (context, state) => CustomSwitch(
              value: state,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.permission,
        showLeading: false,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(builder: (context) {
            final storageStatus = context.watch<StoragePermissionCubit>().state;
            final cameraStatus = context.watch<CameraPermissionCubit>().state;
            return ButtonWidget(
              onTap: () {
                context.router.replaceAll([const ShellRoute()]);
              },
              child: Text(
                storageStatus || cameraStatus
                    ? context.l10n.continuePer
                    : context.l10n.grantPermission,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }),
          4.vSpace,
          // _buildAd(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset(
              Assets.images.permission.path,
              height: 150,
            ),
            16.verticalSpace,
            Text(
              context.l10n.requirePermission,
              textAlign: TextAlign.center,
              style: StyleUtils.style.s14.medium.b50,
            ),
            32.verticalSpace,
            _buildItem(
              title: context.l10n.storage,
              path: Assets.icons.storagePermission.path,
              cubit: context.read<StoragePermissionCubit>(),
              onChanged: _onStorageSwitchChanged,
            ),
            8.verticalSpace,
            _buildItem(
              title: context.l10n.camera,
              path: Assets.icons.cameraPermission.path,
              cubit: context.read<CameraPermissionCubit>(),
              onChanged: _onCameraSwitchChanged,
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }

  // Widget _buildAd() {
  //   if (!Global.instance.isFullAds) {
  //     return const SizedBox.shrink();
  //   }
  //   if (currentCtrl != null) {
  //     return LargeNativeAd(
  //       controller: currentCtrl,
  //       visible: currentCtrl != null,
  //       key: ValueKey(currentCtrl!.controllerId),
  //     );
  //   }
  //   return LargeNativeAd(
  //     adConfig: adUnitsConfig.nativePermission,
  //   );
  // }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
