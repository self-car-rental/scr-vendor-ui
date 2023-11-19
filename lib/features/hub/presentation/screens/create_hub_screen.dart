// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:scr_vendor/core/utils/extension.dart';

/// Represents the Create Hub screen of the application.
class CreateHubScreen extends StatelessWidget {
  const CreateHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.createHubPageTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your onPressed logic here, if needed
          },
          child: Text(
            context.tr.createHubButtonTitle,
          ),
        ),
      ),
    );
  }
}
