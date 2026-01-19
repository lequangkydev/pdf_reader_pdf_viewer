import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../presentation/all_documents/cubit/all_file_cubit.dart';
import '../../presentation/all_documents/cubit/base_cubit.dart';
import '../../presentation/all_documents/cubit/docs_cubit.dart';
import '../../presentation/all_documents/cubit/excel_cubit.dart';
import '../../presentation/all_documents/cubit/pdf_cubit.dart';
import '../../presentation/all_documents/cubit/ppt_cubit.dart';
import '../constants/app_colors.dart';
import '../utils/localization_util.dart';
import '../utils/style_utils.dart';

enum TabBarType {
  all,
  pdf,
  word,
  excel,
  ppt;

  AssetGenImage get backgroundImage {
    final assets = switch (this) {
      TabBarType.all => Assets.images.frame.all,
      TabBarType.pdf => Assets.images.frame.pdf,
      TabBarType.word => Assets.images.frame.doc,
      TabBarType.excel => Assets.images.frame.excel,
      TabBarType.ppt => Assets.images.frame.ppt,
    };
    return assets;
  }

  TextStyle get valueStyle {
    switch (this) {
      case TabBarType.word:
        return StyleUtils.style.s16.semiBold.blue;
      case TabBarType.pdf:
        return StyleUtils.style.s16.semiBold.red;
      case TabBarType.ppt:
        return StyleUtils.style.s16.semiBold.orange;
      case TabBarType.excel:
        return StyleUtils.style.s16.semiBold.green;
      case TabBarType.all:
        return StyleUtils.style.s16.semiBold.pr;
    }
  }

  Color get valueColor {
    switch (this) {
      case TabBarType.word:
        return AppColors.doc;
      case TabBarType.pdf:
        return AppColors.pdf;
      case TabBarType.ppt:
        return AppColors.pptx;
      case TabBarType.excel:
        return AppColors.excel;
      case TabBarType.all:
        return AppColors.pr;
    }
  }

  Color get colorBg {
    switch (this) {
      case TabBarType.word:
        return const Color(0xff3C97FF).withValues(alpha: 0.05);
      case TabBarType.pdf:
        return const Color(0xffE00100).withValues(alpha: 0.05);
      case TabBarType.ppt:
        return const Color(0xffF2590C).withValues(alpha: 0.05);
      case TabBarType.excel:
        return const Color(0xff388E3C).withValues(alpha: 0.05);
      case TabBarType.all:
        return const Color(0xffE00100).withValues(alpha: 0.05);
    }
  }

  LinearGradient get backgroundGradient {
    final colors = switch (this) {
      TabBarType.all => [
          const Color(0xffFF0100).withValues(alpha: .13),
          const Color(0xffFF00FF).withValues(alpha: .0),
        ],
      TabBarType.pdf => [
          const Color(0xffE52120).withValues(alpha: .15),
          const Color(0xffE52120).withValues(alpha: .0),
        ],
      TabBarType.word => [
          const Color(0xff2979FF).withValues(alpha: .15),
          const Color(0xff2979FF).withValues(alpha: .0),
        ],
      TabBarType.excel => [
          const Color(0xff388E3C).withValues(alpha: .15),
          const Color(0xff388E3C).withValues(alpha: .0),
        ],
      TabBarType.ppt => [
          const Color(0xffF2590C).withValues(alpha: .15),
          const Color(0xffF2590C).withValues(alpha: .0),
        ],
    };
    return LinearGradient(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  LinearGradient get gradientTab {
    final colors = switch (this) {
      TabBarType.all => [
          const Color(0xffD10000).withValues(alpha: .0),
          const Color(0xffD10000).withValues(alpha: .1),
        ],
      TabBarType.pdf => [
          const Color(0xffF03E3D).withValues(alpha: .0),
          const Color(0xffF03E3D).withValues(alpha: .1),
        ],
      TabBarType.word => [
          const Color(0xff3B84FF).withValues(alpha: .0),
          const Color(0xff3B84FF).withValues(alpha: .1),
        ],
      TabBarType.excel => [
          const Color(0xff3F9E43).withValues(alpha: .0),
          const Color(0xff3F9E43).withValues(alpha: .1),
        ],
      TabBarType.ppt => [
          const Color(0xffF76E29).withValues(alpha: .0),
          const Color(0xffF76E29).withValues(alpha: .1),
        ],
    };
    return LinearGradient(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  String get valueSVG {
    switch (this) {
      case TabBarType.word:
        return Assets.icons.file.doc.path;
      case TabBarType.pdf:
        return Assets.icons.file.pdf.path;
      case TabBarType.ppt:
        return Assets.icons.file.ppt.path;
      case TabBarType.excel:
        return Assets.icons.file.excel.path;
      case TabBarType.all:
        return Assets.icons.file.pdf.path;
    }
  }

  String get valueTypeFile {
    switch (this) {
      case TabBarType.word:
        return '.doc';
      case TabBarType.pdf:
        return '.pdf';
      case TabBarType.ppt:
        return '.ppt';
      case TabBarType.excel:
        return '.xlsx';
      case TabBarType.all:
        return '.pdf';
    }
  }

  String get valueString {
    switch (this) {
      case TabBarType.word:
        return L10n.tr.word.toUpperCase();
      case TabBarType.pdf:
        return L10n.tr.pdf.toUpperCase();
      case TabBarType.ppt:
        return L10n.tr.ppt.toUpperCase();
      case TabBarType.excel:
        return L10n.tr.excel.toUpperCase();
      case TabBarType.all:
        return L10n.tr.all.toUpperCase();
    }
  }

  String get searchIn {
    switch (this) {
      case TabBarType.word:
        return L10n.tr.searchInDoc;
      case TabBarType.pdf:
        return L10n.tr.searchInPdf;
      case TabBarType.ppt:
        return L10n.tr.searchInPpt;
      case TabBarType.excel:
        return L10n.tr.searchInExcel;
      case TabBarType.all:
        return L10n.tr.searchInPdf;
    }
  }

  BaseFileCubit get valueCubit {
    final context = getIt<AppRouter>().navigatorKey.currentContext!;
    switch (this) {
      case TabBarType.word:
        return context.read<DocsCubit>();
      case TabBarType.pdf:
        return context.read<PdfCubit>();
      case TabBarType.ppt:
        return context.read<PptCubit>();
      case TabBarType.excel:
        return context.read<ExcelCubit>();
      case TabBarType.all:
        return context.read<AllFileCubit>();
    }
  }

  BaseFileCubit? getCubitForFile(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    if (['pdf'].contains(ext)) {
      return getIt<PdfCubit>();
    } else if (['doc', 'docx'].contains(ext)) {
      return getIt<DocsCubit>();
    } else if (['xls', 'xlsx'].contains(ext)) {
      return getIt<ExcelCubit>();
    } else if (['ppt', 'pptx'].contains(ext)) {
      return getIt<PptCubit>();
    }
    return null;
  }
}
