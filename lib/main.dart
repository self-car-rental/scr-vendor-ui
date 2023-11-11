// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Project imports:
import 'package:scr_vendor/amplify/amplify_initializer.dart';
import 'package:scr_vendor/common/widget/connectivity_listener.dart';
import 'package:scr_vendor/constants/language_constants.dart';
import 'package:scr_vendor/core/connectivity/connectivity_bloc.dart';
import 'package:scr_vendor/core/localization/localization_bloc.dart';
import 'package:scr_vendor/core/service_locator.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';
import 'package:scr_vendor/global_keys.dart';
import 'package:scr_vendor/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures initialization for Flutter engine bindings
  await initializeApp(); // Initializes Amplify and the service locator
  runApp(const MainApp());
}

/// Initializes services and plugins required for the app.
Future<void> initializeApp() async {
  await initializeAmplify(); // Initialize AWS Amplify
  await initServiceLocator(); // Initialize the service locator (dependency injection)
}

/// The main application widget.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => serviceLocator<UserBloc>()),
        BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider<ConnectivityBloc>(
            create: (context) => serviceLocator<ConnectivityBloc>()),
        BlocProvider<LocalizationBloc>(
            create: (context) => serviceLocator<LocalizationBloc>()),
      ],
      child: BlocBuilder<LocalizationBloc, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            routerConfig:
                AppRouter.router, // Configures the routing for the app
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LanguageConstants.languages.keys
                .map((langCode) => Locale(langCode, ''))
                .toList(),
            locale: locale,
            builder: (context, child) => Scaffold(
              key: rootScaffoldKey,
              body: ConnectivityListener(
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          );
        },
      ),
    );
  }
}
