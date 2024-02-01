import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_animation/constants/constants.dart';
import 'package:login_animation/features/home/home_screen.dart';
import 'package:login_animation/features/login/login_screen.dart';

part 'route_transition.dart';

final routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: kDebugMode,
  initialLocation: LoginScreen.path,
  routes: [
    GoRoute(
        path: LoginScreen.path,
        pageBuilder: (context, state) => pageTransition(
            context, state, const LoginScreen(),
            restorationId: LoginScreen.path,
            type: SlideTransitionType.rightToLeft)),
    GoRoute(
        path: HomeScreen.path,
        pageBuilder: (context, state) => pageTransition(
            context, state, const HomeScreen(),
            restorationId: HomeScreen.path,
            type: SlideTransitionType.rightToLeft)),
  ],
);
