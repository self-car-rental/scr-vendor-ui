// Package imports:
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/common/log/log.dart';
import 'package:scr_vendor/config/amplify_config.dart';

// Project imports:

final log = Log();

Future<void> initializeAmplify() async {
  if (Amplify.isConfigured) {
    log.i('Amplify is already configured');
    return;
  }
  try {
    log.i('Configuring Amplify...');
    await Amplify.addPlugins([AmplifyAPI(), AmplifyAuthCognito()]);
    await Amplify.configure(amplifyConfig);
    log.i('Amplify configured successfully.');
  } on AmplifyAlreadyConfiguredException {
    log.e('Amplify was already configured. Was the app restarted?');
  } on Exception catch (e, stacktrace) {
    log.e('Error configuring Amplify: $e', e, stacktrace);
  }
}
