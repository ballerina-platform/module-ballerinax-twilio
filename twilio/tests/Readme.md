# Ballerina Twilio Endpoint - Tests

The Twilio connector allows you to send SMS, voice, and OTP messages through the Twilio REST API. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.

## Compatibility

| Ballerina Language Version  | Twilio Basic API Version | Twilio Authy API Version |
|:---------------------------:|:------------------------:|:------------------------:|
| 0.970.0                     | 2010-04-01               | v1                       |

## Running tests

All the tests inside this package will make HTTP calls to the Twilio REST API.

In order to run the **basic group** tests, the user will need to have a Twilio account and obtain the tokens from the app.
Then user will need to create a `ballerina.conf` file at package root and do the following configurations with the 
obtained tokens.

In order to run the **authy group** tests, the user will need to create a Authy application under Twilio account and 
obtain the _PRODUCTION API KEY_. Then user has to update the `ballerina.conf` file with the obtained token.

Please note that all the settings under Authy App configuration should be enabled.

###### ballerina.conf

```ballerina.conf
ACCOUNT_SID="your_account_sid"
AUTH_TOKEN="your_auth_token"
AUTHY_API_KEY="your_authy_app_production_key"
```

| Parameter       | Description                                                                                  |
| --------------- | -------------------------------------------------------------------------------------------- |
| ACCOUNT_SID     | Account SID of your own twilio account                                                       |
| AUTH_TOKEN      | Auth token of your own twilio account                                                        |
| AUTHY_API_KEY   | Production API key of the Authy app of your own twilio account                               |

#### Run all the test cases
```
ballerina init
ballerina test twilio -c /path/to/.ballerina.conf/file
```