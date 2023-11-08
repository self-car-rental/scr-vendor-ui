import 'package:flutter/material.dart';
import 'package:scr_vendor/constants/app_route_constants.dart';

/// Represents the car screen of the application.
class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppRoutes.title(AppPage.cars),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your onPressed logic here, if needed
          },
          child: const Text('Cars'),
        ),
      ),
    );
  }
}
