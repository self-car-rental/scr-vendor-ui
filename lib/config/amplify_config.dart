const amplifyConfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "api": {
    "plugins": {
      "awsAPIPlugin": {
        "Api": {
          "endpointType": "REST",
          "endpoint": "https://1ubsx75vi5.execute-api.ap-south-1.amazonaws.com/dev",
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
              "PoolId": "ap-south-1:b134905c-2e40-455c-b1d4-802a56941f9c",
              "Region": "ap-south-1"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "ap-south-1_94fkvbwAg",
            "AppClientId": "5795jto817ajla9na16ab37kae",
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
