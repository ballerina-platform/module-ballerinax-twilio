# Ballerina Twilio Connector - Tests

Ballerina Twilio connector allows you to access the [Twilio REST API](https://www.twilio.com/docs/api) and perform 
actions like sending a simple text message, making a voice call etc.

## Compatibility

| Language Version           | Connector Version   | Twilio API Version |
| -------------------------- | ------------------- | ------------------ |
| 0.970.0-alpha5-SNAPSHOT    | 0.5.6               | 2010-04-01         |

## Running tests

All the tests inside this package will make HTTP calls to the Twilio REST API.

In order to run the tests, the user will need to have a Twilio account and obtain the tokens from the app.
Then user will need to create a `ballerina.conf` file at package root and do the following configurations with the 
obtained tokens.

###### ballerina.conf

```ballerina.conf
ACCOUNT_SID="your_account_sid"
AUTH_TOKEN="your_auth_token"
FROM_MOBILE="your_from_mobile_number"
TO_MOBILE="your_to_mobile_number"
MESSAGE="your_sms_message"
TWIML_URL="your_twiml_url"
```

| Parameter   | Description                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------- |
| ACCOUNT_SID | Account SID of your own twilio account                                                       |
| AUTH_TOKEN  | Auth token of your own twilio account                                                        |
| FROM_MOBILE | The mobile number which the sms or voice call should be initiated                            |
| TO_MOBILE   | The mobile number which the sms or voice call should be received to                          |
| MESSAGE     | The text message which the sms should have                                                   |
| TWIML_URL   | The url which the have the set of instructions, what to do when you receive an incoming call |

Run tests :
```
ballerina init
ballerina test twilio
```