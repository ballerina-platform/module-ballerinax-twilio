# Running Tests

There are two test environments for the Twilio connector. The default test environment is the mock server for Twilio API. The other test environment is the actual Twilio API. You can run the tests in either of these environments and each has its own compatible set of tests.

Test Groups | Environment
---| ---
mock_tests | Mock server for Twilio API (Defualt Environment)
live_tests | Twilio API

## Running Tests in the Mock Server

To execute the tests on the mock server, ensure that the `IS_TEST_ON_LIVE_SERVER` environment variable is either set to false or unset before initiating the tests. This environment variable can be configured within the `Config.toml` file located in the tests directory or specified as an environmental variable.

#### Using a Config.toml File

Create a `Config.toml` file in the tests directory and add your authentication credentials and phone number for the authorized user:

```toml
isTestOnLiveServer = false
```

#### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables:
```bash
export IS_TEST_ON_LIVE_SERVER=false
```

Then, run the following command to run the tests:
```bash
   ./gradlew clean test
```

## Running Tests Against Twilio API

### Prerequisites

To run the tests, you need Twilio account credentials, a Twilio phone number and a test phone number. To get Twilio account credentials and Twilio phone number;

1. Create a [Twilio account](https://www.twilio.com/).

2. Obtain a [Twilio phone number](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-).

    > **Tip:** If you are using a trial account, you may need to verify your recipients' phone numbers before initiating any communication with them.

3. Obtain a [Twilio Account Auth Token](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them).

Now, you can set Twilio credentials and phone numbers either in a `Config.toml` file in the tests directory or as environment variables.

#### Using a Config.toml File

Create a `Config.toml` file in the tests directory and add your authentication credentials and phone number for the authorized user:

```toml
isTestOnLiveServer = true
accountSid="<your-twilio-account-sid>"
authToken="<your-twilio-auth-token>"
toPhoneNumber="<your-test-phone-number>"
fromPhoneNumber="<your-twilio-phone-number>"
```

#### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables:
```bash
export IS_TEST_ON_LIVE_SERVER=true
export ACCOUNT_SID="<your-twilio-account-sid>"
export AUTH_TOKEN="<your-twilio-auth-token>"
export TO_PHONE="<your-test-phone-number>"
export TWILIO_PHONE="<your-twilio-phone-number>"
```

Then, run the following command to run the tests:
```bash
   ./gradlew clean test -Pgroups="live_tests"
```
