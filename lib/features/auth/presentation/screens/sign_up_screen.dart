// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor_ui/common/dialogs/progress_dialog.dart';
import 'package:scr_vendor_ui/common/dialogs/retry_dialog.dart';
import 'package:scr_vendor_ui/common/validators/validators.dart';
import 'package:scr_vendor_ui/common/widgets/text_input.dart';
import 'package:scr_vendor_ui/core/utils/extension.dart';
import 'package:scr_vendor_ui/core/utils/navigation_utils.dart';
import 'package:scr_vendor_ui/features/auth/data/models/user_cognito_model.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.signupPageTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildNameInput(context),
              const SizedBox(height: 15),
              _buildEmailInput(context),
              const SizedBox(height: 15),
              _buildMobileInput(context),
              const SizedBox(height: 30),
              _buildSignUpButton(context),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      NavigationUtils.navigateToSignIn(context);
                    });
                  } else if (state is SignUpFailure) {
                    showDialog(
                      context: context,
                      builder: (_) => RetryDialog(
                        title: state.error,
                        onRetryPressed: () => _onSignUpPressed(context),
                      ),
                    );
                  } else if (state is UserMobileAlreadyExists) {
                    showDialog(
                      context: context,
                      builder: (_) => ProgressDialog(
                        title: context.tr.signupMobileExistsMessage,
                        isProgressed: false,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return ProgressDialog(
                      title: context.tr.usersProgressCreating,
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

  Widget _buildNameInput(BuildContext context) {
    return TextInput(
      controller: _nameController,
      hint: context.tr.signupEnterNameHint,
      validator: Validators.validateName,
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return TextInput(
      controller: _emailController,
      hint: context.tr.signupEnterEmailHint,
      validator: Validators.validateEmail,
    );
  }

  Widget _buildMobileInput(BuildContext context) {
    return TextInput(
      controller: _mobileController,
      hint: context.tr.signupEnterMobileHint,
      validator: Validators.validateMobile,
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onSignUpPressed(context),
      child: Text(
        context.tr.signupButtonTitle,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  void _onSignUpPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final newUser = UserCognitoModel(
        name: _nameController.text,
        email: _emailController.text,
        mobile: _mobileController.text,
      );
      context.read<AuthBloc>().add(SignUpRequested(newUser));
    }
  }
}
