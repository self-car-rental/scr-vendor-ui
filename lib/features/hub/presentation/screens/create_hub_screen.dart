// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:scr_vendor/constants/app_route_constants.dart';

/// Represents the Create Hub screen of the application.
class CreateHubScreen extends StatelessWidget {
  const CreateHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.create.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your onPressed logic here, if needed
          },
          child: const Text('Create'),
        ),
      ),
    );
  }
}
