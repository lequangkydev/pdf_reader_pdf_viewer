part of '../uninstall_screen.dart';

class _ProblemPage extends StatefulWidget {
  const _ProblemPage();

  @override
  State<_ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<_ProblemPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.whatProblemsYouEncounterDuringUse,
            style: TextStyle(
              height: 1.1,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 12).h,
            child: _buildItem(
              image: Assets.images.noteError,
              text: context.l10n.unableToReceiveFiles,
              buttonLabel: context.l10n.tryAgain,
              onButtonTap: () async {
                await PermissionUtil.instance.requestStoragePermission();
                if (await PermissionUtil.instance.checkStoragePermission()) {
                  context.read<AllFileCubit>().reloadFile();
                  getIt<AppRouter>().replaceAll([const ShellRoute()]);
                  getIt<BottomTabCubit>().changeTab(BottomTab.document);
                }
              },
            ),
          ),
          _buildItem(
            image: Assets.images.humanError,
            text: context.l10n.unableToViewTheFile,
            buttonLabel: context.l10n.explore,
            onButtonTap: () {
              getIt<AppRouter>().replaceAll([const ShellRoute()]);
              getIt<BottomTabCubit>().changeTab(BottomTab.document);
            },
          ),
          20.verticalSpace,
          CommonNativeAd(
            key: const Key('native_uninstall'),
            borderRadius: BorderRadius.circular(10),
            adConfig: adUnitsConfig.nativeUninstall,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required AssetGenImage image,
    required String text,
    required String buttonLabel,
    required VoidCallback onButtonTap,
  }) {
    return _ItemCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16).r,
      child: Row(
        children: [
          image.image(
            width: 36.r,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4).w,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100.w,
            height: 40.h,
            child: FilledButton(
              onPressed: onButtonTap,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4).w,
              ),
              child: MarqueeText(
                text: buttonLabel,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
