// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:scr_vendor/common/widgets/connectivity_listener.dart';
import 'package:scr_vendor/common/widgets/error_display.dart';
import 'package:scr_vendor/config/app_config.dart';
import 'package:scr_vendor/constants/app_language_constants.dart';
import 'package:scr_vendor/core/amplify/amplify_initializer.dart';
import 'package:scr_vendor/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:scr_vendor/core/bloc/error/error_bloc.dart';
import 'package:scr_vendor/core/bloc/localization/localization_bloc.dart';
import 'package:scr_vendor/core/bloc/theme/theme_bloc.dart';
import 'package:scr_vendor/core/routes/app_router.dart';
import 'package:scr_vendor/core/services/language_preference_service.dart';
import 'package:scr_vendor/core/services/theme_preference_service.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';
import 'package:scr_vendor/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // Avoid "#" in web app URLs
  await initializeApp();
}

/// Initializes services and plugins required for the app.
Future<void> initializeApp() async {
  await initServiceLocator(); // Dependency injection setup
  await Hive.initFlutter(); // Local storage initialization
  await initializeAmplify(); // AWS Amplify setup
  await initializeLanguageSettings(); // Language settings initialization
  await initializeThemeSettings();
  await initializeSentry();
}

// Initialize language settings separately
Future<void> initializeLanguageSettings() async {
  final languagePreferenceService = serviceLocator<LanguagePreferenceService>();
  final storedLanguageCode =
      await languagePreferenceService.getSelectedLanguage();

  // Register LocalizationBloc with the fetched locale
  // We are registering the LocalizationBloc here instead of in the service locator file
  // because we need to await the asynchronous operation of fetching the stored language preference.
  // The service locator setup in GetIt expects synchronous factory methods,
  // so we handle this asynchronous initialization outside of it.
  serviceLocator.registerFactory<LocalizationBloc>(
    () =>
        LocalizationBloc(languagePreferenceService, Locale(storedLanguageCode)),
  );
}

// Initialize theme
Future<void> initializeThemeSettings() async {
  final themePreferenceService = serviceLocator<ThemePreferenceService>();
  final storedTheme = await themePreferenceService.getSelectedTheme();
  serviceLocator.registerFactory<ThemeBloc>(
    () => ThemeBloc(themePreferenceService, storedTheme),
  );
}

// Initialize theme
Future<void> initializeSentry() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = kDebugMode ? '' : AppConfig.sentryDsn;
      options.tracesSampleRate = 1.0;
    },
    // Init your App.
    appRunner: () => runApp(
      DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: const MainApp(),
      ),
    ),
  );
}

/// The main application widget.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<LocalizationBloc>()),
        BlocProvider(create: (_) => serviceLocator<ConnectivityBloc>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserBloc>()),
        BlocProvider(create: (_) => serviceLocator<ThemeBloc>()),
        BlocProvider(create: (_) => serviceLocator<ErrorBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LanguageConstants.languages.keys
                .map((langCode) => Locale(langCode))
                .toList(),
            locale: context.watch<LocalizationBloc>().state,
            theme: themeState.theme, // Apply the theme from ThemeBloc's state
            builder: (context, child) => Scaffold(
              body: ConnectivityStatusListener(
                child: ErrorDisplay(
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
