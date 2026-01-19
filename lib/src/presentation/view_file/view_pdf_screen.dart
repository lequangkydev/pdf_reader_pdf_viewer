import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vtn_flutter_pdf/pdf.dart';
import 'package:vtn_flutter_pdfviewer/pdfviewer.dart';

import '../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../module/file_system/file_path_manager.dart';
import '../../../module/file_system/file_system_manage.dart';
import '../../../module/log_event_app/shell_event.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../data/model/file_model.dart';
import '../../global/global.dart';
import '../../services/default_app_checker.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/enum/pdf_action.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/mixin/system_ui_mixin.dart';
import '../../shared/utils/debouncer.dart';
import '../../shared/utils/share_util.dart';
import '../../shared/widgets/bottom_sheet/guide_set_default_app.dart';
import '../../shared/widgets/bottom_sheet/menu_pdf_bottom_sheet.dart';
import '../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../shared/widgets/color_size/cubit/select_color_cubit.dart';
import '../../shared/widgets/dialog/dialog_rename.dart';
import '../../shared/widgets/dialog/error_dialog.dart';
import '../../shared/widgets/dialog/loading_dialog.dart';
import '../ai/widgets/ai_assistant.dart';
import '../all_documents/cubit/pdf_cubit.dart';
import '../document_tool/utils/pdf_util.dart';
import '../permission/cubit/storage_status_cubit.dart';
import 'cubit/current_page_cubit.dart';
import 'cubit/pdf_bottom_cubit.dart';
import 'cubit/pdf_search_cubit.dart';
import 'cubit/toggle_ui_cubit.dart';
import 'widgets/go_to_page_popup.dart';
import 'widgets/pdf_bottom_bar.dart';
import 'widgets/search_tool_bar.dart';

@RoutePage()
class ViewPdfScreen extends StatefulLoggableWidget implements AutoRouteWrapper {
  const ViewPdfScreen({
    super.key,
    required this.pdfFile,
    this.fromReload = false,
  });

  final FileModel pdfFile;
  final bool fromReload;

  @override
  State<ViewPdfScreen> createState() => _ViewFilePdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SelectColorCubit()),
        BlocProvider(create: (context) => ToggleUiCubit()),
        BlocProvider(create: (context) => PdfBottomBarCubit()),
        BlocProvider(create: (context) => CurrentPageCubit()),
      ],
      child: this,
    );
  }
}

class _ViewFilePdfScreenState extends State<ViewPdfScreen> with SystemUiMixin {
  GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController _pdfViewerController = PdfViewerController();
  final TextEditingController _searchController = TextEditingController();
  bool _ignorePageChange = false;
  ValueNotifier<String?> _password = ValueNotifier(null);
  late FileModel pdfFile;
  final FocusNode _focusNode = FocusNode();

  late final bannerViewFile = Global.instance.isFullAds
      ? CachedBannerAd(
          cachedAdUtil: BannerViewFileUtil.instance,
        )
      : const SizedBox();

