import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/document_model.dart';
import '../../data/model/file_model.dart';
import '../../data/model/translate_model.dart';
import '../../presentation/ai/ai_detail_screen.dart';
import '../../presentation/ai/ai_guide_screen.dart';
import '../../presentation/ai/ai_result_screen.dart';
import '../../presentation/ai/feed_back_screen.dart';
import '../../presentation/ai/select_page_screen.dart';
import '../../presentation/brush_pdf/brush_pdf_screen.dart';
import '../../presentation/document/document_select_screen.dart';
import '../../presentation/document_tool/edit_pdf/edit_pdf_screen.dart';
import '../../presentation/document_tool/file_success/file_success_screen.dart';
import '../../presentation/document_tool/image_to_pdf/image_to_pdf_screen.dart';
import '../../presentation/document_tool/lock_pdf/lock_pdf_screen.dart';
import '../../presentation/document_tool/merge_pdf/merge_pdf_screen.dart';
import '../../presentation/document_tool/pdf_to_image/pdf_to_image_preview.dart';
import '../../presentation/document_tool/pdf_to_image/pdf_to_image_screen.dart';
import '../../presentation/document_tool/split_pdf/pdf_file_picker_screen.dart';
import '../../presentation/document_tool/split_pdf/split_pdf_screen.dart';
import '../../presentation/document_tool/unlock_pdf/unlock_pdf_screen.dart';
import '../../presentation/file_reader/ios_file_reader_screen.dart';
import '../../presentation/language/language_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/permission/permission_screen.dart';
import '../../presentation/signature/signature_pad_screen.dart';
import '../../presentation/signature/signature_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/uninstall/uninstall_screen.dart';
import '../../presentation/view_file/view_file_screen.dart';
import '../../presentation/view_file/view_image_screen.dart';
import '../../presentation/view_file/view_pdf_screen.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/enum/success_type.dart';
import '../../shared/screen/search_screen.dart';
import '../../shared/screen/shell_screen.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRouteGuard> get guards => [
        AutoRouteGuard.simple(
          (resolver, router) {
            if (resolver.route.name == SignaturePadRoute.name) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
              ]);
            }
            resolver.next();
          },
        )
      ];

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: SplashRoute.page, initial: true, path: '/'),
        AutoRoute(page: LanguageRoute.page),
        AutoRoute(page: OnBoardingRoute.page),
        // AutoRoute(page: PermissionRoute.page),
        CustomRoute(
          page: ShellRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        AutoRoute(page: MergePdfRoute.page),
        AutoRoute(page: DocumentSelectRoute.page),
        AutoRoute(page: SplitPdfRoute.page),
        AutoRoute(page: PdfToImageRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: LockPdfRoute.page),
        AutoRoute(page: UnlockPdfRoute.page),
        AutoRoute(page: FileSuccessRoute.page),
        AutoRoute(page: ViewPdfRoute.page),
        AutoRoute(page: ViewFileRoute.page),
        AutoRoute(page: IOSFileReaderRoute.page),
        AutoRoute(page: UninstallRoute.page),
        AutoRoute(page: BrushPdfRoute.page),
        AutoRoute(page: ViewImageRoute.page),
        AutoRoute(page: PdfFilePickerRoute.page),
        AutoRoute(page: ImageToPdfRoute.page),
        AutoRoute(page: PdfToImagePreviewRoute.page),
        AutoRoute(page: AIGuideRoute.page),
        AutoRoute(page: SelectPageRoute.page),
        AutoRoute(page: AIDetailRoute.page),
        AutoRoute(page: AIResultRoute.page),
        AutoRoute(page: FeedbackRoute.page),
        AutoRoute(page: SignaturePadRoute.page),
        AutoRoute(page: SignatureRoute.page),
        AutoRoute(page: EditPdfRoute.page),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}
