import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nearhere/features/board/views/board_page.dart';
import 'package:nearhere/features/board/views/post_page.dart';
import 'package:nearhere/features/home/views/home_page.dart';
import 'package:nearhere/features/write/views/write_page.dart';
import 'package:nearhere/shared/widgets/custom_nav_bar.dart';

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
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => HomePage(),
            ),
            GoRoute(
              path: '/board',
              builder: (context, state) => BoardPage(),
            ),
            GoRoute(
              path: '/post/:id',
              builder: (context, state) {
                final postId = state.pathParameters['id'];
                return PostPage(id: postId!);
              },
            ),
            GoRoute(
              path: '/write',
              builder: (context, state) => const WritePage(),
            ),
          ],
        ),
      ],
    );
  }

  static int calculateSelectedIdx(String location) {
    switch (location) {
      case '/':
        return 0;
      case '/write':
        return 1;
      case '/board':
      case '/post':
        return 2;
      default:
        return 0;
    }
  }
}
