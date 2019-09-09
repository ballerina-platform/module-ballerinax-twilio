[![Build Status](https://travis-ci.org/wso2-ballerina/module-twilio.svg?branch=master)](https://travis-ci.org/wso2-ballerina/module-twilio)

# Twilio Connector

The Twilio connector allows you to send SMS, voice, and OTP messages through the Twilio REST API. You can also send
user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.

## Compatibility

| Ballerina Language Version  | Twilio Basic API Version | Twilio Authy API Version |
|:---------------------------:|:------------------------:|:------------------------:|
| 1.0.0                       | 2010-04-01               | v1                       |

## Getting started

1.  Refer the [Getting Started](https://ballerina.io/learn/getting-started/) guide to download and install Ballerina.

2.  To use Twilio endpoint, you need to provide the following:

       - Account SId
       - Auth Token
       - Authy API Key

       *Please note that, providing Authy API Key is required only if you are going to use Authy related APIs*

3. Create a new Ballerina project by executing the following command.

	```shell
	<PROJECT_ROOT_DIRECTORY>$ ballerina init
	```

4. Import the Twilio module to your Ballerina program as follows.

	```ballerina
	import ballerina/config;
	import ballerina/io;
    import wso2/twilio;

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
