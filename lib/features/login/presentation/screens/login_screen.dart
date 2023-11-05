// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/core/app_route_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.login.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppPage.signup.name);
              },
              child: const Text('Signup'),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppPage.user.name);
              },
              child: const Text('users'),
            ),
          ],
        ),
      ),
    );
  }
}
