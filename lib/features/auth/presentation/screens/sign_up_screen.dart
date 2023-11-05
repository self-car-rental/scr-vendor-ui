// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/common/dialog/progress_dialog.dart';
import 'package:scr_vendor/common/dialog/retry_dialog.dart';
import 'package:scr_vendor/common/validators/validators.dart';
import 'package:scr_vendor/common/widget/text_input.dart';
import 'package:scr_vendor/core/app_route_constants.dart';
import 'package:scr_vendor/features/auth/data/models/user_cognito_model.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppPage.signup.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildNameInput(),
              const SizedBox(height: 15),
              _buildEmailInput(),
              const SizedBox(height: 15),
              _buildMobileInput(),
              const SizedBox(height: 30),
              _buildSignUpButton(context),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.goNamed(AppPage.login.name);
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
                      builder: (_) => const ProgressDialog(
                        title: 'Mobile number already exists',
                        isProgressed: false,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return const ProgressDialog(
                      title: 'Creating user...',
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

  Widget _buildNameInput() {
    return TextInput(
      controller: _nameController,
      hint: 'Enter Name',
      validator: Validators.validateName,
    );
  }

  Widget _buildEmailInput() {
    return TextInput(
      controller: _emailController,
      hint: 'Enter Email',
      validator: Validators.validateEmail,
    );
  }

  Widget _buildMobileInput() {
    return TextInput(
      controller: _mobileController,
      hint: 'Enter Mobile',
      validator: Validators.validateMobile,
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onSignUpPressed(context),
      child: const Text('Sign Up'),
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
