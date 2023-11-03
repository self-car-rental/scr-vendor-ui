const amplifyConfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "api": {
    "plugins": {
      "awsAPIPlugin": {
        "Api": {
          "endpointType": "REST",
          "endpoint": "https://0d6uzbwjle.execute-api.ap-south-1.amazonaws.com/dev",
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
              "PoolId": "ap-south-1:08130062-259a-4348-ad14-46539cca35ef",
              "Region": "ap-south-1"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "ap-south-1_QBkp6VGJf",
            "AppClientId": "2hubafgbbs05eo9dfa7mecjd17",
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
