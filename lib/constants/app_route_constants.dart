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

  const AppRoute({required this.path, required this.name});
}

class AppRoutes {
  static const Map<AppPage, AppRoute> routes = {
    ///auth
    AppPage.signup: AppRoute(path: '/signup', name: 'signup'),
    AppPage.signin: AppRoute(path: '/signin', name: 'signin'),
    AppPage.verifyOtp: AppRoute(path: '/verify-otp', name: 'verifyOtp'),

    ///home
    AppPage.home: AppRoute(path: '/home', name: 'home'),

    ///hubs
    AppPage.hubs: AppRoute(path: '/hubs', name: 'hubs'),
    AppPage.hubsCreate: AppRoute(path: 'create', name: 'hubsCreate'),
    AppPage.hubsEdit: AppRoute(path: 'edit/:id', name: 'hubsEdit'),

    ///cars
    AppPage.cars: AppRoute(path: '/cars', name: 'cars'),

    ///users
    AppPage.users: AppRoute(path: '/users', name: 'users'),

    ///profile
    AppPage.profile: AppRoute(path: '/profile', name: 'profile'),

    // Add other routes as needed
  };

  static String path(AppPage page) => routes[page]?.path ?? '/home';
  static String name(AppPage page) => routes[page]?.name ?? 'home';
}
