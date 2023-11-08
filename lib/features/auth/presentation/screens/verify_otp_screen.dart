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
import 'package:scr_vendor/constants/app_route_constants.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_state.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppPage.verifyOtp.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildOtpInput(),
              const SizedBox(height: 30),
              _buildVerifyButton(context),
              const SizedBox(height: 20),
              _buildBlocConsumer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInput() {
    return TextInput(
      controller: _otpController,
      hint: 'Enter OTP',
      validator: Validators.validateOtp,
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onVerifyOtpPressed(context),
      child: const Text('Verify OTP'),
    );
  }

  void _onVerifyOtpPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(VerifyOtpRequested(_otpController.text));
    }
  }

  Widget _buildBlocConsumer(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          context.go(AppPage.hubs.path);
        } else if (state is VerifyOtpInvalid) {
          _showRetryDialog(context, 'Invalid OTP');
        } else if (state is VerifyOtpFailure) {
          _showRetryDialog(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is VerifyOtpLoading) {
          return const ProgressDialog(
            title: 'Verifying OTP...',
            isProgressed: true,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showRetryDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => RetryDialog(
        title: message,
        onRetryPressed: () => _onVerifyOtpPressed(context),
      ),
    );
  }
}
