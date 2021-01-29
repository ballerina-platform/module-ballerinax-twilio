[![Build Status](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio)

# Twilio Listener Connector

The Twilio Listener connector allows you to listen for status change events from Twilio SMS and Twilio Voice. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.



## Compatibility

|                          |    Version         |
|:------------------------:|:------------------:|
| Ballerina Language       | Swan Lake Preview8 |
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
	import ballerina/io;
    import ballerinax/twilio.webhook as webhook;
    import ballerina/websub;
    import ballerina/config;

    string port = config:getAsString("PORT");
    int PORT = check ints:fromString(port);
    listener webhook:TwilioWebhookListener twilioListener = new (PORT);

    @websub:SubscriberServiceConfig {
        subscribeOnStartUp: false
    }
    service websub:SubscriberService /twilio on twilioListener {

        // All the incoming events from Twilio will trigger this onNotification() function
        remote function onNotification(websub:Notification notification) {

            // getEventType() function from the twilio listener instance will extract the event payload as TwilioEvent record.
            TwilioEvent payload = twilioListener.getEventType(notification);

            // Applying a conditional filtering to extract the events we are interested in.
            if (payload is webhook:SmsStatusChangeEvent) {

                if (payload.SmsStatus === webhook:RECEIVED) {
                    io:println("message received");
                    io:println(payload);
                } 

            } 
        }
    }
	```