import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scr_vendor/constants/app_route_constants.dart';

/// Represents the screen listing hubs with options to create and edit.
class HubListScreen extends StatelessWidget {
  const HubListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.hubs.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _navigateToCreateHub(context),
              child: const Text('Create Hub'),
            ),
            const SizedBox(height: 16), // Space between the buttons
            ElevatedButton(
              onPressed: () => _navigateToEditHub(context),
              child: const Text('Edit Hub'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCreateHub(BuildContext context) {
    context.goNamed(AppPage.create.name);
  }

  void _navigateToEditHub(BuildContext context) {
    // Assuming you have a way to select or determine which hub to edit
    // For example, a selectedHubId variable
    // String selectedHubId = ...;
    // context.goNamed(AppPage.editHub.name, params: {'hubId': selectedHubId});

    // For now, using a placeholder
    context.goNamed(AppPage.edit.name, pathParameters: {'id': '2'});
  }
}
