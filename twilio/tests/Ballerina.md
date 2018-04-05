# Ballerina Twilio Connector - Tests

Ballerina Twilio connector allows you to access the [Twilio REST API](https://www.twilio.com/docs/api) and perform 
actions like sending a simple text message, making a voice call etc.

## Compatibility
| Language Version                           | Connector Version   | Twilio API Version |
| ------------------------------------------ | ------------------- | ------------------ |
| ballerina-tools-0.970.0-alpha1-SNAPSHOT    | 0.4                 | 2010-04-01         |

## Running tests

All the tests inside this package will make HTTP calls to the Twilio REST API.

In order to run the tests, the user will need to have a Twilio account and configure the constants with the obtained 
tokens with `test/test_constants.bal` file.

###### test_constants.bal
```test_constants.bal
public const string BASE_URL = "https://api.twilio.com/2010-04-01";
public const string ACCOUNT_SID = "";
public const string AUTH_TOKEN = "";
public const string FROM_MOBILE = "";
public const string TO_MOBILE = "";
public const string MESSAGE = "This is a sample message from Ballerina Twilio Connector";
public const string TWIML_URL = "";
```

| Parameter   | Description                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------- |
| BASE_URL    | The base url of the REST API                                                                 |
| ACCOUNT_SID | Account SID of your own twilio account                                                       |
| AUTH_TOKEN  | Auth token of your own twilio account                                                        |
| FROM_MOBILE | The mobile number which the sms or voice call should be initiated                            |
| TO_MOBILE   | The mobile number which the sms or voice call should be received to                          |
| MESSAGE     | The text message which the sms should have                                                   |
| TWIML_URL   | The url which the have the set of instructions, what to do when you receive an incoming call |

Run tests :
```
ballerina test tests/
```