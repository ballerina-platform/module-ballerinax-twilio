Connects to Twilio from Ballerina. 

# Module Overview

The Twilio connector allows you to send SMS, voice, OTP, and WhatsApp messages through the Twilio REST API. You can also send user secrets via SMS or voice message, verify OTP, and add and delete users. It handles basic authentication.

WhatsApp messaging requires users to use predefined [message templates](https://www.twilio.com/docs/sms/whatsapp/tutorial/send-whatsapp-notification-messages-templates). Templates are message formats, which can be used over and over again to message users. Use of templates enables to maintain high-quality content as well as to avoid spam messages. However, this requires the WhatsApp message templates to be predefined.

**Basic Operations**

The `ballerinax/twilio` module contains operations to get the Twilio account details, send SMS, send WhatsApp messages, and make voice calls.

**Authy Operations**

The `ballerinax/twilio` module contains operations to get Authy app details, add a user, delete a user, get user status, get user secret, request OTP via SMS, request OTP via call, and verify OTP.

## Compatibility

|                          |    Version         |
|:------------------------:|:------------------:|
| Ballerina Language       | Swan Lake Preview7 |
| Twilio Basic API         | 2010-04-01         |
| Twilio Authy API Version | v1                 |

## Sample
First, import the `ballerinax/twilio` module into the Ballerina project.
```ballerina
import ballerinax/twilio;
```

**Obtaining Tokens to Run the Sample**

1. Visit [Twilio](https://www.twilio.com/) and create a Twilio Account.
2. Obtain the following credentials from the Twilio dashboard:
    * Account SId
    * Auth Token
    * X Authy API Secret

You can now enter the credentials in the Twilio endpoint configuration.
```ballerina
twilio:TwilioConfiguration twilioConfig = {
    accountSId: config:getAsString("ACCOUNT_SID"),
    authToken: config:getAsString("AUTH_TOKEN"),
    xAuthyKey: config:getAsString("AUTHY_API_KEY")
};

twilio:Client twilioClient = new(twilioConfig);
```

The `sendSMS` remote function sends an SMS to a given mobile number from another given mobile number with the specified message.
```ballerina
var details = twilioClient->sendSms(fromMobile, toMobile, message);
if (details is  twilio:SmsResponse) {
    // If successful, print SMS Details.
    io:println("SMS Details: ", details);
} else {
    // If unsuccessful, print the error returned.
    io:println("Error: ", details);
}
```

The `addAuthyUser` remote function adds an Authy user with the given email address, phone number, and country code.
```ballerina
var details = twilioClient->addAuthyUser(email, phone, countryCode);
if (details is  twilio:AuthyUserAddResponse) {
    // If successful, print Authy user Details.
    io:println("Authy user Details: ", details);
} else {
    // If unsuccessful, print the error returned.
    io:println("Error: ", details);
}
```

The `requestOtpViaSms` remote function sends an OTP SMS to the mobile number of the given user ID.
```ballerina
var details = twilioClient->requestOtpViaSms(userId);
if (details is  twilio:AuthyOtpResponse) {
    // If successful, print OTP SMS Details.
    io:println("OTP SMS Details: ", details);
} else {
    // If unsuccessful, print the error returned.
    io:println("Error: ", details);
}
```
