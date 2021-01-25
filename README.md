[![Build Status](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio)

# Twilio Connector

The Twilio connector consists with two modules
    1. Client Connector
    2. Listener Connector

## Compatibility

|                          |    Version         |
|:------------------------:|:------------------:|
| Ballerina Language       | Swan Lake Preview8 |
| Twilio Basic API         | 2010-04-01         |
| Twilio Authy API Version | v1                 |

## Module Overview - `ballerinax/twilio`

The Twilio Client connector allows you to send SMS, voice, OTP, and WhatsApp messages through the Twilio REST API. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.

WhatsApp messaging requires users to use predefined [message templates](https://www.twilio.com/docs/sms/whatsapp/tutorial/send-whatsapp-notification-messages-templates). Templates are message formats, which can be used over and over again to message users. Use of templates enables to maintain high-quality content as well as to avoid spam messages. However, this requires the WhatsApp message templates to be predefined.

## Feature Overview

1. Send SMS, WhatsApp messages
2. Send OTP via messages or voice message (via a call)
3. Add and delete [Authy](https://www.twilio.com/authy) users.
3. Make voice calls

## Getting started

1.  Refer the [Get Started](https://ballerina.io/v1-1/learn/) section to download and install Ballerina.

2.  To use Twilio endpoint, you need to provide the following:

       - Account SId
       - Auth Token
       - Authy API Key

       *Please note that, providing Authy API Key is required only if you are going to use Authy related APIs*

3. Import the Twilio module to your Ballerina program as follows.

	```ballerina
	import ballerina/config;
	import ballerina/io;
    import ballerinax/twilio;

    twilio:TwilioConfiguration twilioConfig = {
        accountSId: config:getAsString("ACCOUNT_SID"),
        authToken: config:getAsString("AUTH_TOKEN"),
        xAuthyKey: config:getAsString("AUTHY_API_KEY")
    };
    twilio:Client twilioClient = new(twilioConfig);

    public function main() {
        var details = twilioClient->getAccountDetails();
        if (details is twilio:Account) {
            io:println("Account Details: ", details);
        } else {
            // If unsuccessful, prints the error returned.
            io:println("Error: ", details);
        }
    }
	```

## Module Overview - `ballerinax/twilio.webhook`

The Twilio Listener connector allows you to listen to Twilio SMS and Call status change events.

### Feature Overview

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

### Getting started

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
            if (payload is webhook:SmsEvent) {

                if (payload.SmsStatus === webhook:RECEIVED) {
                    io:println("message received");
                    io:println(payload);
                } 

            } 
        }
    }
	```