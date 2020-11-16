[![Build Status](https://travis-ci.org/ballerina-platform/module-twilio.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-twilio)

# Twilio Connector

The Twilio connector allows you to send SMS, voice, OTP, and WhatsApp messages through the Twilio REST API. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.

WhatsApp messaging requires users to use predefined [message templates](https://www.twilio.com/docs/sms/whatsapp/tutorial/send-whatsapp-notification-messages-templates). Templates are message formats, which can be used over and over again to message users. Use of templates enables to maintain high-quality content as well as to avoid spam messages. However, this requires the WhatsApp message templates to be predefined.

## Compatibility

|                          |    Version         |
|:------------------------:|:------------------:|
| Ballerina Language       | Swan Lake Preview4 |
| Twilio Basic API         | 2010-04-01         |
| Twilio Authy API Version | v1                 |

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
            // If unsuccessful, print the error returned.
            io:println("Error: ", details);
        }
    }
	```
