# Twilio Connector

Twilio connector provides a Ballerina API to access the [Twilio REST API](https://www.twilio.com/docs/api).

## Compatibility

| Ballerina Language Version                   | Twilio API Version |
| :-------------------------------------------:|:------------------:|
| 0.970.0-beta2                                | 0.8.0              |

## Getting started

1.  Refer https://ballerina.io/learn/getting-started/ to download and install Ballerina.
2.  To use Twilio endpoint, you need to provide the following:

       - Account SId
       - Auth Token
       - Authy API Key

       *Please note that, providing Authy API Key is required only if you are going to use Authy related APIs*

4. Create a new Ballerina project by executing the following command.

      ``<PROJECT_ROOT_DIRECTORY>$ ballerina init``

5. Import the Twilio package to your Ballerina program as follows.

```ballerina
    import wso2/twilio;

    function main (string... args) {
        endpoint twilio:Client twilioClient {
             accountSid:config:getAsString(ACCOUNT_SID),
             authToken:config:getAsString(AUTH_TOKEN),
             xAuthyKey:config:getAsString(AUTHY_API_KEY)
        };

        var details = twilioClient -> getAccountDetails();
        match details {
            Account account => io:println(account);
            TwilioError twilioError => test:assertFail(msg = twilioError.message);
        }
    }
```