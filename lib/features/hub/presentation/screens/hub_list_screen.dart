// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/constants/app_route_constants.dart';
import 'package:scr_vendor/core/utils/app_extension.dart';

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
    context.goNamed(AppRoutes.name(AppPage.hubsCreate));
  }

  void _navigateToEditHub(BuildContext context) {
    // Assuming you have a way to select or determine which hub to edit
    // For example, a selectedHubId variable
    // String selectedHubId = ...;
    // context.goNamed(AppPage.editHub.name, params: {'hubId': selectedHubId});

    // For now, using a placeholder
    context
        .goNamed(AppRoutes.name(AppPage.hubsEdit), pathParameters: {'id': '4'});
  }
}
