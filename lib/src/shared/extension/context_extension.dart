import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../presentation/language/cubit/language_cubit.dart';
import '../enum/language.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  Languages? get currentLanguage => read<LanguageCubit>().state.language;
}
