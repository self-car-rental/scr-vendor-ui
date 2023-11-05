enum AppPage { signup, signin, verifyOtp, login, home, user }

extension AppPageExtension on AppPage {
  String get path {
    switch (this) {
      case AppPage.home:
        return '/';
      case AppPage.signup:
        return '/signup';
      case AppPage.signin:
        return '/signin';
      case AppPage.verifyOtp:
        return '/verifyOtp';
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
      case AppPage.signin:
        return 'SIGNIN';
      case AppPage.verifyOtp:
        return 'VERIFY-OTP';
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
      case AppPage.signin:
        return 'My Signin';
      case AppPage.verifyOtp:
        return 'My Verify Otp';
      case AppPage.user:
        return 'My USER';
      default:
        return 'My Home';
    }
  }
}
