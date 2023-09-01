## Overview

The Twilio API provides the capability to access its platform for communications. These APIs connect the software layer and
communications networks around the world to allow users to call and message anyone globally.

This package supports [Twilio Basic API version 2010-04-01](https://www.twilio.com/docs/all).

## Prerequisites

Before using this connector in your Ballerina application, complete the following:

1. Create a [Twilio account](https://www.twilio.com/).

2. Obtain a [Twilio phone number](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-).

    >**Tip:** If you use a trial account, you may need to verify your recipient's phone numbers before having any communication with them.

3. Obtain a [Twilio Account Auth Token](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them). 

4. If you want to use WhatsApp service, Configure your Twilio phone number to use WhatsApp services. For instructions, see [Twilio Documentation - Manage and Configure Your WhatsApp-enabled Twilio Numbers](https://www.twilio.com/docs/whatsapp/api#manage-and-configure-your-whatsapp-enabled-twilio-numbers).

5. Configure the connector with obtained tokens.

# Quickstart

To use the Twilio connector in your Ballerina application, update the `.bal` file as follows:

### Step 1 - Import the package

Import the Twilio package to your Ballerina program as follows. You can use [configurable variables](https://ballerina.io/learn/by-example/configurable.html) to provide the necessary credentials.

```ballerina
import ballerinax/twilio;
```

### Step 2 - Create a new connector instance

To create a new connector instance, add a configuration as follows:

```ballerina
configurable string accountSId = ?;
configurable string authToken = ?;

twilio:ConnectionConfig twilioConfig = {
    auth: {
        accountSId,
        authToken
    }
};

twilio:Client twilio = new (twilioConfig);
```

### Step 3 - Invoke  connector operation

1. Invoke the connector operation using the client as follows:

```ballerina
public function main() returns error? {
    twilio:Account response = check twilio->getAccountDetails();
}
```

2. Use `bal run` command to compile and run the Ballerina program.

**[You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/twilio/samples)**
