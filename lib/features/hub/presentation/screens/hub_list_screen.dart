// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:scr_vendor_ui/core/utils/extension.dart';
import 'package:scr_vendor_ui/core/utils/navigation_utils.dart';

/// Represents the screen listing hubs with options to create and edit.
class HubListScreen extends StatelessWidget {
  const HubListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.hubsPageTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _navigateToCreateHub(context),
              child: Text(context.tr.hubsCreateHubButtonTitle),
            ),
            const SizedBox(height: 16), // Space between the buttons
            ElevatedButton(
              onPressed: () => _navigateToEditHub(context),
              child: Text(context.tr.hubsEditHubButtonTitle),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCreateHub(BuildContext context) {
    NavigationUtils.navigateToCreateHub(context);
  }

  void _navigateToEditHub(BuildContext context) {
    // Assuming you have a way to select or determine which hub to edit
    // For example, a selectedHubId variable
    // String selectedHubId = ...;

    // For now, using a placeholder
    NavigationUtils.navigateToEditHub(context, '4');
  }
}
