# Ballerina Twilio Endpoint

[Twilio](https://www.twilio.com/) is a cloud communications platform for building SMS, Voice & Messaging applications on 
an API built for global scale.

### Why would you use a Ballerina endpoint for Twilio

Ballerina Twilio endpoint allows you to access the [Twilio REST API](https://www.twilio.com/docs/api) and perform 
actions like sending a simple text message, making a voice call etc.

## Compatibility

| Language Version           | Endpoint Version    | Twilio Basic API Version | Twilio Authy API Version |
| -------------------------- | ------------------- | ------------------------ | ------------------------ |
| 0.970.0-beta1-SNAPSHOT     | 0.5.8               | 2010-04-01               | v1                       |

### Getting started

* Clone the repository by running the following command
```
git clone https://github.com/wso2-ballerina/package-twilio
```
* Import the package to your ballerina project.

##### Prerequisites

1. Download the ballerina [distribution](https://ballerinalang.org/downloads/).

2. Create a Twilio account (https://www.twilio.com/) and obtain the following parameters:
* ACCOUNT SID
* AUTH TOKEN

3. Create a Twilio Authy app withing Twilio account (https://www.twilio.com/console/authy/applications) and obtain the
following parameters:
* PRODUCTION API KEY

IMPORTANT: This access token and refresh token can be used to make API requests on your own account's behalf. Do not share these credentials.