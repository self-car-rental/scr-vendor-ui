// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:scr_vendor/common/dialogs/progress_dialog.dart';
import 'package:scr_vendor/common/dialogs/retry_dialog.dart';
import 'package:scr_vendor/constants/app_language_constants.dart';
import 'package:scr_vendor/core/bloc/localization/localization_bloc.dart';
import 'package:scr_vendor/core/bloc/localization/localization_event.dart';
import 'package:scr_vendor/core/bloc/theme/theme_bloc.dart';
import 'package:scr_vendor/core/utils/extension.dart';
import 'package:scr_vendor/core/utils/navigation_utils.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.dice),
          onPressed: () => context.read<ThemeBloc>().add(const ThemeEvent()),
        ),
        title: Text(
          context.tr.profilePageTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
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
              .add(ChangeLanguageEvent(Locale(newValue)));
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              _buildSignOutButton(context),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignOutSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _navigateToSignIn(context);
                    });
                  } else if (state is SignOutFailure) {
                    showDialog(
                      context: context,
                      builder: (_) => RetryDialog(
                        title: state.error,
                        onRetryPressed: () => _buildSignOutButton(context),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SignOutLoading) {
                    return ProgressDialog(
                      title: context.tr.profileProgressLogout,
                      isProgressed: true,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onSignOutPressed(context),
      child: Text(context.tr.profileLogoutButtonTitle),
    );
  }

  void _onSignOutPressed(BuildContext context) {
    context.read<AuthBloc>().add(SignOutRequested());
  }

  void _navigateToSignIn(BuildContext context) {
    NavigationUtils.navigateToSignIn(context);
  }
}
