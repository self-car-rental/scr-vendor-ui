const amplifyConfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "api": {
    "plugins": {
      "awsAPIPlugin": {
        "Api": {
          "endpointType": "REST",
          "endpoint": "https://gpub0fw1i4.execute-api.ap-south-1.amazonaws.com/dev",
          "region": "ap-south-1",
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
              "PoolId": "ap-south-1:fb4a35a6-5067-4683-ad12-3d818182f1b2",
              "Region": "ap-south-1"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "ap-south-1_NtWjcZRnB",
            "AppClientId": "4m73633uk85mo4ecds5saph8fl",
            "Region": "ap-south-1"
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
