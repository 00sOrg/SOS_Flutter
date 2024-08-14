enum AppRoutes {
  home,
  rescue,
  write,
  board,
  profile,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.home:
        return '/home';
      case AppRoutes.rescue:
        return '/rescue';
      case AppRoutes.write:
        return '/write';
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
      case '/home':
        return AppRoutes.home;
      case '/rescue':
        return AppRoutes.rescue;
      case '/write':
        return AppRoutes.write;
      case '/board':
        return AppRoutes.board;
      case '/profile':
        return AppRoutes.profile;
      default:
        return AppRoutes.home;
    }
  }
}