// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:scr_vendor/core/themes/app_asset.dart';
import 'package:scr_vendor/core/themes/app_style.dart';

// Project imports:

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAsset.emptyState),
          Text(message, style: headLine1),
        ],
      ),
    );
  }
}
