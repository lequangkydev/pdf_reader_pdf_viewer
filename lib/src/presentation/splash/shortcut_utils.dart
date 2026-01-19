import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../shared/utils/utils.dart';

class ShortcutUtils {
  ShortcutUtils._();

  static final ShortcutUtils instance = ShortcutUtils._();
  String? shortcutType;
  bool isSplash = true;
  bool initialized = false;
  final QuickActions quickActions = const QuickActions();

  Future<bool> initialize() async {
    if (initialized) {
      return false;
    }
    final completer = Completer<bool>();
    quickActions.initialize((String shortcutType) {
      this.shortcutType = shortcutType;
      if (!completer.isCompleted) {
        completer.complete(true);
      }
      if (!isSplash) {
        handleShortcut();
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'view_files',
        localizedTitle: appContext.l10n.viewFiles,
        icon: 'view_files',
      ),
      ShortcutItem(
        type: 'uninstall',
        localizedTitle: appContext.l10n.uninstall,
        icon: 'remove',
      ),
    ]);
    setShortcut();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });
    initialized = true;
    return completer.future;
  }

  void setShortcut() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'view_files',
        localizedTitle: appContext.l10n.viewFiles,
        icon: 'view_files',
      ),
      ShortcutItem(
        type: 'uninstall',
        localizedTitle: appContext.l10n.uninstall,
        icon: 'remove',
      ),
    ]);
  }

  void handleShortcut() {
    final firstUse = SharedPreferencesManager.instance.isFirstUseApp();
    if (firstUse) {
      return;
    }
    final PageRouteInfo? route = switch (shortcutType) {
      'view_files' => const ShellRoute(),
      'uninstall' => const UninstallRoute(),
      _ => null
    };
    if (route == null) {
      return;
    }
    if (shortcutType == 'view_files') {
      getIt<BottomTabCubit>().changeTab(BottomTab.document);
    }
    getIt<AppRouter>().replace(route);
  }
}
