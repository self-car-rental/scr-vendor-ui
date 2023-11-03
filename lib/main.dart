// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/amplify_initializer.dart';
import 'package:scr_vendor/core/app_router.dart';
import 'package:scr_vendor/di.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures plugin services are initialized
  await initializeApp();
  runApp(const MainApp());
}

Future<void> initializeApp() async {
  await initializeAmplify(); // Initialize Amplify
  await initLocator(); // Your existing DI initialization
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => locator<UserBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}
