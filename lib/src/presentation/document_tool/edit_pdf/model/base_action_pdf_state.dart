import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/global.dart';
import '../../../../shared/widgets/dialog/loading_dialog.dart';

mixin BaseActionPDFState {
  bool get isLoading;

  bool get isSuccess;

  String? get errorMessage;
}

class CommonActionListener {
  CommonActionListener._();

  static BlocListener<B, S>
      listen<B extends StateStreamable<S>, S extends BaseActionPDFState>({
    required void Function(BuildContext context, S state) onSuccess,
  }) {
    return BlocListener<B, S>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess ||
          previous.errorMessage != current.errorMessage ||
          previous.isLoading != current.isLoading,
      listener: (context, state) {
        if (state.isLoading) {
          LoadingOverlay.show();
        } else {
          LoadingOverlay.hide();
        }

        if (state.errorMessage != null) {
          showToast(state.errorMessage!);
        }

        if (state.isSuccess) {
          onSuccess(context, state);
        }
      },
    );
  }
}
