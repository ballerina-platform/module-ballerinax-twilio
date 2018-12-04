// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# Object for Twilio endpoint.
# + twilioConnector - Reference to TwilioConnector type
public type Client client object {

    public TwilioConnector twilioConnector;

    public function __init(TwilioConfiguration twilioConfig) {
        self.twilioConnector = new(twilioConfig);
    }

    # Initialize Twilio endpoint.
    # + twilioConfig - Twilio configuraion
    public function init(TwilioConfiguration twilioConfig);

    # Return account details of the given account-sid.
    # + return - If success, returns account object with basic details, else returns error
    public remote function getAccountDetails() returns Account|error {
        return self.twilioConnector->getAccountDetails();
    }

    # Send SMS from the given account-sid.
    # + fromNo - Mobile number which the SMS should be send from
    # + toNo - Mobile number which the SMS should be received to
    # + message - Message body of the SMS
    # + return - If success, returns SMS response object with basic details, else returns error
    public remote function sendSms(string fromNo, string toNo, string message) returns SmsResponse|error {
        return self.twilioConnector->sendSms(fromNo, toNo, message);
    }

    # Make a voice call from the given account-sid.
    # + fromNo - Mobile number which the voice call should be send from
    # + toNo - Mobile number which the voice call should be received to
    # + twiml - TwiML URL which the response of the voice call is stated
    # + return - If success, returns voice call response object with basic details, else returns error
    public remote function makeVoiceCall(string fromNo, string toNo, string twiml) returns VoiceCallResponse|error {
        return self.twilioConnector->makeVoiceCall(fromNo, toNo, twiml);
    }

    # Get the Authy app details.
    # + return - If success, returns Authy app response object with basic details, else returns error
    public remote function getAuthyAppDetails() returns AuthyAppDetailsResponse|error {
        return self.twilioConnector->getAuthyAppDetails();
    }

    # Add an user for Authy app.
    # + email - Email of the new user
    # + phone - Phone number of the new user
    # + countryCode - Country code of the new user
    # + return - If success, returns Authy user add response object with basic details, else returns error
    public remote function addAuthyUser(string email, string phone, string countryCode) returns AuthyUserAddResponse|
                error {
        return self.twilioConnector->addAuthyUser(email, phone, countryCode);
    }

    # Get the user details of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user status response object with basic details, else returns error
    public remote function getAuthyUserStatus(string userId) returns AuthyUserStatusResponse|error {
        return self.twilioConnector->getAuthyUserStatus(userId);
    }

    # Delete the user of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user delete response object with basic details, else returns error
    public remote function deleteAuthyUser(string userId) returns AuthyUserDeleteResponse|error {
        return self.twilioConnector->deleteAuthyUser(userId);
    }

    # Get the user secret of Authy user for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user secret response object with basic details, else returns error
    public remote function getAuthyUserSecret(string userId) returns AuthyUserSecretResponse|error {
        return self.twilioConnector->getAuthyUserSecret(userId);
    }

    # Request OTP for the user of Authy via SMS for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error
    public remote function requestOtpViaSms(string userId) returns AuthyOtpResponse|error {
        return self.twilioConnector->requestOtpViaSms(userId);
    }

    # Request OTP for the user of Authy via call for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error
    public remote function requestOtpViaCall(string userId) returns AuthyOtpResponse|error {
        return self.twilioConnector->requestOtpViaCall(userId);
    }

    # Verify OTP for the user of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + token - The OTP token to be verified
    # + return - If success, returns Authy OTP verify response object with basic details, else returns error
    public remote function verifyOtp(string userId, string token) returns AuthyOtpVerifyResponse|error {
        return self.twilioConnector->verifyOtp(userId, token);
    }

};

# Twilio Configuration.
# + accountSId - Unique identifier of the account
# + authToken - The authentication token of the account
# + xAuthyKey - The authentication token for the Authy API
# + basicClientConfig - The HTTP client endpoint for basic configuration
# + authyClientConfig - The HTTP client endpoint for Authy configuration
public type TwilioConfiguration record {
    string accountSId;
    string authToken;
    string xAuthyKey;
    http:ClientEndpointConfig basicClientConfig = {};
    http:ClientEndpointConfig authyClientConfig = {};
};

function Client.init(TwilioConfiguration twilioConfig) {
    http:AuthConfig authConfig = {
                            scheme: http:BASIC_AUTH,
                            username: twilioConfig.accountSId,
                            password: twilioConfig.authToken
    };
    twilioConfig.basicClientConfig.auth = authConfig;
}
