# Twilio Connector

[![Build Status](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/ballerina-platform/module-ballerinax-twilio?color=green&include_prereleases&label=latest%20release)

Connects the twilio communication services

# Introduction

Twilio’s APIs power its platform for communications. Behind these APIs is a software layer connecting and optimizing communications networks around the world to allow your users to call and message anyone, globally. Twilio has a whole host of APIs, from SMS to Voice to Wireless! You can find Twilio's API reference documentation throughout twilio product documentation. For more information, Please browse the various [Twilio APIs here](https://www.twilio.com/docs/api).
As twilio supports for [HTTP Basic authentication](https://en.wikipedia.org/wiki/Basic_access_authentication). It needs the URL authentication for each request using the credentials provided by the twilio. You can find both your account SID and auth token in the Twilio Console after signing up for [a free Twilio trial account](http://twilio.com/try-twilio?_ga=2.127476109.1229618101.1613523745-690133185.1613523745). 
Twilio uses webhooks to asynchronously let your application know when events happen, like getting an incoming call or receiving an SMS message.

# Connector Overview

The Twilio connector allows you to send SMS, voice and WhatsApp messages through the Twilio REST API and also connector provides the facility to receive inbound HTTP(S) requests (also known as webhooks) from Twilio's servers.
The Twilio connector consists with two modules

* Twilio client module  - The default module that has the twilio client which can be used to communicate through the SMS, VoiceCalls and Whatsapp messages.

* Webhook listener module  - The module that provides the listener supports for the twilio events such as SentSMSEvent, VoiceCallRinging etc.

# Prerequisites

* [Twilio Account](https://www.twilio.com/) to obtain Account SID, Auth Token and Twilio phone number

* Java 11 Installed. 
Java Development Kit (JDK) with version 11 is required.

* Ballerina Swan Lake Beta 1 is required. 

* (optional)[ngork](https://ngrok.com/) is requried to test listner samples using localhost

# Configuration

## Twilio Client Connector Configuration

1. Create a twilio account and follow [this link](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-) to obtain a twilio phone number. If you use a trail account, you may need to verify your recipient phone numbers before having any communication with them.

2. Go to this follow [this link](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them) to obtain twilio Account, Auth Token. 

3. If you want to use Whatsapp service, Please configure your twilio phone number to use whatsApp services. You can find more detail on Twilio Whatsapp service [here](https://www.twilio.com/docs/whatsapp/api#manage-and-configure-your-whatsapp-enabled-twilio-numbers)

4. Now you can use the obtained credential to use Twilio client connector. To do that, you may create a twilio client as shown in the samples with the following configuration record. You can also use Ballerina configurable variables to provide the credentials.

```ballerina
twilio:TwilioConfiguration twilioConfig = {
        accountSId: <YOUR ACCOUNT SID>,
        authToken: <YOUR AUTH TOKEN>
    };
```
## Twilio Listener Configuration

1. Similar to the above steps you need to obtain a twilio Auth token to use the twilio listener.

2. You need to provide port number where the twilio listener listens for any twilio events requests from Twilio service

3. You also need to provide a callback url before running the listener with suffix "onChange"
example: <YOUR_CALL_BACK_URL>/onChange

4. To Listen to incoming SMS or Voice call events, you need to add a callback url in your twilio account as shown in the following figure.

# Supported Versions & Limitations

## Supported Versions

|                           |    Version         |
|:-------------------------:|:------------------:|
| Ballerina Language        | Swan Lake Beta 1   |
| Twilio Basic API          | 2010-04-01         |
| Java Development Kit (JDK)| 11                 |

## Limitations
* The connector doesn't support to Authy based operation at the moment.
* The connector only supports limited number of operations of the twilio APIs.

# Quickstart(s)

## Module - `ballerinax/twilio`

### Feature Overview

1. Send SMS, WhatsApp messages
2. Make voice calls
3. Get Account Details

### Getting started

1.  Have a [Quick Tour](https://ballerina.io/learn/getting-started/quick-tour/) section to download and install Ballerina.  

2.  To use Twilio endpoint, you need to provide the following:

       - Account SId
       - Auth Token

![image](twilio/samples/docs/dashboardTokens.png)

3. Import the Twilio module to your Ballerina program as follows. You can use [configurable variables](https://ballerina.io/learn/by-example/configurable.html) to provide the necessary credentials.

	```ballerina
	import ballerina/log;
    import ballerinax/twilio;

    configurable string accountSId = ?;
    configurable string authToken = ?;

    public function main() {
        //Twilio Client configuration
        twilio:TwilioConfiguration twilioConfig = {
            accountSId: accountSId,
            authToken: authToken
        };

        //Twilio Client
        twilio:Client twilioClient = new (twilioConfig);

        //Get account detail remote function is called by the twilio client
        var details = twilioClient->getAccountDetails();

        //Response is printed as log messages
        if (details is twilio:Account) {
            log:printInfo("Account Detail: " + details.toString());
        } else {
            log:printInfo(details.message());
        }
    }
	```

## Module - `ballerinax/twilio.listener`

### Feature Overview

The Twilio Listener connector allows you to listen to Twilio SMS and Call status change events.
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

1.  Have a [Quick Tour](https://ballerina.io/learn/getting-started/quick-tour/) section to download and install Ballerina.

2. Import the Twilio listener module to your Ballerina program as follows.

```ballerina
import ballerina/log;
import ballerinax/twilio;
import ballerinax/twilio.'listener as twilioListener;

configurable string & readonly twilioAuthToken = ?;
configurable string & readonly callbackUrl = ?;
configurable int & readonly port = ?;

listener twilioListener:Listener tListener = new (port, twilioAuthToken, callbackUrl);

service / on tListener {
    remote function onSmsDelivered(twilioListener:SmsStatusChangeEvent event) returns error? {
        log:printInfo("Delivered", event);
    }
}
```
# Samples
## Twilio Listener Operations

### QUEUED/SENT/DELIVERED SMS Event
This examples shows how you can start a ballerina twilio listener using localhost. you will need to use ngork to expose a web server running on your local machine to the internet. Find more sample from here. [Find more samples from here](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/samples/listener%20samples)

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
    remote function onSmsQueued(twilioListener:SmsStatusChangeEvent event) returns error? {
        log:printInfo("Queued", event);
    }
    remote function onSmsSent(twilioListener:SmsStatusChangeEvent event) returns error? {
        log:printInfo("Sent", event);
    }
    remote function onSmsDelivered(twilioListener:SmsStatusChangeEvent event) returns error? {
        log:printInfo("Delivered", event);
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
### Ringing/InProgress/Completed Voice Call Events
This provides the listener support to the voice calls. you will need to use ngork to expose a web server running on your local machine to the internet. Find more sample from here.

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
    remote function onCallRang(twilioListener:CallStatusChangeEvent event) returns error? {
        log:printInfo("Ringing", event);
    }
    remote function onCallAnswered(twilioListener:CallStatusChangeEvent event) returns error? {
        log:printInfo("In Progress", event);
    }
    remote function onCallCompleted(twilioListener:CallStatusChangeEvent event) returns error? {
        log:printInfo("Completed", event);
    }
}

public function main() {
    twilio:TwilioConfiguration twilioConfig = {
        accountSId: accountSId,
        authToken: authToken
    };
    twilio:Client twilioClient = new (twilioConfig);
    
    twilio:StatusCallback callbackInfo = {
        url: statusCallbackUrl,
        method: twilio:POST,
        events: [twilio:COMPLETED]
    };
    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlURL, callbackInfo);
    if (details is error) {
        log:printInfo(details.message());
    }

}
```
# Building from the source
1. You need to obtain a twilio Account SID, an Auth Token and a valid twilio phone number to use the twilio connector operations.
2. Clone the repository and Be sure to change to the branch which has the name as the Ballerina version. Eg: slAlpha5
    * Note: You need to install the relevant Ballerina version before going to the next step.
3. First, If you want to run tests, you will need to add to a Config.toml files to the client module test directory with the following credentials.
```ballerina
[ballerinax.twilio]
twilioAccountSid ="<ACCOUNT SID>"
twilioAuthToken ="<AUTH TOKEN>"
fromNumber ="<YOUR TWILIO NUMBER>"
toNumber ="RECIPIENT NUMBER"
test_message ="<SMS MESSAGE>"
twimlUrl ="<TWIML LINK>"
fromWhatsappNumber="<TWILIO WHATSAPP NUMBER>"
```
4. Run `./gradlew build` to build the java wrapper.

5. Run `bal build twilio` to build with tests or else Run `bal build --skip-tests twilio`.
