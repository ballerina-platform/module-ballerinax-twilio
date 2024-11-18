## Overview

Twilio is a cloud communications platform that allows software developers to programmatically make and receive phone calls, send and receive text messages, and perform other communication functions using its web service APIs. 

The Ballerina Twilio connector supports the [Twilio Basic API version 2010-04-01](https://www.twilio.com/docs/iam/api), enabling users to leverage these communication capabilities within their Ballerina applications.

## Setup guide

Before using the ballerinax-twilio connector you must have access to Twilio API, If you do not have access to Twilio API please complete the following steps:

### Step 1: Create a Twilio account

Creating a Twilio account can be done by visiting [Twilio](https://www.twilio.com) and clicking the "Try Twilio for Free" button.

### Step 2: Obtain a Twilio phone number

All trial projects can provision a free trial phone number for testing. Here's how to get started.

> **Notice:** Trial project phone number selection may be limited. You must upgrade your Twilio project to provision more than one phone number, or to provision a number that is not available to trial projects.

1. Access the Buy a Number page in the Console.

![Get Phone Number](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/get-phone-number.png)

2. Enter the criteria for the phone number you need, and then click Search.

![Configure Phone Number](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/phone-number-config.png)

- Country: Select the desired country from the drop-down menu.
- Number or Location: Select the desired option to search by digits/phrases, or a specific City or Region.
- Capabilities: Select your service needs for this number. 

3. Click Buy to purchase a phone number for your current project or sub-account.

![Search Results](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/search-phone-number.png)
> **Notice:** Many countries require identity documentation for Phone Number compliance. Requests to provision phone numbers with these regulations will be required to select or add the required documentation after clicking Buy in Console. To see which countries and phone number types are affected by these requirements, please see twilio's [Phone Number Regulations](https://www.twilio.com/guidelines/regulatory) site.

### Step 3: Obtain a Twilio API Key, API Secret with Account SID

You can find API Keys related information under [API keys & tokens](https://console.twilio.com/us1/account/keys-credentials/api-keys) section in your Twilio account. If you do not have an API Key and a Secret, please complete the following steps:

1. Access the [API keys & tokens](https://console.twilio.com/us1/account/keys-credentials/api-keys) page in your Twilio account, and then click on <b>Create API key</b>.

![Twilio API Key](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/api-key-config.png)

2. Enter the criteria for the API Key you need, and then click <b>Create</b>.

![Create API Key](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/create-api-key.png)

- <b>Friendly name:</b> Enter a human-readable name for your API key. It helps you identify the key later, especially if you have multiple API keys.
- <b>Region:</b> Enter the geographical region where the API key will be used.
- <b>Key type:</b> There are different types of API keys you can create,
    - <b>Standard:</b> Provides access to all Twilio API functionalities except for managing API keys and configuring accounts and subaccounts.
    - <b>Main:</b> Offers the same access as standard keys but also allows managing API keys and configuring accounts and subaccounts.
    - <b>Restricted:</b> Allows fine-grained access to specific Twilio API resources, enabling you to set permissions for different API endpoints

3. Save the API key SID and the Secret in a safe place to use in your application.

![API Key Info](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/api-key-info.png)

> **Important:** This secret is only shown once. Please make note of it and store it in a safe and a secure location.

4. In order to obtain the Account SID of your Twilio account, you can visit your [Twilio console](https://www.twilio.com/console).

![Twilio Credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/get-credentails.png)

## Quickstart

To use the `twilio` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1 - Import the module

Import the Twilio module into your Ballerina program as shown below:

```ballerina
import ballerinax/twilio;
```

### Step 2 - Create a new connector instance

To create a new connector instance, add a configuration as follows (You can use [configurable variables](https://ballerina.io/learn/by-example/configurable.html) to provide the necessary credentials):

```ballerina
configurable string apiKey = ?;
configurable string apiSecret = ?;
configurable string accountSid = ?;

twilio:ConnectionConfig twilioConfig = {
    auth: {
        apiKey,
        apiSecret,
        accountSid
    }
};

twilio:Client twilio = check new (twilioConfig);
```

### Step 3 - Invoke the connector operation

Invoke the sending SMS operation using the client as shown below:

```ballerina
public function main() returns error? {
    twilio:CreateMessageRequest messageRequest = {
        To: "+XXXXXXXXXXX", // Phone number that you want to send the message to
        From: "+XXXXXXXXXXX", // Twilio phone number
        Body: "Hello from Ballerina"
    };

    twilio:Message response = check twilio->createMessage(messageRequest);

    // Print the status of the message from the response
    io:println("Message Status: ", response?.status);
}
```

### Step 4: Run the Ballerina application

Execute the command below to execute the Ballerina application:

```bash
bal run
```

## Examples

The Twilio connector comes equipped with examples that demonstrate its usage across various scenarios. These examples are conveniently organized into three distinct groups based on the functionalities they showcase. For a more hands-on experience and a deeper understanding of these capabilities, we encourage you to experiment with the provided examples in your development environment.

1. Account management
    - [Create a sub-account](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/create-sub-account) - Create a subaccount under a Twilio account
    - [Fetch an account](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/fetch-account) - Get details of a Twilio account
    - [Fetch balance](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/fetch-balance) - Get the balance of a Twilio account
    - [List accounts](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/list-accounts) - List all subaccounts under a Twilio account
    - [Update an account](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/update-account) - Update the name of a Twilio account
2. Call management
    - [Make a call](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/create-call) - Make a call to a phone number via a Twilio
    - [Fetch call log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/fetch-call-log) - Get details of a call made via a Twilio
    - [List call logs](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/list-call-logs) - Get details of all calls made via a Twilio
    - [Delete a call log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/delete-call-log) - Delete the log of a call made via Twilio
3. Message management
    - [Send an SMS message](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/create-sms-message) - Send an SMS to a phone number via a Twilio 
    - [Send a Whatsapp message](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/create-whatsapp-message) - Send a Whatsapp message to a phone number via a Twilio
    - [List message logs](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/list-message-logs) - Get details of all messages sent via a Twilio
    - [Fetch a message log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/fetch-message-log) - Get details of a message sent via a Twilio
    - [Delete a message log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/delete-message-log) - Delete a message log via a Twilio