# Make a call using Twilio

This example demonstrates how to make a call using Twilio connector.

## Prerequisites

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

### Step 3: Obtain a Twilio account Sid with auth token

Twilio uses two credentials to determine which account an API request is coming from: The account Sid, which acts as a `username`, and the Auth Token which acts as a `password`. You can find your account Sid and auth token in your [Twilio console](https://www.twilio.com/console).

![Twilio Credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/get-credentails.png)

Your account's Auth Token is hidden by default. Click show to display the token, and hide to conceal it again. For further information click [here](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them)

## Quickstart

### Configuration

Configure Twilio API credentials in Config.toml in the example directory:

```toml
accountSid="<Account Sid>"
authToken="<Auth Token>"
```

To use the `twilio` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1 - Import the module

Import the Twilio module into your Ballerina program as shown below:

```ballerina
import ballerinax/twilio;
```

### Step 2 - Create a new connector instance

To create a new connector instance, add a configuration as follows (You can use [configurable variables](https://ballerina.io/learn/by-example/configurable.html) to provide the necessary credentials):

```ballerina
configurable string accountSid = ?;
configurable string authToken = ?;

twilio:ConnectionConfig twilioConfig = {
    auth: {
        accountSid,
        authToken
    }
};

twilio:Client twilio = check new (twilioConfig);
```

### Step 3 - Invoke the connector operation

Invoke the sending SMS operation using the client as shown below:

```ballerina
public function main() returns error? {
    twilio:Client twilio = check new (twilioConfig);

    twilio:CreateCallRequest callRequest = {
        To: "+XXXXXXXXXXX",
        From: "+XXXXXXXXXXX",
        Url: "http://demo.twilio.com/docs/voice.xml"
    };

    twilio:Call response = check twilio->createCall(callRequest);
    io:println("Call Status: ",response?.status);
}
```

## Run the Example

Execute the following command to run the example:

```bash
bal run
```