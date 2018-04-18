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
// under the License.package twilio;

import ballerina/http;

documentation {Object to initialize the connection with Twilio.
    F{{accountSid}} Unique identifier of the account
    F{{xAuthyKey}} Unique identifier for Authy api account
    F{{basicClient}} Http client endpoint
}
public type TwilioConnector object {

    public {
        string accountSid;
        string xAuthyKey;
        http:Client basicClient;
        http:Client authyClient;
    }

    documentation { Return account details of the given account-sid
        R{{account}} Account object with basic details
        R{{err}} Error occured when getting account details
    }
    public function getAccountDetails() returns (Account|TwilioError);

    documentation { Send sms from the given account-sid
        P{{fromNo}} Mobile number which the SMS should be send from
        P{{toNo}} Mobile number which the SMS should be received to
        P{{message}} Message body of the SMS
        R{{smsResponse}} Sms response object with basic details
        R{{err}} Error occured when sending sms
    }
    public function sendSms(string fromNo, string toNo, string message) returns (SmsResponse|TwilioError);

    documentation { Make a voice call from the given account-sid
        P{{fromNo}} Mobile number which the voice call should be send from
        P{{toNo}} Mobile number which the voice call should be received to
        P{{twiml}} TwiML URL which the response of the voice call is stated
        R{{voiceCallResponse}} Voice call response object with basic details
        R{{err}} Error occured when making voice call
    }
    public function makeVoiceCall(string fromNo, string toNo, string twiml) returns (VoiceCallResponse|TwilioError);

    documentation { Get the Authy app details
        R{{authyApp}} Authy app object with basic details
        R{{err}} Error occured when getting authy app details
    }
    public function getAuthyAppDetails() returns (AuthyAppDetailsResponse|TwilioError);

    documentation { Add an user for Authy app
        P{{email}} Email of the new user
        P{{phone}} Phone number of the new user
        P{{countryCode}} Country code of the new user
        R{{authyNewUser}} Authy new user object with basic response
        R{{err}} Error occured when adding authy user
    }
    public function addAuthyUser(string email, string phone, string countryCode) returns (AuthyUserAddResponse|TwilioError);

    documentation { Get the user details of Authy for the given user-id
        P{{userId}} Unique identifier of the user
        R{{authyUser}} Authy user object with basic details
        R{{err}} Error occured when getting authy user status
    }
    public function getAuthyUserStatus(string userId) returns (AuthyUserStatusResponse|TwilioError);

    documentation { Delete the user of Authy for the given user-id
        P{{userId}} Unique identifier of the user
        R{{authyResponse}} Authy response object
        R{{err}} Error occured when deleting authy user
    }
    public function deleteAuthyUser(string userId) returns (AuthyUserDeleteResponse|TwilioError);

    documentation { Get the user secret of Authy user for the given user-id
        P{{userId}} Unique identifier of the user
        R{{authyResponse}} Authy response object
        R{{err}} Error occured when getting the secret of authy user
    }
    public function getAuthyUserSecret(string userId) returns (AuthyUserSecretResponse|TwilioError);

    documentation { Request otp for the user of Authy via sms for the given user-id
        P{{userId}} Unique identifier of the user
        R{{authyResponse}} Authy response object
        R{{err}} Error occured when requesting otp via sms for authy user
    }
    public function requestOtpViaSms(string userId) returns (AuthyOtpResponse|TwilioError);

    documentation { Request OTP for the user of Authy via call for the given user-id
        P{{userId}} Unique identifier of the user
        R{{authyResponse}} Authy response object
        R{{err}} Error occured when requesting otp via call for authy user
    }
    public function requestOtpViaCall(string userId) returns (AuthyOtpResponse|TwilioError);

    documentation { Verify otp for the user of Authy for the given user-id
        P{{userId}} Unique identifier of the user
        R{{authyResponse}} Authy response object
        R{{err}} Error occured when verifying otp for authy user
    }
    public function verifyOtp(string userId, string token) returns (AuthyOtpVerifyResponse|TwilioError);

};

public function TwilioConnector::getAccountDetails() returns (Account|TwilioError) {

    endpoint http:Client httpClient = self.basicClient;
    http:Request request = new();

    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSid + ACCOUNT_DETAILS;
    var response = httpClient -> get(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAccount(jsonResponse);
}

public function TwilioConnector::sendSms(string fromNo, string toNo, string message) returns (SmsResponse|TwilioError) {

    endpoint http:Client httpClient = self.basicClient;
    http:Request request = new();
    constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
    request.setStringPayload(requestBody);

    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSid + SMS_SEND;
    var response = httpClient -> post(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToSmsResponse(jsonResponse);
}

public function TwilioConnector::makeVoiceCall(string fromNo, string toNo, string twiml) returns (VoiceCallResponse|TwilioError) {

    endpoint http:Client httpClient = self.basicClient;
    http:Request request = new();
    constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, URL, twiml);
    request.setStringPayload(requestBody);

    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSid + VOICE_CALL;
    var response = httpClient -> post(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToVoiceCallResponse(jsonResponse);
}

public function TwilioConnector::getAuthyAppDetails() returns (AuthyAppDetailsResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_APP_API;
    var response = httpClient -> get(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyAppDetailsResponse(jsonResponse);
}

public function TwilioConnector::addAuthyUser(string email, string phone, string countryCode) returns (AuthyUserAddResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);
    constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[email]", email);
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[cellphone]", phone);
    requestBody = check createUrlEncodedRequestBody(requestBody, "user[country_code]", countryCode);
    request.setStringPayload(requestBody);

    string requestPath = AUTHY_USER_API + USER_ADD;
    var response = httpClient -> post(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserAddRespones(jsonResponse);
}

public function TwilioConnector::getAuthyUserStatus(string userId) returns (AuthyUserStatusResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_STATUS;
    var response = httpClient -> get(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserStatusResponse(jsonResponse);
}

public function TwilioConnector::deleteAuthyUser(string userId) returns (AuthyUserDeleteResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_REMOVE;
    var response = httpClient -> post(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserDeleteResponse(jsonResponse);
}

public function TwilioConnector::getAuthyUserSecret(string userId) returns (AuthyUserSecretResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_SECRET;
    var response = httpClient -> post(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserSecretResponse(jsonResponse);
}

public function TwilioConnector::requestOtpViaSms(string userId) returns (AuthyOtpResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_OTP_SMS_API + FORWARD_SLASH + userId;
    var response = httpClient -> get(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

public function TwilioConnector::requestOtpViaCall(string userId) returns (AuthyOtpResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_OTP_CALL_API + FORWARD_SLASH + userId;
    var response = httpClient -> get(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

public function TwilioConnector::verifyOtp(string userId, string token) returns (AuthyOtpVerifyResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request request = new();
    constructRequestHeaders(request, X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_OTP_VERIFY_API + FORWARD_SLASH + token + FORWARD_SLASH + userId;
    var response = httpClient -> get(requestPath, request);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpVerifyResponse(jsonResponse);
}
