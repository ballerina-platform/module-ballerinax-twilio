## Overview

The Twilio API provides capability to access its platform for communications. These APIs connects the software layer and 
communications networks around the world to allow users to call and message anyone, globally. 

This module supports [Twilio Basic API version 2010-04-01](https://www.twilio.com/docs/all). 

## Prerequisites
Before using this connector in your Ballerina application, complete the following:

* Create a [Twilio account](https://www.twilio.com/).
* Obtain tokens as follows:

1. Create a Twilio account.

2. Obtain a [Twilio phone number](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-).

!!! Tip

If you use a trail account, you may need to verify your recipient phone numbers before having any communication with them.

3. Obtain a [Twilio Account Auth Token](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them). 

4. If you want to use WhatsApp service, Configure your Twilio phone number to use WhatsApp services. For instructions, see [Twilio Documentation - Manage and Configure Your WhatsApp-enabled Twilio Numbers](https://www.twilio.com/docs/whatsapp/api#manage-and-configure-your-whatsapp-enabled-twilio-numbers).

5. Configure the connector with obtained tokens.

# Quickstart

To use the Twilio connector in your Ballerina application, update the .bal file as follows:

### Step 1 - Import connector
Import the Twilio module to your Ballerina program as follows. You can use [configurable variables](https://ballerina.io/learn/by-example/configurable.html) to provide the necessary credentials.

```ballerina
import ballerinax/twilio;
```

### Step 2 - Create a new connector instance
To create a new connector instance, add a configuration as follows:
```ballerina
configurable string accountSId = ?;
configurable string authToken = ?;

twilio:TwilioConfiguration twilioConfig = {
    accountSId: accountSId,
    authToken: authToken
};

twilio:Client twilioClient = new (twilioConfig);
```

### Step 3 - Invoke  connector operation
1. Invoke the connector operation using the client as follows:
```ballerina
public function main() returns error? {
    twilio:Account response = check twilioClient->getAccountDetails();
}
```
2. Use `bal run` command to compile and run the Ballerina program.

**[You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/twilio/samples)**
