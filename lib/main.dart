// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:scr_vendor/core/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppRouter.router);
  }
}
