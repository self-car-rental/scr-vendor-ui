// Project imports:
import 'package:scr_vendor_ui/config/app_config.dart';

const amplifyConfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "api": {
    "plugins": {
      "awsAPIPlugin": {
        "Api": {
          "endpointType": "REST",
          "endpoint": "${AppConfig.apiEndpoint}",
          "region": "${AppConfig.region}",
          "authorizationType": "AWS_IAM"
        }
      }
    }
  },
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "UserAgent": "aws-amplify-cli/0.1.0",
        "Version": "0.1.0",
        "IdentityManager": {
          "Default": {}
        },
        "CredentialsProvider": {
          "CognitoIdentity": {
            "Default": {
              "PoolId": "${AppConfig.cognitoIdentityPoolId}",
              "Region": "${AppConfig.region}"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "${AppConfig.userPoolId}",
            "AppClientId": "${AppConfig.appClientId}",
            "Region": "${AppConfig.region}"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "CUSTOM_AUTH"
          }
        }
      }
    }
  }
}''';
