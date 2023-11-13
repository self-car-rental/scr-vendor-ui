// Package imports:
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/core/amplify/amplify_config.dart';
import 'package:scr_vendor/core/utils/app_logger.dart';

final AppLogger _logger = AppLogger();

Future<void> initializeAmplify() async {
  if (Amplify.isConfigured) {
    _logger.info('Amplify is already configured');
    return;
  }

  try {
    _logger.info('Configuring Amplify...');
    await Amplify.addPlugin(AmplifyAPI());
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyConfig);
    _logger.info('Amplify configured successfully.');
  } on AmplifyAlreadyConfiguredException {
    _logger.error('Amplify was already configured. Was the app restarted?');
  } catch (e, stacktrace) {
    _logger.error('Error configuring Amplify: $e', e, stacktrace);
  }
}
