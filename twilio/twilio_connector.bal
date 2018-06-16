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
import ballerina/mime;

documentation {Object to initialize the connection with Twilio.
    F{{accountSId}} Unique identifier of the account
    F{{xAuthyKey}} Unique identifier of Authy API account
    F{{basicClient}} Http client endpoint for basic api
    F{{authyClient}} Http client endpoint for authy api
}
public type TwilioConnector object {

    public {
        string accountSId;
        string xAuthyKey;
        http:Client basicClient;
        http:Client authyClient;
    }

    documentation { Return account details of the given account-sid
        R{{}} If success, returns account object with basic details, else returns TwilioError object
    }
    public function getAccountDetails() returns (Account|TwilioError);

    documentation { Send SMS from the given account-sid
        P{{fromNo}} Mobile number which the SMS should be send from
        P{{toNo}} Mobile number which the SMS should be received to
        P{{message}} Message body of the SMS
        R{{}} If success, returns SMS response object with basic details, else returns TwilioError object
    }
    public function sendSms(string fromNo, string toNo, string message) returns (SmsResponse|TwilioError);

    documentation { Make a voice call from the given account-sid
        P{{fromNo}} Mobile number which the voice call should be send from
        P{{toNo}} Mobile number which the voice call should be received to
        P{{twiml}} TwiML URL which the response of the voice call is stated
        R{{}} If success, returns voice call response object with basic details, else returns TwilioError object
    }
    public function makeVoiceCall(string fromNo, string toNo, string twiml) returns (VoiceCallResponse|TwilioError);

    documentation { Get the Authy app details
        R{{}} If success, returns Authy app response object with basic details, else returns TwilioError object
    }
    public function getAuthyAppDetails() returns (AuthyAppDetailsResponse|TwilioError);

    documentation { Add an user for Authy app
        P{{email}} Email of the new user
        P{{phone}} Phone number of the new user
        P{{countryCode}} Country code of the new user
        R{{}} If success, returns Authy user add response object with basic details, else returns TwilioError object
    }
    public function addAuthyUser(string email, string phone, string countryCode) returns (AuthyUserAddResponse|
                TwilioError);

    documentation { Get the user details of Authy for the given user-id
        P{{userId}} Unique identifier of the user
        R{{}} If success, returns Authy user status response object with basic details, else returns TwilioError object
    }
    public function getAuthyUserStatus(string userId) returns (AuthyUserStatusResponse|TwilioError);

    documentation { Delete the user of Authy for the given user-id
        P{{userId}} Unique identifier of the user
        R{{}} If success, returns Authy user delete response object with basic details, else returns TwilioError object
    }
    public function deleteAuthyUser(string userId) returns (AuthyUserDeleteResponse|TwilioError);

    documentation { Get the user secret of Authy user for the given user-id
        P{{userId}} Unique identifier of the user
        R{{}} If success, returns Authy user secret response object with basic details, else returns TwilioError object
    }
    public function getAuthyUserSecret(string userId) returns (AuthyUserSecretResponse|TwilioError);

    documentation { Request OTP for the user of Authy via SMS for the given user-id
        P{{userId}} Unique identifier of the user
        R{{}} If success, returns Authy OTP response object with basic details, else returns TwilioError object
    }
    public function requestOtpViaSms(string userId) returns (AuthyOtpResponse|TwilioError);

    documentation { Request OTP for the user of Authy via call for the given user-id
        P{{userId}} Unique identifier of the user
        R{{}} If success, returns Authy OTP response object with basic details, else returns TwilioError object
    }
    public function requestOtpViaCall(string userId) returns (AuthyOtpResponse|TwilioError);

    documentation { Verify OTP for the user of Authy for the given user-id
        P{{userId}} Unique identifier of the user
        P{{token}} The OTP token to be verified
        R{{}} If success, returns Authy OTP verify response object with basic details, else returns TwilioError object
    }
    public function verifyOtp(string userId, string token) returns (AuthyOtpVerifyResponse|TwilioError);
};

public function TwilioConnector::getAccountDetails() returns (Account|TwilioError) {
    endpoint http:Client httpClient = self.basicClient;
    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + ACCOUNT_DETAILS;
    var response = httpClient->get(requestPath);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAccount(jsonResponse);
}

public function TwilioConnector::sendSms(string fromNo, string toNo, string message) returns (SmsResponse|TwilioError) {
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

public function TwilioConnector::makeVoiceCall(string fromNo, string toNo, string twiml)
                                     returns (VoiceCallResponse|TwilioError) {

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

public function TwilioConnector::getAuthyAppDetails() returns (AuthyAppDetailsResponse|TwilioError) {

    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);

    string requestPath = AUTHY_APP_API;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyAppDetailsResponse(jsonResponse);
}

public function TwilioConnector::addAuthyUser(string email, string phone, string countryCode)
                                     returns (AuthyUserAddResponse|TwilioError) {

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

public function TwilioConnector::getAuthyUserStatus(string userId) returns (AuthyUserStatusResponse|TwilioError) {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_STATUS;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserStatusResponse(jsonResponse);
}

public function TwilioConnector::deleteAuthyUser(string userId) returns (AuthyUserDeleteResponse|TwilioError) {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_REMOVE;
    var response = httpClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserDeleteResponse(jsonResponse);
}

public function TwilioConnector::getAuthyUserSecret(string userId) returns (AuthyUserSecretResponse|TwilioError) {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_SECRET;
    var response = httpClient->post(requestPath, req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyUserSecretResponse(jsonResponse);
}

public function TwilioConnector::requestOtpViaSms(string userId) returns (AuthyOtpResponse|TwilioError) {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_SMS_API + FORWARD_SLASH + userId;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

public function TwilioConnector::requestOtpViaCall(string userId) returns (AuthyOtpResponse|TwilioError) {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_CALL_API + FORWARD_SLASH + userId;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpResponse(jsonResponse);
}

public function TwilioConnector::verifyOtp(string userId, string token) returns (AuthyOtpVerifyResponse|TwilioError) {
    endpoint http:Client httpClient = self.authyClient;
    http:Request req = new;
    req.addHeader(X_AUTHY_API_KEY, self.xAuthyKey);
    string requestPath = AUTHY_OTP_VERIFY_API + FORWARD_SLASH + token + FORWARD_SLASH + userId;
    var response = httpClient->get(requestPath, message = req);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAuthyOtpVerifyResponse(jsonResponse);
}
