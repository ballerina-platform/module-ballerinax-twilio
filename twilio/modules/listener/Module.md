[![Build Status](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio)

# Twilio Listener Connector

The Twilio Listener connector allows you to listen for status change events from Twilio SMS and Twilio Voice. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.



## Compatibility

|                          |    Version         |
|:------------------------:|:------------------:|
| Ballerina Language       | Swan Lake Alpha 4  |
| Twilio Basic API         | 2010-04-01         |

The Twilio Listener connector allows you to listen to Twilio SMS and Call status change events.

## Feature Overview

1. Listen to incoming message events and message status change callback events from the twilio SMS
2. Listen to incoming call events and call status change callback events from the twilio Voice Call

### Note:

Callback URL registration method depends on the event type.
1. Twilio SMS
 - Incoming Messages
    - Callback webhook URL has to be registered in the console under the particular Twilio number.
 - Status change events
    - Callback webhook URL has to be registered at the time of sending the SMS (from the client connector)
2. Twilio Call
 - Incoming Call
    - Callback webhook URL has to be registered in the console under the particular Twilio number.
 - Status change events
    - Callback webhook URL has to be registered at the time of making the call (from the client connector)

## Getting started

1.  Refer the [Get Started](https://ballerina.io/v1-1/learn/) section to download and install Ballerina.

2. Import the Twilio Webhook module to your Ballerina program as follows.

```ballerina
import ballerina/log;
import ballerinax/twilio;
import ballerinax/twilio.'listener as twilioListener;

configurable string & readonly twilioAccountSid = ?;
configurable string & readonly twilioAuthToken = ?;
configurable string & readonly fromNumber = ?;
configurable string & readonly toNumber = ?;
configurable string & readonly test_message = ?;
configurable string & readonly twimlUrl = ?;
configurable string & readonly callbackUrl = ?;
configurable int & readonly port = ?;

listener twilioListener:Listener tListener = new (port, twilioAuthToken, callbackUrl);

service / on tListener {
    remote function onSmsSent(twilioListener:SmsStatusChangeEvent event) returns error? {
        log:printInfo("Sent", event);
    }
}

public function main() {
    twilio:TwilioConfiguration twilioConfig = {
        accountSId: twilioAccountSid,
        authToken: twilioAuthToken
    };
    twilio:Client twilioClient = new (twilioConfig);
    var details = twilioClient->sendSms(fromNumber, toNumber, test_message, callbackUrl);
    if (details is error) {
        log:printInfo(details.message());
    }

}
```