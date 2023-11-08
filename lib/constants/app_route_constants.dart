enum AppPage {
  signup,
  signin,
  verifyOtp,
  home,
  hubs,
  hubsCreate,
  hubsEdit,
  cars,
  users,
  profile,
}

class AppRoute {
  final String path;
  final String name;
  final String title;

  const AppRoute({required this.path, required this.name, required this.title});
}

class AppRoutes {
  static const Map<AppPage, AppRoute> routes = {
    ///auth
    AppPage.signup: AppRoute(path: '/signup', name: 'signup', title: 'Signup'),
    AppPage.signin: AppRoute(path: '/signin', name: 'signin', title: 'Signin'),
    AppPage.verifyOtp:
        AppRoute(path: '/verify-otp', name: 'verifyOtp', title: 'Verify OTP'),

    ///home
    AppPage.home: AppRoute(path: '/home', name: 'home', title: 'Home'),

    ///hubs
    AppPage.hubs: AppRoute(path: '/hubs', name: 'hubs', title: 'Hubs'),
    AppPage.hubsCreate:
        AppRoute(path: 'create', name: 'hubsCreate', title: 'Create Hub'),
    AppPage.hubsEdit:
        AppRoute(path: 'edit/:id', name: 'hubsEdit', title: 'Edit Hub'),

    ///cars
    AppPage.cars: AppRoute(path: '/cars', name: 'cars', title: 'Cars'),

    ///users
    AppPage.users: AppRoute(path: '/users', name: 'users', title: 'Users'),

    ///profile
    AppPage.profile:
        AppRoute(path: '/profile', name: 'profile', title: 'Profile'),

    // Add other routes as needed
  };

  static String path(AppPage page) => routes[page]?.path ?? '/home';
  static String name(AppPage page) => routes[page]?.name ?? 'home';
  static String title(AppPage page) => routes[page]?.title ?? 'Home';
}
