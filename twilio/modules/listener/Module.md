## Overview

The Twilio Listener connector allows you to listen to Twilio SMS and Call status change events.
1. Listen to incoming message events and message status change callback events from the twilio SMS
2. Listen to incoming call events and call status change callback events from the twilio Voice Call

This module supports 2010-04-01 version

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

## Prerequisites
Before using this connector in your Ballerina application, complete the following:

* Create [Twilio Account](https://www.twilio.com/) to obtain Account SID, Auth Token and Twilio phone number
* Obtain tokens

1. Create a twilio account and follow [this link](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-) to obtain a twilio phone number. If you use a trail account, you may need to verify your recipient phone numbers before having any communication with them.

2. Go to this follow [this link](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them) to obtain twilio Account Auth Token. 

3. You need to provide port number where the twilio listener listens for any twilio events requests from Twilio service

4. You also need to provide a callback url before running the listener with suffix "onChange" example: <YOUR_CALL_BACK_URL>/onChange

* Configure the connector with obtained tokens

# Quickstart

To use the twilio listener in your Ballerina application, update the .bal file as follows:

### Step 1: Import twilio listener
```ballerina
    import ballerinax/twilio.'listener as twilioListener;
```
### Step 2: Provide credentials for the configuration
```ballerina
    configurable string & readonly twilioAuthToken = ?;
    configurable string & readonly callbackUrl = ?;
    configurable int & readonly port = ?;
```
### Step 3: Initialize the listener with the port and the configuration details
    listener twilioListener:Listener tListener = new (port, twilioAuthToken, callbackUrl);
### Step 4: Add the relevant remote function inside the service to be triggered by the twilio events
```ballerina
    service / on tListener {
        remote function onSmsDelivered(twilioListener:SmsStatusChangeEvent event) returns error? {
            log:printInfo("Delivered", event);
        }
    }
```

## Quick reference
Code snippets of some frequently used functions: 
* QUEUED/SENT/DELIVERED SMS Event
This examples shows how you can start a ballerina twilio listener using localhost. you will need to use ngork to expose a web server running on your local machine to the internet.
```ballerina
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
}
```
* Ringing/InProgress/Completed Voice Call Events
This provides the listener support to the voice calls. you will need to use ngork to expose a web server running on your local machine to the internet. Find more sample from here.
```ballerina
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
}
```
**[You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/twilio/samples)**
