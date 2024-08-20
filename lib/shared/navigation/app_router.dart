import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:sos/features/auth/views/login_page.dart';
import 'package:sos/features/auth/views/splash_page.dart';
import 'package:sos/features/board/views/board_page.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/home_page.dart';
import 'package:sos/features/notification/views/notification_page.dart';
import 'package:sos/features/write/views/write_page.dart';
import 'package:sos/features/profile/views/profile_page.dart';
import 'package:sos/features/rescue/views/rescue_page.dart';
import 'package:sos/shared/navigation/app_routes.dart';
import 'package:sos/shared/widgets/custom_nav_bar.dart';
import 'package:sos/features/post/views/post_page.dart';

class AppRouter {
  final WidgetRef ref;

  AppRouter(this.ref);

  GoRouter router(String locationAddress) {
    return GoRouter(
      initialLocation: '/home',
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
            // 홈 페이지가 아닌 다른 페이지로 이동 시 바텀시트 닫기
            if (state.uri.path != '/home') {
              ref
                  .read(bottomSheetViewModelProvider.notifier)
                  .closeBottomSheet();
            }

            return Scaffold(
              body: child,
              bottomNavigationBar: Builder(
                builder: (context) {
                  return CustomNavBar(
                    selectedIdx: calculateSelectedIdx(state.uri.path),
                    onHomePressed: () {
                      ref
                          .read(bottomSheetViewModelProvider.notifier)
                          .toggleBottomSheet(context); // Context 사용
                    },
                    onOtherPressed: () {
                      ref
                          .read(bottomSheetViewModelProvider.notifier)
                          .closeBottomSheet();
                    },
                  );
                },
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
        ),
        GoRoute(
          path: '/post/:id',
          builder: (context, state) {
            final postId = int.parse(
                state.pathParameters['id']!); // Convert the string to an int
            return PostPage(postId: postId);
          },
        ),
      ];

  static int calculateSelectedIdx(String location) {
    return AppRoutesExtension.fromPath(location).index;
  }
}
