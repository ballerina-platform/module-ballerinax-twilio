# Ballerina Twilio Endpoint - Tests

The Twilio connector allows you to send SMS, voice, OTP, and WhatsApp messages through the Twilio REST API. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.

WhatsApp messaging requires users to use predefined [message templates](https://www.twilio.com/docs/sms/whatsapp/tutorial/send-whatsapp-notification-messages-templates). Templates are message formats, which can be used over and over again to message users. Use of templates enables to maintain high-quality content as well as to avoid spam messages. However, this requires the WhatsApp message templates to be predefined.

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

In order to send WhatsApp messages using the Twilio connector, you need to either sign up for a Twilio account and acquire
a dedicated phone number approved by WhatsApp or activate the Twilio Sandbox for WhatsApp. The Twilio Sandbox allows
 you to prototype with WhatsApp immediately using a shared phone number without waiting for a dedicated number to be
  approved by WhatsApp. The following three configurations has to be updated to run WhatsApp-specific test cases.
  SAMPLE_MESSAGE needs to follow a predefined WhatsApp message template.

```ballerina.conf
export SAMPLE_WHATSAPP_SANDBOX="sender_mobile/sandbox_number"
export SAMPLE_TO_MOBILE="receiver_mobile"
export SAMPLE_MESSAGE="sample_message_to_send"
```



#### Run all the test cases

```sh
ballerina init
ballerina test twilio --b7a.config.file=/path/to/.ballerina.conf/file
```
