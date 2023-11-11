// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/constants/app_route_constants.dart';
import 'package:scr_vendor/constants/language_constants.dart';
import 'package:scr_vendor/core/app_extension.dart';
import 'package:scr_vendor/core/localization/localization_bloc.dart';
import 'package:scr_vendor/core/localization/localization_event.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.profilePageTitle),
        actions: <Widget>[
          _buildLanguageDropdown(context, currentLocale),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, String currentLanguage) {
    return DropdownButton<String>(
      value: currentLanguage,
      items: LanguageConstants.languages.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          context
              .read<LocalizationBloc>()
              .add(LocalizationEvent(Locale(newValue)));
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _handleLogout(context),
        child: Text(context.tr.profileLogoutButtonTitle),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(SignOutRequested());
    _navigateToSignIn(context);
  }

  void _navigateToSignIn(BuildContext context) {
    context.goNamed(AppRoutes.name(AppPage.signin));
  }
}
