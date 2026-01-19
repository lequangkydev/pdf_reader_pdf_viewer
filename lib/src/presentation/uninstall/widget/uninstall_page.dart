part of '../uninstall_screen.dart';

class _UninstallPage extends StatefulWidget {
  const _UninstallPage({super.key});

  @override
  State<_UninstallPage> createState() => _UninstallPageState();
}

class _UninstallPageState extends State<_UninstallPage> {
  final seasonCubit = ValueCubit<int>(0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.whyUninstallApp(F.title),
            style: TextStyle(
              height: 1.1,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          14.verticalSpace,
          BlocBuilder<ValueCubit<int>, int>(
            bloc: seasonCubit,
            builder: (context, state) {
              return Column(
                children: [
                  _buildItem(text: context.l10n.difficultToUse, value: 0),
                  _buildItem(text: context.l10n.tooManyAds, value: 1),
                  _buildItem(text: context.l10n.unableToViewTheFile, value: 2),
                  _buildItem(text: context.l10n.unableToReceiveFiles, value: 3),
                  _buildItem(text: context.l10n.others, value: 4),
                ],
              );
            },
          ),
          BlocSelector<ValueCubit<int>, int, bool>(
            bloc: seasonCubit,
            selector: (state) {
              return state == 4;
            },
            builder: (context, isOthers) {
              if (!isOthers) {
                return const SizedBox();
              }
              return _ItemCard(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16).r,
                margin: const EdgeInsets.symmetric(vertical: 6).h,
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: context.l10n
                          .pleaseEnterReasonForUninstalling(F.title),
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffB0B0B0),
                      )),
                  minLines: 4,
                  maxLines: 4,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String text,
    required int value,
  }) {
    return GestureDetector(
      onTap: () {
        seasonCubit.update(value);
      },
      behavior: HitTestBehavior.opaque,
      child: _ItemCard(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16).r,
        margin: const EdgeInsets.symmetric(vertical: 6).h,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            8.horizontalSpace,
            CustomRadio(
              isSelected: seasonCubit.state == value,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    MyAds.instance.appLifecycleReactor?.setShouldShow(true);
    super.dispose();
  }
}
