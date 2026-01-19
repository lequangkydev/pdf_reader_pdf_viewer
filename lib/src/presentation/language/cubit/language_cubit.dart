import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../global/global.dart';
import '../../../shared/cubit/value_cubit.dart';
import '../../../shared/enum/language.dart';

class LanguageState {
  const LanguageState({
    this.language,
    this.isSystemLanguage = false,
  });

  final Languages? language;
  final bool isSystemLanguage;
}

@singleton
class LanguageCubit extends ValueCubit<LanguageState> with HydratedMixin {
  LanguageCubit() : super(const LanguageState()) {
    hydrate();
  }
  void initLanguage() {
    if (state.language == null) {
      final String defaultLanguage = Global.defaultLocale.split('_').first;
      final language = Languages.values.firstWhereOrNull(
        (element) => element.code == defaultLanguage,
      );
      update(LanguageState(
        isSystemLanguage: language != null,
        language: language ?? Languages.english,
      ));
    } else {
      debugPrint("state:$state");
    }
  }

  @override
  LanguageState fromJson(Map<String, dynamic> json) {
    final String defaultLanguage = Global.defaultLocale.split('_').first;
    final language = Languages.values.firstWhereOrNull(
      (element) => element.code == defaultLanguage,
    );
    for (final element in Languages.values) {
      if (element.code == json['languageCode'] &&
          element.countryCode == json['countryCode']) {
        return LanguageState(
          language: element,
          isSystemLanguage: language != null && language.code == element.code,
        );
      }
    }
    return const LanguageState();
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {
      'languageCode': state.language?.code,
      'countryCode': state.language?.countryCode,
    };
  }
}
