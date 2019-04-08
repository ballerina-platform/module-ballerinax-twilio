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
import ballerina/mime;

# Object for Twilio endpoint.
# + accountSId - Unique identifier of the account
# + xAuthyKey - Unique identifier of Authy API account
# + basicClient - HTTP client endpoint for basic api
# + authyClient - HTTP client endpoint for authy api
public type Client client object {

    public string accountSId;
    public string xAuthyKey;
    public http:Client basicClient;
    public http:Client authyClient;

    public function __init(TwilioConfiguration twilioConfig) {
        self.init(twilioConfig);
        self.basicClient = new(TWILIO_API_BASE_URL, config = twilioConfig.basicClientConfig);
        self.authyClient = new(AUTHY_API_BASE_URL, config = twilioConfig.authyClientConfig);
        self.accountSId = twilioConfig.accountSId;
        self.xAuthyKey = twilioConfig.xAuthyKey;
    }

    # Initialize Twilio endpoint.
    # + twilioConfig - Twilio configuraion
    public function init(TwilioConfiguration twilioConfig);

    # Return account details of the given account-sid.
    # + return - If success, returns account object with basic details, else returns error
    public remote function getAccountDetails() returns Account|error;

    # Send SMS from the given account-sid.
    # + fromNo - Mobile number which the SMS should be send from
    # + toNo - Mobile number which the SMS should be received to
    # + message - Message body of the SMS
    # + return - If success, returns SMS response object with basic details, else returns error
    public remote function sendSms(string fromNo, string toNo, string message) returns SmsResponse|error;

    # Make a voice call from the given account-sid.
    # + fromNo - Mobile number which the voice call should be send from
    # + toNo - Mobile number which the voice call should be received to
    # + twiml - TwiML URL which the response of the voice call is stated
    # + return - If success, returns voice call response object with basic details, else returns error
    public remote function makeVoiceCall(string fromNo, string toNo, string twiml) returns VoiceCallResponse|error;

    # Get the Authy app details.
    # + return - If success, returns Authy app response object with basic details, else returns error
    public remote function getAuthyAppDetails() returns AuthyAppDetailsResponse|error;

    # Add an user for Authy app.
    # + email - Email of the new user
    # + phone - Phone number of the new user
    # + countryCode - Country code of the new user
    # + return - If success, returns Authy user add response object with basic details, else returns error
    public remote function addAuthyUser(string email, string phone, string countryCode) returns AuthyUserAddResponse|
                error;

    # Get the user details of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user status response object with basic details, else returns error
    public remote function getAuthyUserStatus(string userId) returns AuthyUserStatusResponse|error;

    # Delete the user of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user delete response object with basic details, else returns error
    public remote function deleteAuthyUser(string userId) returns AuthyUserDeleteResponse|error;

    # Get the user secret of Authy user for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user secret response object with basic details, else returns error
    public remote function getAuthyUserSecret(string userId) returns AuthyUserSecretResponse|error;

    # Request OTP for the user of Authy via SMS for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error
    public remote function requestOtpViaSms(string userId) returns AuthyOtpResponse|error;

    # Request OTP for the user of Authy via call for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error
    public remote function requestOtpViaCall(string userId) returns AuthyOtpResponse|error;

    # Verify OTP for the user of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + token - The OTP token to be verified
    # + return - If success, returns Authy OTP verify response object with basic details, else returns error
    public remote function verifyOtp(string userId, string token) returns AuthyOtpVerifyResponse|error;

};

public remote function Client.getAccountDetails() returns Account|error {
    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + ACCOUNT_DETAILS;
    var response = self.basicClient->get(requestPath);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAccount(jsonResponse);
}

public remote function Client.sendSms(string fromNo, string toNo, string message) returns SmsResponse|error {
    http:Request req = new;

    string requestBody = "";
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
    req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + SMS_SEND;
    var response = self.basicClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToSmsResponse(jsonResponse);
}

public remote function Client.makeVoiceCall(string fromNo, string toNo, string twiml)
                                     returns VoiceCallResponse|error {

    http:Request req = new;

    string requestBody = "";
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, URL, twiml);
    req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + VOICE_CALL;
    var response = self.basicClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToVoiceCallResponse(jsonResponse);
}

public remote function Client.getAuthyAppDetails() returns AuthyAppDetailsResponse|error {

    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_APP_API;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyAppDetailsResponse(jsonResponse);
}

public remote function Client.addAuthyUser(string email, string phone, string countryCode)
                                     returns AuthyUserAddResponse|error {

    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);

    string requestBody = "";
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[email]", email);
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[cellphone]", phone);
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[country_code]", countryCode);
    req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

    string requestPath = AUTHY_USER_API + USER_ADD;
    var response = self.authyClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserAddRespones(jsonResponse);
}

public remote function Client.getAuthyUserStatus(string userId) returns AuthyUserStatusResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_STATUS;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserStatusResponse(jsonResponse);
}

public remote function Client.deleteAuthyUser(string userId) returns AuthyUserDeleteResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_REMOVE;
    var response = self.authyClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserDeleteResponse(jsonResponse);
}

public remote function Client.getAuthyUserSecret(string userId) returns AuthyUserSecretResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_SECRET;
    var response = self.authyClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserSecretResponse(jsonResponse);
}

public remote function Client.requestOtpViaSms(string userId) returns AuthyOtpResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_SMS_API + FORWARD_SLASH + userId;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

public remote function Client.requestOtpViaCall(string userId) returns AuthyOtpResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_CALL_API + FORWARD_SLASH + userId;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

public remote function Client.verifyOtp(string userId, string token) returns AuthyOtpVerifyResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_VERIFY_API + FORWARD_SLASH + token + FORWARD_SLASH + userId;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpVerifyResponse(jsonResponse);
}

# Twilio Configuration.
# + accountSId - Unique identifier of the account
# + authToken - The authentication token of the account
# + xAuthyKey - The authentication token for the Authy API
# + basicClientConfig - The HTTP client endpoint for basic configuration
# + authyClientConfig - The HTTP client endpoint for Authy configuration
public type TwilioConfiguration record {
    string accountSId;
    string authToken;
    string xAuthyKey = "";
    http:ClientEndpointConfig basicClientConfig = {};
    http:ClientEndpointConfig authyClientConfig = {};
};

public function Client.init(TwilioConfiguration twilioConfig) {
    http:AuthConfig authConfig = {
        scheme: http:BASIC_AUTH,
        config: {
            username: twilioConfig.accountSId,
            password: twilioConfig.authToken
        }
    };
    twilioConfig.basicClientConfig.auth = authConfig;
}
