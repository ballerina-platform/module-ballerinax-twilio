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

# Object to initialize the connection with Twilio.
# + accountSId - Unique identifier of the account
# + xAuthyKey - Unique identifier of Authy API account
# + basicClient - HTTP client endpoint for basic api
# + authyClient - HTTP client endpoint for authy api
public type TwilioConnector object {

    public string accountSId;
    public string xAuthyKey;
    public http:Client basicClient;
    public http:Client authyClient;

    # Return account details of the given account-sid.
    # + return - If success, returns account object with basic details, else returns error object
    public function getAccountDetails() returns (Account|error);

    # Send SMS from the given account-sid.
    # + fromNo - Mobile number which the SMS should be send from
    # + toNo - Mobile number which the SMS should be received to
    # + message - Message body of the SMS
    # + return - If success, returns SMS response object with basic details, else returns error object
    public function sendSms(string fromNo, string toNo, string message) returns (SmsResponse|error);

    # Make a voice call from the given account-sid.
    # + fromNo - Mobile number which the voice call should be send from
    # + toNo - Mobile number which the voice call should be received to
    # + twiml - TwiML URL which the response of the voice call is stated
    # + return - If success, returns voice call response object with basic details, else returns error object
    public function makeVoiceCall(string fromNo, string toNo, string twiml) returns (VoiceCallResponse|error);

    # Get the Authy app details.
    # + return - If success, returns Authy app response object with basic details, else returns error object
    public function getAuthyAppDetails() returns (AuthyAppDetailsResponse|error);

    # Add an user for Authy app.
    # + email - Email of the new user
    # + phone - Phone number of the new user
    # + countryCode - Country code of the new user
    # + return - If success, returns Authy user add response object with basic details, else returns error object
    public function addAuthyUser(string email, string phone, string countryCode) returns (AuthyUserAddResponse|
                error);

    # Get the user details of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user status response object with basic details, else returns error object
    public function getAuthyUserStatus(string userId) returns (AuthyUserStatusResponse|error);

    # Delete the user of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user delete response object with basic details, else returns error object
    public function deleteAuthyUser(string userId) returns (AuthyUserDeleteResponse|error);

    # Get the user secret of Authy user for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user secret response object with basic details, else returns error object
    public function getAuthyUserSecret(string userId) returns (AuthyUserSecretResponse|error);

    # Request OTP for the user of Authy via SMS for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error object
    public function requestOtpViaSms(string userId) returns (AuthyOtpResponse|error);

    # Request OTP for the user of Authy via call for the given user-id.
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error object
    public function requestOtpViaCall(string userId) returns (AuthyOtpResponse|error);

    # Verify OTP for the user of Authy for the given user-id.
    # + userId - Unique identifier of the user
    # + token - The OTP token to be verified
    # + return - If success, returns Authy OTP verify response object with basic details, else returns error object
    public function verifyOtp(string userId, string token) returns (AuthyOtpVerifyResponse|error);
};

function TwilioConnector::getAccountDetails() returns (Account|error) {
    endpoint http:Client httpClient = self.basicClient;
    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + ACCOUNT_DETAILS;
    var response = httpClient->get(requestPath);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAccount(jsonResponse);
}

function TwilioConnector::sendSms(string fromNo, string toNo, string message) returns SmsResponse|error {
    endpoint http:Client httpClient = self.basicClient;
    http:Request req = new;

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
    req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + SMS_SEND;
    var response = httpClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToSmsResponse(jsonResponse);
}

function TwilioConnector::makeVoiceCall(string fromNo, string toNo, string twiml)
                                     returns VoiceCallResponse|error {

    endpoint http:Client httpClient = self.basicClient;
    http:Request req = new;

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, URL, twiml);
    req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + VOICE_CALL;
    var response = httpClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToVoiceCallResponse(jsonResponse);
}

function TwilioConnector::getAuthyAppDetails() returns AuthyAppDetailsResponse|error {

    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_APP_API;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyAppDetailsResponse(jsonResponse);
}

function TwilioConnector::addAuthyUser(string email, string phone, string countryCode)
                                     returns AuthyUserAddResponse|error {

    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[email]", email);
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[cellphone]", phone);
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[country_code]", countryCode);
    req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

    string requestPath = AUTHY_USER_API + USER_ADD;
    var response = httpClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserAddRespones(jsonResponse);
}

function TwilioConnector::getAuthyUserStatus(string userId) returns AuthyUserStatusResponse|error {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_STATUS;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserStatusResponse(jsonResponse);
}

function TwilioConnector::deleteAuthyUser(string userId) returns AuthyUserDeleteResponse|error {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_REMOVE;
    var response = httpClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserDeleteResponse(jsonResponse);
}

function TwilioConnector::getAuthyUserSecret(string userId) returns AuthyUserSecretResponse|error {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_SECRET;
    var response = httpClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserSecretResponse(jsonResponse);
}

function TwilioConnector::requestOtpViaSms(string userId) returns AuthyOtpResponse|error {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_SMS_API + FORWARD_SLASH + userId;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

function TwilioConnector::requestOtpViaCall(string userId) returns AuthyOtpResponse|error {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_CALL_API + FORWARD_SLASH + userId;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

function TwilioConnector::verifyOtp(string userId, string token) returns AuthyOtpVerifyResponse|error {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_VERIFY_API + FORWARD_SLASH + token + FORWARD_SLASH + userId;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpVerifyResponse(jsonResponse);
}
