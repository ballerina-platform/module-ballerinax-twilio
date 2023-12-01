# Ballerina Twilio Connector
 
[![Build](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/trivy-scan.yml)
[![codecov](https://codecov.io/gh/ballerina-platform/module-ballerinax-twilio/branch/master/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerinax-twilio)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/build-with-bal-test-native.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/build-with-bal-test-native.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-twilio.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/twilio.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module/twilio)

## Overview

Twilio is a cloud communications platform that allows software developers to programmatically make and receive phone calls, send and receive text messages, and perform other communication functions using its web service APIs. 

The Ballerina Twilio connector supports the [Twilio Basic API version 2010-04-01](https://www.twilio.com/docs/all), enabling users to leverage these communication capabilities within their Ballerina applications.

## Setting up the Twilio
Before using the ballerinax-twilio connector you must have access to Twilio API, If you do not have access to Twilio API please complete the following steps:

### Step 1: Create a Twilio account.
Creating a Twilio account can be done by visiting [Twilio](https://www.twilio.com) and clicking the "Try Twilio for Free" button.

### Step 2: Obtain a Twilio phone number.

All trial projects can provision a free trial phone number for testing. Here's how to get started.

`Notice: Trial project phone number selection may be limited. You must upgrade your Twilio project to provision more than one phone number, or to provision a number that is not available to trial projects`.

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

### Step 3: Obtain a Twilio Account SID with Auth Token.
Twilio uses two credentials to determine which account an API request is coming from: The Account SID, which acts as a `username`, and the Auth Token which acts as a `password`. You can find your account SID and auth token in your [Twilio console](https://www.twilio.com/console).

![Twilio Credentails](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/get-credentails.png)

Your account's Auth Token is hidden by default. Click show to display the token, and hide to conceal it again. For further information click [here](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them)

## Sample

This sample demonstrates a scenario where the Twilio connector is used to send a text message to a phone number.

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
    twilio:Client twilio = check new (twilioConfig);

    twilio:CreateMessageRequest messageRequest = {
        To: "+XXXXXXXXXXX",
        From: "+XXXXXXXXXXX",
        Body: "Hello from Ballerina"
    };

    twilio:Message response = check twilio->createMessage(accountSID, messageRequest);
    
    io:println("Message Status: ", response?.status);
}
```

2. Use `bal run` command to compile and run the Ballerina program.

**[You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples)**

## Issues and projects 

The **Issues** and **Projects** tabs are disabled for this repository as this is part of the Ballerina library. To report bugs, request new features, start new discussions, view project boards, etc., visit the Ballerina library [parent repository](https://github.com/ballerina-platform/ballerina-library). 

This repository only contains the source code for the package.
 
## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

   * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
   * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

### Build options

Execute the commands below to build from the source.

1. To build the package:
   ```
   ./gradlew clean build
   ```

2. To run the tests:
   ```
   ./gradlew clean test
   ```

3. To build the without the tests:
   ```
   ./gradlew clean build -x test
   ```

5. To debug the package with a remote debugger:
   ```
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:
   ```
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:
    ```
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:
   ```
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`twilio` package](https://central.ballerina.io/ballerinax/twilio/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.