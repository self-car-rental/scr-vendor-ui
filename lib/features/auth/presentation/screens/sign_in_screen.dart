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
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_state.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppPage.signin.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildMobileInput(),
              const SizedBox(height: 30),
              _buildSignInButton(context),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignInSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.goNamed(AppPage.verifyOtp.name);
                    });
                  } else if (state is SignInFailure) {
                    showDialog(
                      context: context,
                      builder: (_) => RetryDialog(
                        title: state.error,
                        onRetryPressed: () => _onSignInPressed(context),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SignInLoading) {
                    return const ProgressDialog(
                      title: 'Send otp...',
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

  Widget _buildMobileInput() {
    return TextInput(
      controller: _mobileController,
      hint: 'Enter Mobile',
      validator: Validators.validateMobile,
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onSignInPressed(context),
      child: const Text('Sign In'),
    );
  }

  void _onSignInPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(SignInRequested(_mobileController.text));
    }
  }
}
