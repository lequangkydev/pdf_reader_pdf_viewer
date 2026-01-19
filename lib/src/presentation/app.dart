import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_lifecycle_detector/flutter_lifecycle_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../../l10n/app_localizations.dart';
import '../../module/color_picker/cubit/saved_colors_cubit.dart';
import '../config/di/di.dart';
import '../config/navigation/app_router.dart';
import '../config/observer/route_observer.dart';
import '../config/theme/light/light_theme.dart';
import '../global/global.dart';
import '../services/default_app_checker.dart';
import '../shared/cubit/ad_visibility_cubit.dart';
import '../shared/cubit/rate_status_cubit.dart';
import '../shared/cubit/shell_document_tab_cubit.dart';
import '../shared/enum/language.dart';
import '../shared/screen/cubit/bottom_tab_cubit.dart';
import 'all_documents/cubit/all_file_cubit.dart';
import 'all_documents/cubit/docs_cubit.dart';
import 'all_documents/cubit/excel_cubit.dart';
import 'all_documents/cubit/pdf_cubit.dart';
import 'all_documents/cubit/ppt_cubit.dart';
import 'document/cubit/sort_cubit.dart';
import 'document/cubit/tab_cubit.dart';
import 'document_tool/cubit/scan_pdf_cubit.dart';
import 'language/cubit/language_cubit.dart';
import 'permission/cubit/storage_status_cubit.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double get designWidth => 360; //default
  double get designHeight => 800; //default

  @override
  void initState() {
    super.initState();

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      if (value.isNotEmpty) {
        Global.instance.sharedFiles = value.last;
      }
      ReceiveSharingIntent.instance.reset();
    });
    DefaultAppChecker.setMethodCallHandler();
    FlutterLifecycleDetector().onBackgroundChange.listen((isBackground) {
      /// `isBackground` is true => background
      /// `isBackground` is false => foreground
      if (isBackground) {
        Global.instance.currentRouteName = getIt<AppRouter>().current.name;
      }
      log('Status background $isBackground');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<LanguageCubit>()..initLanguage()),
        BlocProvider(
          create: (context) => getIt<AdVisibilityCubit>(),
        ),
        BlocProvider(
          create: (context) => RateStatusCubit(),
        ),
        BlocProvider(
          create: (context) => getIt<BottomTabCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<TabCubit>(),
        ),
        BlocProvider(create: (context) => SortCubit()),
        BlocProvider(create: (context) => SavedColorCubit()),
        BlocProvider(create: (context) => getIt<PdfCubit>()),
        BlocProvider(create: (context) => getIt<DocsCubit>()),
        BlocProvider(create: (context) => getIt<ExcelCubit>()),
        BlocProvider(create: (context) => getIt<PptCubit>()),
        BlocProvider(create: (context) => getIt<AllFileCubit>()),
        BlocProvider(create: (context) => ShellDocumentTabCubit()),
        BlocProvider(create: (context) => ScanPdfCubit()),
        BlocProvider(
          create: (context) => StoragePermissionCubit(false),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(designWidth, designHeight),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (context, child) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const BodyApp(),
        ),
      ),
    );
  }
}

class BodyApp extends StatelessWidget {
  const BodyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context
        .select<LanguageCubit, Languages?>((cubit) => cubit.state.language);
    if (currentLanguage != null) {
      DefaultAppChecker.updateLocale(currentLanguage.code);
    }
    return BlocConsumer<LanguageCubit, LanguageState>(
      listener: (context, state) {
        if (state.language != null) {
          DefaultAppChecker.updateLocale(state.language!.code);
        }
      },
      bloc: getIt<LanguageCubit>(),
      builder: (BuildContext context, state) {
        final String defaultLanguage = Global.defaultLocale.split('_').first;
        final language = Languages.values.firstWhere(
          (element) => element.code == defaultLanguage,
          orElse: () => Languages.english,
        );
        final selectedLanguage = state.language;
        return MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          locale: selectedLanguage?.code != null
              ? Locale.fromSubtags(
                  languageCode: selectedLanguage!.code,
                  scriptCode: selectedLanguage.scriptCode,
                  countryCode: selectedLanguage.countryCode,
                )
              : Locale(language.code),
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          // darkTheme: darkThemeData, //optional
          routerConfig: getIt<AppRouter>().config(
            navigatorObservers: () => [MainRouteObserver()],
          ),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
