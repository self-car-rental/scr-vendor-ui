enum AppPage { signup, login, home, user }

extension AppPageExtension on AppPage {
  String get path {
    switch (this) {
      case AppPage.home:
        return '/';
      case AppPage.signup:
        return '/signup';
      case AppPage.login:
        return '/login';
      case AppPage.user:
        return '/user';
      default:
        return '/';
    }
  }

  String get name {
    switch (this) {
      case AppPage.home:
        return 'HOME';
      case AppPage.login:
        return 'LOGIN';
      case AppPage.signup:
        return 'SIGNUP';
      case AppPage.user:
        return 'USER';
      default:
        return 'HOME';
    }
  }

  String get title {
    switch (this) {
      case AppPage.home:
        return 'My Home';
      case AppPage.login:
        return 'My Login';
      case AppPage.signup:
        return 'My Signup';
      case AppPage.user:
        return 'My USER';
      default:
        return 'My Home';
    }
  }
}
