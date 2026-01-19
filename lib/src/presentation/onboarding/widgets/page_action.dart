part of '../onboarding_screen.dart';

class PageAction extends StatelessWidget {
  const PageAction({
    super.key,
    required this.pageController,
    required this.index,
    this.isLast = false,
  });

  final PageController pageController;
  final int index;
  final bool isLast;

  void swipeToNextPage(BuildContext context, int currentIndex) {
    context.read<SwipePageCubit>().update(false);
    if (currentIndex == 0) {
      AnalyticLogger.instance
          .logEventWithScreen(event: OnboardingEvent.next_intro1);
    }
    if (currentIndex == 1) {
      AnalyticLogger.instance
          .logEventWithScreen(event: OnboardingEvent.next_intro2);
    }
    if (currentIndex == 2) {
      AnalyticLogger.instance
          .logEventWithScreen(event: OnboardingEvent.next_intro3);
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> goToNextScreen(BuildContext context) async {
    context.read<SwipePageCubit>().update(false);
    AnalyticLogger.instance
        .logEventWithScreen(event: OnboardingEvent.next_intro4);
    if (Global.instance.isFullAds && adUnitsConfig.interIntro.isEnable) {
      bool isClickAds = false;
      Global.instance.fromIntro = true;
      await InterAdUtil.instance.showInterAd(
        adConfig: adUnitsConfig.interIntro,
        forceShow: true,
        adDismiss: () {
          if (isClickAds) {
            AnalyticLogger.instance.logEvent(
                event: OnboardingEvent.Intro_Reopen_after_ads_inter_INTRO);
          }
        },
        onShowed: () {
          AnalyticLogger.instance
              .logEvent(event: OnboardingEvent.Intro_Vew_INTER_INTRO);
        },
        onclick: () {
          isClickAds = true;
          AnalyticLogger.instance
              .logEvent(event: OnboardingEvent.Intro_Click_INTER_INTRO);
        },
      );
    }
    AnalyticLogger.instance
        .logEventWithScreen(event: ShellEvent.Enter_FROM_Intro);
    if (Global.instance.sharedFiles != null) {
      openFile(Global.instance.sharedFiles!.path, context);
    } else {
      context.replaceRoute(const ShellRoute());
    }
    SharedPreferencesManager.instance.setFirstUseApp();
  }

  void tapNextButton(BuildContext context) {
    if (isLast) {
      goToNextScreen(context);
    } else {
      swipeToNextPage(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class VerticalAction extends PageAction {
  const VerticalAction({
    super.key,
    required super.pageController,
    required super.index,
    super.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: CustomIndicator(
            length: 3,
            currentIndex: index,
          ),
        ),
        16.vSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50).w,
          child: GestureDetector(
            onTap: () => tapNextButton(context),
            child: Container(
              padding: const EdgeInsets.all(12).r,
              decoration: BoxDecoration(
                color: AppColors.pr,
                borderRadius: BorderRadius.circular(50).r,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 22, height: 22),
                  Expanded(
                    child: Text(
                      isLast ? context.l10n.start : context.l10n.next,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HorizontalAction extends PageAction {
  const HorizontalAction({
    super.key,
    required super.pageController,
    required super.index,
    super.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: CustomIndicator(
              length: 3,
              currentIndex: index,
            ),
          ),
          16.vSpace,
          SizedBox(
            height: 40,
            child: FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              onPressed: () => tapNextButton(context),
              child: Text(
                isLast ? context.l10n.start : context.l10n.next,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VerticalSmallAction extends PageAction {
  const VerticalSmallAction({
    super.key,
    required super.pageController,
    required super.index,
    super.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: Global.instance.isFullAds
          ? [buildIndicator(), 10.vSpace, buildButton(context)]
          : [buildButton(context), buildIndicator()],
    );
  }

  Widget buildButton(BuildContext context) {
    return GestureDetector(
      onTap: () => tapNextButton(context),
      child: Padding(
        padding: Global.instance.isFullAds
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Text(
          isLast ? context.l10n.start : context.l10n.next,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.pr,
            height: 1,
          ),
        ),
      ),
    );
  }

  Center buildIndicator() {
    return Center(
      child: CustomIndicator(
        length: 3,
        currentIndex: index,
      ),
    );
  }
}
