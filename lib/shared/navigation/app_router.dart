import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos/features/auth/viewmodels/login_viewmodel.dart';
import 'package:sos/features/auth/views/login_page.dart';
import 'package:sos/features/auth/views/signup_page.dart';
import 'package:sos/features/auth/views/splash_page.dart';
import 'package:sos/features/board/views/board_page.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/home_page.dart';
import 'package:sos/features/setting/views/setting_page.dart';
import 'package:sos/features/setting/views/subpages/setting_deleted_account_page.dart';
import 'package:sos/features/setting/views/subpages/setting_favorite_page.dart';
import 'package:sos/features/setting/views/subpages/setting_favorite_search_page.dart';
import 'package:sos/features/setting/views/subpages/setting_favorite_search_result_page.dart';
import 'package:sos/features/setting/views/subpages/setting_health_page.dart';
import 'package:sos/features/setting/views/subpages/setting_my_post_page.dart';
import 'package:sos/features/setting/views/subpages/setting_profile_page.dart';
import 'package:sos/features/write/viewmodels/camera_viewmodel.dart';
import 'package:sos/features/write/views/custom_camera_screen.dart';
import 'package:sos/features/write/views/image_check_page.dart';
import 'package:sos/features/write/views/write_page.dart';
import 'package:sos/features/rescue/views/rescue_page.dart';
import 'package:sos/shared/navigation/app_routes.dart';
import 'package:sos/shared/views/geolocator_test_page.dart';
import 'package:sos/shared/views/post_search_result_page.dart';
import 'package:sos/shared/widgets/custom_nav_bar.dart';
import 'package:sos/features/post/views/post_page.dart';

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
            final loginState = ref.read(loginViewModelProvider);
            if (loginState.isLoggedIn) {
              return '/home';
            } else {
              return '/login';
            }
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          path: '/setting-deleted-account',
          builder: (context, state) => const SettingDeletedAccountPage(),
        ),
        GoRoute(
          path: '/post/:id',
          builder: (context, state) {
            final postId = int.parse(state.pathParameters['id']!);
            return PostPage(postId: postId);
          },
        ),
        GoRoute(
          path: '/custom-camera',
          builder: (context, state) => const CustomCameraScreen(),
        ),
        GoRoute(
          path: '/image-check',
          builder: (context, state) {
            final ImageCheckArguments? args =
                state.extra as ImageCheckArguments?;
            if (args != null) {
              return ImageCheckPage(
                imagePath: args.imagePath,
                viewOnly: args.viewOnly,
              );
            } else {
              return const NoImageCheckPage();
            }
          },
        ),
        GoRoute(
            path: '/write',
            builder: (context, state) {
              final XFile? camImg = state.extra as XFile?;
              return WritePage(camImg: camImg);
            }),
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: Builder(
                builder: (context) {
                  return CustomNavBar(
                    selectedIdx: calculateSelectedIdx(state.uri.path),
                    onHomePressed: () {
                      ref
                          .read(bottomSheetViewModelProvider.notifier)
                          .toggleBottomSheet();
                    },
                    onOtherPressed: () {
                      ref
                          .read(bottomSheetViewModelProvider.notifier)
                          .setBottomSheetHeight(0.15);
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
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/rescue',
          builder: (context, state) => const RescuePage(),
        ),
        // GoRoute(
        //     path: '/write',
        //     builder: (context, state) {
        //       final XFile? camImg = state.extra as XFile?;
        //       return WritePage(camImg: camImg);
        //     }),
        GoRoute(
          path: '/board',
          builder: (context, state) => const BoardPage(),
        ),
        GoRoute(
          path: '/setting',
          builder: (context, state) => const SettingPage(),
        ),
        GoRoute(
          path: '/setting-my-post',
          builder: (context, state) => const SettingMyPostPage(),
        ),
        GoRoute(
          path: '/setting-profile',
          builder: (context, state) => const SettingProfilePage(),
        ),
        GoRoute(
          path: '/setting-health',
          builder: (context, state) => const SettingHealthPage(),
        ),
        GoRoute(
          path: '/setting-favorite',
          builder: (context, state) => const SettingFavoritePage(),
        ),
        GoRoute(
          path: '/setting-favorite-search',
          builder: (context, state) => const SettingFavoriteSearchPage(),
        ),
        GoRoute(
          path: '/setting-favorite-search-result',
          builder: (context, state) => const SettingFavoriteSearchResultPage(),
        ),
        GoRoute(
          path: '/location-test',
          builder: (context, state) => const GeolocatorTestPage(),
        ),
        GoRoute(
          path: '/post-search-result',
          builder: (context, state) {
            final keyword = state.extra as String;
            return PostSearchResultPage(keyword: keyword);
          },
        ),
      ];

  static int calculateSelectedIdx(String location) {
    return AppRoutesExtension.fromPath(location).index;
  }
}