  @override
  void initState() {
    super.initState();
    DefaultAppChecker.viewFile(true);
    pdfFile = widget.pdfFile;
    pdfFile.file.setLastModified(DateTime.now());
    if (context.read<StoragePermissionCubit>().state) {
      DefaultAppChecker.setRecentFilePath(pdfFile.file.path);
    }
    Global.instance.viewFile = true;
    SharedPreferencesManager.instance.increaseViewFileCount();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.read<ToggleUiCubit>().show();
      } else {
        context.read<ToggleUiCubit>().toggle();
      }
      debugPrint(
          'TextField is ${_focusNode.hasFocus ? 'focused' : 'unfocused'}');
    });
    _pdfViewerController.addListener(
      () {
        if (_pdfViewerController.pageCount != 0 &&
            context.read<CurrentPageCubit>().state == 0) {
          context.read<CurrentPageCubit>().update(1);
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant ViewPdfScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (pdfFile != widget.pdfFile) {
      setState(() {
        pdfFile = widget.pdfFile;
      });
    }
  }

  void requestPermissionDefault() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) {
        return;
      }
      showGuideAppDefaultBottomSheet(
        file: pdfFile,
        type: TabBarType.pdf,
        context: context,
      );
    });
  }

  Future<void> _handleDocumentLoadFailed(
      BuildContext context, PdfDocumentLoadFailedDetails details) async {
    if (details.description.contains('password')) {
      final password = await showPasswordBottomSheet(
        pdfFile: pdfFile.file,
        typePassword: TypePassword.enter,
        isOpen: true,
      );

      if (password != null && context.mounted) {
        await Future.delayed(const Duration(milliseconds: 100));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) {
            return;
          }
          _password.value = password;
        });
        return;
      }

      if (context.mounted) {
        context.maybePop();
        return;
      }
    }

    await showErrorDialog(details.error, details.description);
    if (context.mounted) {
      context.maybePop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    DefaultAppChecker.viewFile(false);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PdfSearchCubit(
        PdfSearchState(
          searchResult: PdfTextSearchResult(),
          pdfController: _pdfViewerController,
        ),
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }

          if (Global.instance.isFullAds) {
            await InterFileBackTabUtil.instance.show(
              enable: InterFileBackTabUtil.instance.config.interBack,
              nativeFullConfig: adUnitsConfig.nativeFullInterBack,
            );
          }
          if (Global.instance.sharedFiles != null ||
              widget.fromReload ||
              getIt<AppRouter>().stack.length == 1) {
            AnalyticLogger.instance
                .logEventWithScreen(event: ShellEvent.Enter_FROM_ViewFILE);
            moveToHome();
            return;
          }
          AnalyticLogger.instance
              .logEventWithScreen(event: ShellEvent.Enter_FROM_ViewFILE);

          Navigator.of(context).popUntil(
            (route) => route.settings.name == ShellRoute.name,
          );
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: buildScaffold(context),
        ),
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 50),
        child: buildTopBar(),
      ),
      body: Container(
        color: Colors.white,
        child: ValueListenableBuilder(
          valueListenable: _password,
          builder: (context, value, child) => SfPdfViewer.file(
            pdfFile.file,
            key: _pdfViewerKey,
            controller: _pdfViewerController,
            password: value,
            canShowPasswordDialog: false,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            enableTextSelection: false,
            onTap: (details) async {
              _ignorePageChange = true;
              context.read<ToggleUiCubit>().toggle();
              await Future.delayed(const Duration(milliseconds: 300));
              _ignorePageChange = false;
            },
            canShowTextSelectionMenu: false,
            canShowPageLoadingIndicator: false,
            onDocumentLoadFailed: (details) =>
                _handleDocumentLoadFailed(context, details),
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              requestPermissionDefault();
            },
            onPageChanged: (PdfPageChangedDetails details) {
              if (_ignorePageChange) {
                return;
              }
              final currentPageCubit = context.read<CurrentPageCubit>();
              final isSearch = _searchController.text.isNotEmpty;
              currentPageCubit.update(details.newPageNumber);
              if (isSearch) {
                return;
              }
              if (currentPageCubit.state == 1) {
                context.read<ToggleUiCubit>().show();
              } else {
                context.read<ToggleUiCubit>().hide();
              }
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<CurrentPageCubit, int>(
        builder: (context, state) {
          if (_pdfViewerController.pageCount == 0) {
            return const SizedBox.shrink();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey,
                ),
                child: Text(
                  '$state/${_pdfViewerController.pageCount}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              8.vSpace,
              BlocBuilder<ToggleUiCubit, ToggleUiState>(
                builder: (context, state) {
                  if (!state.isVisible) {
                    return const SizedBox.shrink();
                  }
                  return AIAssistant(fileModel: pdfFile);
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocListener<PdfBottomBarCubit, PdfBottomBarType?>(
              listener: (context, state) async {
                if (state == PdfBottomBarType.more) {
                  showMenuPdf();
                }
                if (state == PdfBottomBarType.print) {
                  printFile();
                }
                if (state == PdfBottomBarType.share) {
                  sharePdf();
                }
                if (state == PdfBottomBarType.edit) {
                  context.pushRoute(EditPdfRoute(
                    pdfFile: pdfFile,
                    password: _password.value,
                  ));
                }
                if (state == PdfBottomBarType.page) {
                  final page = await GoToPagePopup.show(
                    context: context,
                    pageCount: _pdfViewerController.pageCount,
                  );
                  if (page != null) {
                    _pdfViewerController.jumpToPage(page);
                  }
                }
              },
              child: const PdfBottomBar(),
            ),
            if (Global.instance.isFullAds) bannerViewFile,
          ],
        ),
      ),
    );
  }

  void moveToHome() {
    Global.instance.sharedFiles = null;
    context.replaceRoute(const ShellRoute());
  }

  Widget buildTopBar() {
    return BlocBuilder<ToggleUiCubit, ToggleUiState>(
      builder: (context, stateUI) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: !stateUI.isVisible
                  ? const SizedBox.shrink(key: ValueKey('empty'))
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: SearchToolbar(
                        key: const ValueKey('SearchTextPdf'),
                        searchController: _searchController,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showMenuPdf() async {
    if (mounted) {
      final action = await showMenuPdfViewFile(
        context: context,
        file: pdfFile,
        tabType: TabBarType.pdf,
        baseFileCubit: TabBarType.pdf.valueCubit,
        callBackDelete: context.maybePop,
        renameCallback: (newFile) {
          setState(() {
            pdfFile = newFile;
          });
          if (context.read<StoragePermissionCubit>().state) {
            DefaultAppChecker.setRecentFilePath(newFile.file.path);
          }
        },
      );
      if (action == PdfActionEnum.rename) {
        final result = await const DialogRename().show(
          defaultName: path.basenameWithoutExtension(pdfFile.file.path),
          file: pdfFile,
        );
        if (result != null &&
            result != false &&
            mounted &&
            result is FileModel) {
          if (Global.instance.sharedFiles != null) {
            final exactFile = getIt<PdfCubit>()
                .findFileByName(Global.instance.sharedFiles!.path);
            if (exactFile != null) {
              final newFile = await FileSystemManager.instance.renameFile(
                exactFile,
                path.basenameWithoutExtension(result.file.path),
              );
              if (newFile == null) {
                return;
              }
              getIt<PdfCubit>().updateFile(newFile);
              Global.instance.sharedFiles = SharedMediaFile(
                path: newFile.file.path,
                type: SharedMediaType.file,
              );
            } else {
              getIt<PdfCubit>().updateFile(result);
            }
          } else {
            getIt<PdfCubit>().updateFile(result);
          }
          if (context.read<StoragePermissionCubit>().state) {
            DefaultAppChecker.setRecentFilePath(result.file.path);
          }

          setState(() {
            pdfFile = result;
          });
        }
      }
    }
  }

  Future<void> savePdf() async {
    LoadingOverlay.show();
    final bytes = await _pdfViewerController.saveDocument();
    PdfSection? section;
    final PdfDocument document = PdfDocument(inputBytes: bytes);
    // tạo 1 document để set lại password
    final PdfDocument lockedDocument = PdfDocument();
    for (int i = 0; i < document.pages.count; i++) {
      final PdfPage page = document.pages[i];

      final PdfTemplate template = page.createTemplate();

      if (section == null || section.pageSettings.size != template.size) {
        section = lockedDocument.sections!.add();
        section.pageSettings.size = template.size;
        section.pageSettings.margins.all = 0;
      }
      section.pages.add().graphics.drawPdfTemplate(template, Offset.zero);
      for (int j = 0; j < page.annotations.count; j++) {
        final PdfAnnotation annotation = page.annotations[j];
        section.pages[i].annotations.add(annotation);
      }
    }

    lockedDocument.security.userPassword = _password.value ?? '';

    try {
      final List<int> lockedPdfBytes = lockedDocument.saveSync();
      final isCacheOfApp =
          await FilePathManager.instance.isFileInAppCache(pdfFile.file.path);
      final file = await pdfFile.file.writeAsBytes(lockedPdfBytes, flush: true);
      final newFile = File(file.path);
      final result = isCacheOfApp
          ? File(await FilePathManager.instance.saveFileToDownloads(
              newFile.path, 'download${DateTime.now().toIso8601String()}.pdf'))
          : file;

      if (mounted) {
        LoadingOverlay.hide();
        context.replaceRoute(
          FileSuccessRoute(
            fileModel: pdfFile.copyWith(file: result),
            title: context.l10n.editPdfSuccess,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        LoadingOverlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  Future<void> printFile() async {
    DeBouncer.run(() async {
      DefaultAppChecker.blockNotify();
      await PdfUtil.printToPdf(file: pdfFile.file, password: _password.value);
      DefaultAppChecker.unBlockNotify();
      return;
    });
  }

  Future<void> sharePdf() async {
    DefaultAppChecker.blockNotify();
    DeBouncer.run(() async {
      await ShareUtil.shareFiles([XFile(pdfFile.file.path)]);
      DefaultAppChecker.unBlockNotify();
    });
  }
}
