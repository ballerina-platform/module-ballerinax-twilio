## Overview

The Twilio API provides the capability to access its platform for communications. These APIs connect the software layer and communication networks worldwide, enabling users to call and message anyone globally.

This package supports [Twilio Basic API version 2010-04-01](https://www.twilio.com/docs/all).

## Prerequisites

Before using this connector in your Ballerina application, please complete the following steps:

1. Create a [Twilio account](https://www.twilio.com/).

2. Obtain a [Twilio phone number](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-).

    > **Tip:** If you are using a trial account, you may need to verify your recipients' phone numbers before initiating any communication with them.

3. Obtain a [Twilio Account Auth Token](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them).

4. Configure the connector with the obtained tokens.

# Quickstart

To use the Twilio connector in your Ballerina application, update the `.bal` file as follows:

### Step 1 - Import the package

Import the Twilio package into your Ballerina program as shown below:

```ballerina
import ballerinax/twilio;
```

### Step 2 - Create a new connector instance

To create a new connector instance, add a configuration as follows (You can use [configurable variables](https://ballerina.io/learn/by-example/configurable.html) to provide the necessary credentials):

```ballerina
configurable string accountSID= ?;
configurable string authToken = ?;

twilio:ConnectionConfig twilioConfig = {
    auth: {
        username: accountSID,
        password: authToken
    }
};

twilio:Client twilio = check new (twilioConfig);
```

### Step 3 - Invoke the connector operation

1. Invoke the connector operation using the client as shown below:

```ballerina
public function main() returns error? {
    twilio:Account account = check twilio->fetchAccount(accountSID);
}
```

2. Use `bal run` command to compile and run the Ballerina program.

**[You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples)**

# Examples

### Send SMS
This sample demonstrates a scenario where the Twilio connector is used to send a text message to a number.

```ballerina
import ballerina/io;
import ballerinax/twilio;

// Account configurations
configurable string accountSID= ?;
configurable string authToken = ?;

public function main() returns error? {

    // Twilio Client configuration
    twilio:ConnectionConfig twilioConfig = {
        auth: {
            username: accountSID,
            password: authToken
        }
    };

    // Initialize Twilio Client
    twilio:Client twilio = check new (twilioConfig);

    // Create a request for SMS
    twilio:CreateMessageRequest messageRequest = {
        To: "+XXXXXXXXXXX",
        From: "+XXXXXXXXXXX",
        Body: "Hello from Ballerina"
    };

    // Send the SMS
    twilio:Message response = check twilio->createMessage(accountSID, messageRequest);

    // Print SMS status
    io:print(response?.status);
}
```

### Make a call
This sample demonstrates a scenario where the Twilio connector is used to make a voice call to a number.

```ballerina
import ballerina/io;
import ballerinax/twilio;

// Account configurations
configurable string accountSID= ?;
configurable string authToken = ?;

public function main() returns error? {

    // Twilio Client configuration
    twilio:ConnectionConfig twilioConfig = {
        auth: {
            username: accountSID,
            password: authToken
        }
    };

    // Initialize Twilio Client
    twilio:Client twilio = check new (twilioConfig);

    // Create a request to make a voice call
    twilio:CreateCallRequest callRequest = {
        To: "+XXXXXXXXXXX",
        From: "+XXXXXXXXXXX",
        Url: "http://demo.twilio.com/docs/voice.xml"
    };

    // Make a voice call
    twilio:Call response = check twilio->createCall(accountSID, callRequest);

    // Print call status
    io:print(response?.status);

}
```