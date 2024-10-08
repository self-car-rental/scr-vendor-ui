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

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        context.tr.signinPageTitle,
        style: Theme.of(context).textTheme.displayMedium,
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildMobileInput(context),
              const SizedBox(height: 30),
              _buildSignInButton(context),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignInSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigation.navigateToVerifyOtp(context);
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
                    return ProgressDialog(
                      title: context.tr.signinProgressSendingOtp,
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

  Widget _buildMobileInput(BuildContext context) {
    return TextInput(
      controller: _mobileController,
      hint: context.tr.signinEnterMobileNumberPlaceholder,
      validator: Validators.validateMobile,
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onSignInPressed(context),
      child: Text(context.tr.signinButtonTitle),
    );
  }

  void _onSignInPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(SignInRequested(_mobileController.text));
    }
  }
}
