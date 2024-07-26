import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/board/views/board_page.dart';
import 'package:sos/features/home/views/home_page.dart';
import 'package:sos/features/post/views/post_page.dart';
import 'package:sos/features/profile/views/profile_page.dart';
import 'package:sos/features/rescue/views/rescue_page.dart';
import 'package:sos/shared/navigation/app_routes.dart';
import 'package:sos/shared/widgets/custom_nav_bar.dart';

class AppRouter {
  GoRouter router(String locationAddress) {
    return GoRouter(
      routes: [
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
          path: '/',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/rescue',
          builder: (context, state) => RescuePage(),
        ),
        GoRoute(
          path: '/post',
          builder: (context, state) => PostPage(),
        ),
        GoRoute(
          path: '/board',
          builder: (context, state) => BoardPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfilePage(),
        ),
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
