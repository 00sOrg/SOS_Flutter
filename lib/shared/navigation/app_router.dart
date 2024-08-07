import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:sos/features/auth/views/login_page.dart';
import 'package:sos/features/auth/views/splash_page.dart';
import 'package:sos/features/board/views/board_page.dart';
import 'package:sos/features/home/views/home_page.dart';
import 'package:sos/features/notification/views/notification_page.dart';
import 'package:sos/features/write/views/write_page.dart';
import 'package:sos/features/profile/views/profile_page.dart';
import 'package:sos/features/rescue/views/rescue_page.dart';
import 'package:sos/shared/navigation/app_routes.dart';
import 'package:sos/shared/widgets/custom_nav_bar.dart';

class AppRouter {
  final WidgetRef ref;

  AppRouter(this.ref);

  GoRouter router(String locationAddress) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) => '/splash',
        ),
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
          redirect: (context, state) {
            final authViewModel = ref.read(authViewModelProvider);
            if (authViewModel.checkIfLoggedIn()) {
              return '/home';
            } else {
              return '/login';
            }
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: CustomNavBar(
                selectedIdx: calculateSelectedIdx(state.uri.path),
              ),
            );
          },
          routes: _routes,
        ),
      ],
    );
  }

  static List<GoRoute> get _routes => [
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/rescue',
          builder: (context, state) => RescuePage(),
        ),
        GoRoute(
          path: '/write',
          builder: (context, state) => WritePage(),
        ),
        GoRoute(
          path: '/board',
          builder: (context, state) => BoardPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfilePage(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => NotificationPage(),
        )
        // GoRoute(
        //   path: '/post/:id',
        //   builder: (context, state) {
        //     final postId = state.pathParameters['id'];
        //     return PostPage(id: postId!);
        //   },
        // ),
      ];

  static int calculateSelectedIdx(String location) {
    return AppRoutesExtension.fromPath(location).index;
  }
}
