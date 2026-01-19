part of '../signature_pad_screen.dart';

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            padding: const EdgeInsets.all(12).r,
            onTap: () {
              context.maybePop();
            },
            child: Assets.icons.close.svg(width: 26.r),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocSelector<DrawCubit, DrawState, bool>(
                selector: (state) {
                  return state.undoStack.isNotEmpty;
                },
                builder: (context, enable) {
                  return CustomButton(
                    padding: EdgeInsets.all(12.r),
                    onTap: () {
                      context.read<DrawCubit>().clear();
                    },
                    child: Opacity(
                      opacity: enable ? 1 : 0.8,
                      child: Assets.icons.restart.svg(width: 26.r),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16.r,
                child: VerticalDivider(
                  color: const Color(0xffDDDDDD),
                  thickness: 1.r,
                  width: 24.r,
                ),
              ),
              Row(
                children: [
                  BlocSelector<DrawCubit, DrawState, bool>(
                    selector: (state) {
                      return state.undoStack.isNotEmpty;
                    },
                    builder: (context, enable) {
                      return CustomButton(
                        padding: EdgeInsets.all(12.r),
                        onTap: () {
                          context.read<DrawCubit>().undo();
                        },
                        child: Assets.icons.undo.svg(
                          width: 26.r,
                          colorFilter: ColorFilter.mode(
                            enable ? AppColors.b75 : AppColors.b25,
                            BlendMode.srcIn,
                          ),
                        ),
                      );
                    },
                  ),
                  BlocSelector<DrawCubit, DrawState, bool>(
                    selector: (state) {
                      return state.redoStack.isNotEmpty;
                    },
                    builder: (context, enable) {
                      return CustomButton(
                        padding: EdgeInsets.all(12.r),
                        onTap: () {
                          context.read<DrawCubit>().redo();
                        },
                        child: Assets.icons.redo.svg(
                          width: 26.r,
                          colorFilter: ColorFilter.mode(
                            enable ? AppColors.b75 : AppColors.b25,
                            BlendMode.srcIn,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          CustomButton(
            padding: const EdgeInsets.all(12).r,
            onTap: () {
              context.read<SignaturePadController>().saveSignature(context);
            },
            child: Assets.icons.check.svg(width: 26.r),
          ),
        ],
      ),
    );
  }
}
