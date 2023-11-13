// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:scr_vendor/common/widgets/connectivity_listener.dart';
import 'package:scr_vendor/constants/language_constants.dart';
import 'package:scr_vendor/core/amplify/amplify_initializer.dart';
import 'package:scr_vendor/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:scr_vendor/core/bloc/localization/localization_bloc.dart';
import 'package:scr_vendor/core/routes/app_router.dart';
import 'package:scr_vendor/core/services/language_preference_service.dart';
import 'package:scr_vendor/core/utils/app_keys.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';
import 'package:scr_vendor/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(const MainApp());
}

/// Initializes services and plugins required for the app.
Future<void> initializeApp() async {
  await initServiceLocator(); // Dependency injection setup
  await Hive.initFlutter(); // Local storage initialization
  await initializeAmplify(); // AWS Amplify setup
  await initializeLanguageSettings(); // Language settings initialization
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
      ],
      child: BlocBuilder<LocalizationBloc, Locale>(
        builder: (context, locale) {
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
            locale: locale,
            builder: (context, child) => Scaffold(
              key: rootScaffoldKey,
              body:
                  ConnectivityListener(child: child ?? const SizedBox.shrink()),
            ),
          );
        },
      ),
    );
  }
}
