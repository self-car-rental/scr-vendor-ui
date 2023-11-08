enum AppPage {
  hubs,
  cars,
  profile,
  signup,
  signin,
  verifyOtp,
  home,
  user,
  create,
  edit
}

extension AppPageExtension on AppPage {
  String get path {
    switch (this) {
      case AppPage.home:
        return '/home';
      case AppPage.create:
        return 'create';
      case AppPage.edit:
        return 'edit/:id';
      case AppPage.hubs:
        return '/hubs';
      case AppPage.cars:
        return '/cars';
      case AppPage.profile:
        return '/profile';
      case AppPage.signup:
        return '/signup';
      case AppPage.signin:
        return '/signin';
      case AppPage.verifyOtp:
        return '/verifyOtp';
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
      case AppPage.create:
        return 'CREATE';
      case AppPage.edit:
        return 'EDIT';
      case AppPage.hubs:
        return 'HUBS';
      case AppPage.cars:
        return 'CARS';
      case AppPage.profile:
        return 'PROFILE';
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
        return 'Home';
      case AppPage.create:
        return 'Create';
      case AppPage.edit:
        return 'Edit';
      case AppPage.hubs:
        return 'Hubs';
      case AppPage.cars:
        return 'Cars';
      case AppPage.profile:
        return 'Profile';
      case AppPage.signup:
        return 'Signup';
      case AppPage.signin:
        return 'Signin';
      case AppPage.verifyOtp:
        return 'Verify Otp';
      case AppPage.user:
        return 'USER';
      default:
        return 'Home';
    }
  }
}
