# Ballerina Gmail Connector
 
[![Build](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio.svg?branch=master)](https://travis-ci.org/ballerina-platform/module-ballerinax-twilio)
[![codecov](https://codecov.io/gh/ballerina-platform/module-ballerinax-twilio/branch/master/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerinax-twilio)
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/ballerina-platform/module-ballerinax-twilio?color=green&include_prereleases&label=latest%20release)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/build-with-bal-test-native.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/build-with-bal-test-native.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Overview
Twilio connect the software layer and communication networks worldwide, enabling users to call and message anyone globally.
The `ballerinax/twilio` connector provides the capability to access twilio platform via ballerina.

This connector supports [Twilio Basic API version 2010-04-01](https://www.twilio.com/docs/all).

## Prerequisites

Before using this connector in your Ballerina application, please complete the following steps:

1. Create a [Twilio account](https://www.twilio.com/).

2. Obtain a [Twilio phone number](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-).

    > **Tip:** If you are using a trial account, you may need to verify your recipients' phone numbers before initiating any communication with them.

3. Obtain a [Twilio Account Auth Token](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them).

4. Configure the connector with the obtained tokens.

## Quickstart

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

## Examples

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

5. To debug package with a remote debugger:
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

* For more information go to the [`googleapis.gmail` package](https://central.ballerina.io/ballerinax/twilio/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.