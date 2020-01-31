# Ballerina Twilio Endpoint - Tests

The Twilio connector allows you to send SMS, voice, and OTP messages through the Twilio REST API. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.

## Compatibility

| Ballerina Language Version  | Twilio Basic API Version | Twilio Authy API Version |
|:---------------------------:|:------------------------:|:------------------------:|
| 1.1.x                       | 2010-04-01               | v1                       |

## Running tests

All the tests inside this module will make HTTP calls to the Twilio REST API.

In order to run the **basic group** tests, the user will need to have a Twilio account and obtain the tokens from the app.
Then user will need to create a `ballerina.conf` file at module root and do the following configurations with the obtained tokens.

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

Moreover, to run some specific test cases of `authy` group, you need to set up following configurations.

```ballerina.conf
export SAMPLE_FROM_MOBILE="sender_mobile"
export SAMPLE_TO_MOBILE="receiver_mobile"
export SAMPLE_MESSAGE="sample_message_to_send"
export SAMPLE_USER_EMAIL="user_email"
export SAMPLE_USER_PHONE="receiver_mobile"
export SAMPLE_USER_COUNTRY_CODE="country_code"
export SAMPLE_TWIML_URL="twilio_ml_url"
```

#### Run all the test cases

```sh
ballerina init
ballerina test twilio --b7a.config.file=/path/to/.ballerina.conf/file
```
