// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:go_router/go_router.dart';
// Project imports:
import 'package:scr_vendor/core/app_route_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.home.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.goNamed(AppPage.user.name);
          },
          child: const Text('Home'),
        ),
      ),
    );
  }
}
