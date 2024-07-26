enum AppRoutes {
  home,
  rescue,
  post,
  board,
  profile,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.home:
        return '/';
      case AppRoutes.rescue:
        return '/rescue';
      case AppRoutes.post:
        return '/post';
      case AppRoutes.board:
        return '/board';
      case AppRoutes.profile:
        return '/profile';
      default:
        return '/';
    }
  }

  static AppRoutes fromPath(String path) {
    switch (path) {
      case '/':
        return AppRoutes.home;
      case '/rescue':
        return AppRoutes.rescue;
      case '/post':
        return AppRoutes.post;
      case '/board':
        return AppRoutes.board;
      case '/profile':
        return AppRoutes.profile;
      default:
        return AppRoutes.home;
    }
  }
}