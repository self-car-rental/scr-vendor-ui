// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:scr_vendor/core/utils/extension.dart';

/// Represents the Edit Hub screen of the application.
class EditHubScreen extends StatelessWidget {
  final String hubId;
  const EditHubScreen({super.key, required this.hubId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.editHubPageTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your onPressed logic here, if needed
          },
          child: Text('${context.tr.editHubHubIdLabel}: $hubId'),
        ),
      ),
    );
  }
}
