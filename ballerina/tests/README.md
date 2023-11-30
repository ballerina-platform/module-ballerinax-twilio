## Prerequisites for Running Tests

To run the tests, you need Twilio account credentials,twilio phone number and test phone number. To get Twilio account credentials and twilio phone number;

1. Create a [Twilio account](https://www.twilio.com/).

2. Obtain a [Twilio phone number](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-).

    > **Tip:** If you are using a trial account, you may need to verify your recipients' phone numbers before initiating any communication with them.

3. Obtain a [Twilio Account Auth Token](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them).


Now,You can set twilio credentials and phone number either in a `Config.toml` file in the tests directory or as environment variables.

#### Using a Config.toml File

Create a `Config.toml` file in the tests directory and add your authentication credentials and phone-number for the authorized user:

```toml
accountSid="<your-twilio-account-sid>"
authToken="<your-twilio-auth-token>"
toPhoneNumber="<your-test-phone-number>"
fromPhoneNumber="<your-twilio-phone-number>"
```

#### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables:
```bash
export ACCOUNT_SID="<your-twilio-account-sid>"
export AUTH_TOKEN="<your-twilio-auth-token>"
export TO_PHONE="<your-test-phone-number>"
export TWILIO_PHONE="<your-twilio-phone-number>"
```