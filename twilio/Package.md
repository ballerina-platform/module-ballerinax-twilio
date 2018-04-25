Connects to Twilio from Ballerina. 

# Package Overview

This package provides a Ballerina API for the Twilio REST API. It provides the ability to send SMS, make voice calls, 
send OTP via SMS or call, verify OTP, etc.

**Basic Operations**

The `wso2/twilio` package contains operations to get the Twilio account details, send SMS, and make voice calls.

**Authy Operations**

The `wso2/twilio` package contains operations to get Authy app details, add a user, delete a user, get user status, get 
user secret, request OTP via SMS, request OTP via call, and verify OTP.

## Compatibility
|                    |    Version     |  
| :-----------------:|:--------------:| 
| Ballerina Language | 0.970.0-beta15 |
| Twilio Basic API  |    v1         |  

## Sample
The Twilio connector can be used to send SMS, add a user for Authy, and request OTP via SMS. First, import the 
`wso2/twilio` package into the Ballerina project.
```ballerina
import wso2/twilio;
```
Instantiate the connector by giving authentication details in the HTTP client config, which has built-in support for 
BasicAuth and OAuth 2.0. Gmail uses OAuth 2.0 to authenticate and authorize requests. The Gmail connector can be 
minimally instantiated in the HTTP client config using the access token or using the client ID, client secret, 
and refresh token.

**Obtaining Tokens to Run the Sample**

1. Visit [Twilio](https://www.twilio.com/) and create a Twilio Account.
2. Obtain the following credentials from the Twilio dashboard:
    * Account SId
    * Auth Token
    * X Authy API Secret

You can now enter the credentials in the Twilio endpoint configuration.
```ballerina
endpoint twilio:Client twilioEP {
    accountSId:accountSId,
    authToken:authToken,
    xAuthyKey:xAuthyKey
};
```
The `sendSMS` function sends an SMS to a given mobile number from another given mobile number using the specified message.
```ballerina
var details = twilioClient->sendSms(fromMobile, toMobile, message);
match details {
    SmsResponse smsResponse => io:println(smsResponse);
    TwilioError twilioError => io:println(twilioError);
}
```
The `addAuthyUser` function adds an Authy user with the given email address, phone number, and country code.
```ballerina
var details = twilioClient->addAuthyUser(email, phone, countryCode);
match details {
    AuthyUserAddResponse authyUserAddResponse => io:println(authyUserAddResponse);
    TwilioError twilioError => io:println(twilioError);
}
```
The `requestOtpViaSms` function sends an OTP SMS to the mobile number of the given user ID.
```ballerina
var details = twilioClient->requestOtpViaSms(userId);
match details {
    AuthyOtpResponse authyOtpResponse => io:println(authyOtpResponse);
    TwilioError twilioError => io:println(twilioError);
}
```