# Ballerina Twilio Connector - Tests

Ballerina Twilio connector allows you to access the [Twilio REST API](https://www.twilio.com/docs/api) and perform 
actions like sending a simple text message, making a voice call etc.

## Compatibility

| Language Version           | Connector Version   | Twilio Basic API Version | Twilio Authy API Version |
| -------------------------- | ------------------- | ------------------------ | ------------------------ |
| 0.970.0-beta1-SNAPSHOT     | 0.5.8               | 2010-04-01               | v1                       |

## Running tests

All the tests inside this package will make HTTP calls to the Twilio REST API.

In order to run the **basic group** tests, the user will need to have a Twilio account and obtain the tokens from the app.
Then user will need to create a `ballerina.conf` file at package root and do the following configurations with the 
obtained tokens.

In order to run the **authy group** tests, the user will need to create a Authy application under Twilio account and 
obtain the _PRODUCTION API KEY_. Then user has to update the `ballerina.conf` file with the obtained token.
###### ballerina.conf

```ballerina.conf
ACCOUNT_SID="your_account_sid"
AUTH_TOKEN="your_auth_token"
FROM_MOBILE="your_from_mobile_number"
TO_MOBILE="your_to_mobile_number"
MESSAGE="your_sms_message"
TWIML_URL="your_twiml_url"
AUTHY_API_KEY="your_authy_app_production_key"
```

| Parameter       | Description                                                                                  |
| --------------- | -------------------------------------------------------------------------------------------- |
| ACCOUNT_SID     | Account SID of your own twilio account                                                       |
| AUTH_TOKEN      | Auth token of your own twilio account                                                        |
| FROM_MOBILE     | The mobile number which the sms or voice call should be initiated                            |
| TO_MOBILE       | The mobile number which the sms or voice call should be received to                          |
| MESSAGE         | The text message which the sms should have                                                   |
| TWIML_URL       | The url which the have the set of instructions, what to do when you receive an incoming call |
| X_AUTHY_API_KEY | Production API key of the Authy app of your own twilio account                               |

Run tests :
```
ballerina init
ballerina test twilio
```