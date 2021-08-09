## Overview

The Twilio Listener connector allows you to listen to Twilio SMS and Call status change events.
1. Listen to incoming message events and message status change callback events from the twilio SMS
2. Listen to incoming call events and call status change callback events from the twilio Voice Call

This module supports [Twilio Basic API 2010-04-01](https://www.twilio.com/docs/all) version.


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

### Step 1 - Import listener
```ballerina
    import ballerinax/twilio.'listener as twilioListener;
```
### Step 2 - Create a new listener instance
```ballerina
    configurable string & readonly twilioAuthToken = ?;
    configurable string & readonly callbackUrl = ?;
    configurable int & readonly port = ?;

    listener twilioListener:Listener tListener = new (port, twilioAuthToken, callbackUrl);
```
### Step 3 - Add a service 
1. Add a service with necessary remote functions as below
```ballerina
    service / on tListener {
        remote function onSmsDelivered(twilioListener:SmsStatusChangeEvent event) returns error? {
            log:printInfo("Delivered", event);
        }
    }
```
2. Use `bal run` command to compile and run the Ballerina program.

**[You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/twilio/samples)**
