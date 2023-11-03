// Package imports:
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/common/amplify/amplify_config.dart';
import 'package:scr_vendor/common/log/log.dart';

// Project imports:

class AmplifyClient {
  final log = Log();
  AmplifyClient() {
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    if (Amplify.isConfigured) {
      log.i('Amplify is already configured');
      return;
    }
    try {
      log.i('Configuring Amplify...');
      await Amplify.addPlugins([AmplifyAPI(), AmplifyAuthCognito()]);
      await Amplify.configure(amplifyConfig);
      log.i('Amplify configured successfully.');
    } catch (e, stacktrace) {
      log.e('Error configuring Amplify: $e', e, stacktrace);
    }
  }
}
