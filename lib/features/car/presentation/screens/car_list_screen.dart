// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:scr_vendor/core/utils/extension.dart';

/// Represents the car screen of the application.
class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.carsPageTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: const Center(),
    );
  }
}
