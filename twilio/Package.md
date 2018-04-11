# Ballerina Twilio Connector

[Twilio](https://www.twilio.com/) is a cloud communications platform for building SMS, Voice & Messaging applications on 
an API built for global scale.

### Why would you use a Ballerina connector for Twilio

Ballerina Twilio connector allows you to access the [Twilio REST API](https://www.twilio.com/docs/api) and perform 
actions like sending a simple text message, making a voice call etc.

## Compatibility

| Language Version           | Connector Version   | Twilio API Version |
| -------------------------- | ------------------- | ------------------ |
| 0.970.0-alpha4             | 0.5.5               | 2010-04-01         |

### Getting started

* Clone the repository by running the following command
```
git clone https://github.com/wso2-ballerina/package-twilio
```
* Import the package to your ballerina project.

##### Prerequisites

1. Download the ballerina [distribution](https://ballerinalang.org/downloads/).

2. Create a Twilio account (https://www.twilio.com/) and obtain the following parameters:
* Account  SId
* Auth Token

IMPORTANT: This access token and refresh token can be used to make API requests on your own account's behalf. Do not share these credentials.