import 'package:simple_chat_demo/app/router/router_app_name.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/chat_screen.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/scan_screen.dart';
import 'package:flutter/material.dart';

class RouterAppConfig {
  factory RouterAppConfig() {
    return _instance;
  }

  RouterAppConfig._internal();

  static final RouterAppConfig _instance = RouterAppConfig._internal();

  GoRouter? goRouter;

  bool get canPop => goRouter?.canPop() ?? false;

  String? get currentPath {
    if (_instance.goRouter == null) {
      return null;
    }
    return _instance.goRouter!.routerDelegate.currentConfiguration.uri.toString();
  }

  void initializeRouter() {
    if (goRouter != null) {
      return;
    }

    goRouter = GoRouter(
      initialLocation: RouterAppName.chat,
      routes: [
        GoRoute(
          path: RouterAppName.scan,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: const ScanScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(path: RouterAppName.chat, builder: (context, state) => const ChatScreen()),
      ],
      errorBuilder: (context, state) => const SizedBox(),
    );
  }
}
