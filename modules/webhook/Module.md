[![Build Status](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio)

# Twilio Listener Connector

The Twilio Listener connector allows you to listen for status change events from Twilio SMS and Twilio Voice. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.



## Compatibility

|                          |    Version         |
|:------------------------:|:------------------:|
| Ballerina Language       | Swan Lake Alpha2 |
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
import ballerinax/twilio.webhook as webhook;
import ballerina/http;

configurable string fromMobile = ?;
configurable string toMobile = ?;
configurable string accountSId = ?;
configurable string authToken = ?;
configurable string message = "Wso2-Test-SMS-Message";

//ngork is used to get the callback url eg: http://6d602a963438.ngrok.io/twilio
configurable string statusCallbackUrl = ?;


//Starting a service with twilio listner by providing port,authToken, status call back url.
listener webhook:TwilioEventListener twilioListener = new (9090, authToken, statusCallbackUrl);
service / on twilioListener {
    resource function post twilio(http:Caller caller, http:Request request) returns error? {
        var payload = check twilioListener.getEventType(caller, request);

        //Check for the event and get the status of the event.
        if (payload is webhook:SmsStatusChangeEvent) {
            if (payload.SmsStatus == webhook:SENT) {
                log:print("An SMS has been sent");
            } 
        } 
    }
}

public function main() {
    twilio:TwilioConfiguration twilioConfig = {
        accountSId: accountSId,
        authToken: authToken
    };
    twilio:Client twilioClient = new (twilioConfig);
    var details = twilioClient->sendSms(fromMobile, toMobile, message, statusCallbackUrl);
    if (details is error) {
        log:print(details.message());
    }

}
```