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
public type TwilioConnector client object {

    public string accountSId;
    public string xAuthyKey;
    public http:Client basicClient;
    public http:Client authyClient;

    public function __init(TwilioConfiguration twilioConfig) {
        self.basicClient = new(TWILIO_API_BASE_URL, config = twilioConfig.basicClientConfig);
        self.authyClient = new(AUTHY_API_BASE_URL, config = twilioConfig.authyClientConfig);
        self.accountSId = twilioConfig.accountSId;
        self.xAuthyKey = twilioConfig.xAuthyKey;
    }

    remote function getAccountDetails() returns Account|error;

    remote function sendSms(string fromNo, string toNo, string message) returns SmsResponse|error;

    remote function makeVoiceCall(string fromNo, string toNo, string twiml) returns VoiceCallResponse|error;

    remote function getAuthyAppDetails() returns AuthyAppDetailsResponse|error;

    remote function addAuthyUser(string email, string phone, string countryCode) returns AuthyUserAddResponse|error;

    remote function getAuthyUserStatus(string userId) returns AuthyUserStatusResponse|error;

    remote function deleteAuthyUser(string userId) returns AuthyUserDeleteResponse|error;

    remote function getAuthyUserSecret(string userId) returns AuthyUserSecretResponse|error;

    remote function requestOtpViaSms(string userId) returns AuthyOtpResponse|error;

    remote function requestOtpViaCall(string userId) returns AuthyOtpResponse|error;

    remote function verifyOtp(string userId, string token) returns AuthyOtpVerifyResponse|error;
};

remote function TwilioConnector.getAccountDetails() returns Account|error {
    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + ACCOUNT_DETAILS;
    var response = self.basicClient->get(requestPath);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAccount(jsonResponse);
}

remote function TwilioConnector.sendSms(string fromNo, string toNo, string message) returns SmsResponse|error {
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

remote function TwilioConnector.makeVoiceCall(string fromNo, string toNo, string twiml)
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

remote function TwilioConnector.getAuthyAppDetails() returns AuthyAppDetailsResponse|error {

    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_APP_API;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyAppDetailsResponse(jsonResponse);
}

remote function TwilioConnector.addAuthyUser(string email, string phone, string countryCode)
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

remote function TwilioConnector.getAuthyUserStatus(string userId) returns AuthyUserStatusResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_STATUS;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserStatusResponse(jsonResponse);
}

remote function TwilioConnector.deleteAuthyUser(string userId) returns AuthyUserDeleteResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_REMOVE;
    var response = self.authyClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserDeleteResponse(jsonResponse);
}

remote function TwilioConnector.getAuthyUserSecret(string userId) returns AuthyUserSecretResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_SECRET;
    var response = self.authyClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserSecretResponse(jsonResponse);
}

remote function TwilioConnector.requestOtpViaSms(string userId) returns AuthyOtpResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_SMS_API + FORWARD_SLASH + userId;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

remote function TwilioConnector.requestOtpViaCall(string userId) returns AuthyOtpResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_CALL_API + FORWARD_SLASH + userId;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

remote function TwilioConnector.verifyOtp(string userId, string token) returns AuthyOtpVerifyResponse|error {
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_VERIFY_API + FORWARD_SLASH + token + FORWARD_SLASH + userId;
    var response = self.authyClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpVerifyResponse(jsonResponse);
}
