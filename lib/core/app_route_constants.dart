enum AppPage {
  login,
  home,
}

extension AppPageExtension on AppPage {
  String get path {
    switch (this) {
      case AppPage.home:
        return "/";
      case AppPage.login:
        return "/login";
      default:
        return "/";
    }
  }

  String get name {
    switch (this) {
      case AppPage.home:
        return "HOME";
      case AppPage.login:
        return "LOGIN";
      default:
        return "HOME";
    }
  }

  String get title {
    switch (this) {
      case AppPage.home:
        return "My Home";
      case AppPage.login:
        return "My Login";
      default:
        return "My Home";
    }
  }
}
