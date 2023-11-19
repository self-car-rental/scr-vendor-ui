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
import 'package:scr_vendor_ui/core/utils/navigation.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_state.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.verifyOtpPageTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildOtpInput(context),
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

  Widget _buildOtpInput(BuildContext context) {
    return TextInput(
      controller: _otpController,
      hint: context.tr.verifyOtpEnterOtpHint,
      validator: Validators.validateOtp,
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onVerifyOtpPressed(context),
      child: Text(context.tr.verifyOtpButtonTitle),
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
          Navigation.navigateToHubs(context);
        } else if (state is VerifyOtpInvalid) {
          _showRetryDialog(context, 'Invalid OTP');
        } else if (state is VerifyOtpFailedThrice) {
          Navigation.navigateToSignIn(context);
        } else if (state is VerifyOtpFailure) {
          _showRetryDialog(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is VerifyOtpLoading) {
          return ProgressDialog(
            title: context.tr.verifyOtpProgressVerifying,
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
