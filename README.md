# Ballerina Twilio Endpoint

[Twilio](https://www.twilio.com/) is a cloud communications platform for building SMS, Voice & Messaging applications on 
an API built for global scale.

### Why would you use a Ballerina endpoint for Twilio

Ballerina Twilio endpoint allows you to access the [Twilio REST API](https://www.twilio.com/docs/api) and perform 
actions like sending a simple text message, making a voice call etc.

## Compatibility

| Language Version           | Endpoint Version    | Twilio Basic API Version | Twilio Authy API Version |
| -------------------------- | ------------------- | ------------------------ | ------------------------ |
| 0.970.0-beta1-SNAPSHOT     | 0.8.0               | 2010-04-01               | v1                       |

##### Prerequisites

1. Download the ballerina [distribution](https://ballerinalang.org/downloads/).

2. Create a Twilio account (https://www.twilio.com/) and obtain the following parameters:
* ACCOUNT SID
* AUTH TOKEN

3. Create a Twilio Authy app withing Twilio account (https://www.twilio.com/console/authy/applications) and obtain the
following parameters:
* PRODUCTION API KEY

IMPORTANT: These tokens can be used to make API requests on your own account's behalf. Do not share these credentials.

### Getting started

* Import the package to your ballerina project.
```
import wso2/twilio;
```
This will download the twilio artifacts from the central repository to your local repository.

### Working with Twilio Endpoint Actions

All the actions return `twilio:<Custom_Object>` or `twilio:TwilioError`. If the action was a success, then the 
requested object will be returned while the `twilio:TwilioError` will be **empty** and vice-versa.

##### Example
* Request 
```
    import wso2/twilio;

    public function main (string[] args) {
        endpoint twilio:Client twilioClient {
             accountSid:config:getAsString(ACCOUNT_SID),
             authToken:config:getAsString(AUTH_TOKEN),
             xAuthyKey:config:getAsString(AUTHY_API_KEY)
        };
    
        var details = twilioClient -> getAccountDetails();
        match details {
            Account account => {
                io:println(account);
                test:assertNotEquals(account.sid, EMPTY_STRING, msg = "Failed to get account details");
            }
            TwilioError twilioError => test:assertFail(msg = twilioError.message);
        }
    }
    
```

* Account object
```
public type Account {
    string sid;
    string name;
    string status;
    string ^"type";
    string createdDate;
    string updatedDate;
};
```

### References

> Visit the [package-twilio](https://github.com/wso2-ballerina/package-twilio) repository for the source code.
> Visit the [test.bal](https://github.com/wso2-ballerina/package-twilio/blob/master/twilio/tests/test.bal) file
for the sample test cases.
