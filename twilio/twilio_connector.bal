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
    F{{basicClient}} Http client endpoint
}
public type TwilioConnector object {

    public {
        string accountSid;
        http:Client basicClient;
    }

    documentation { Return account details of the given account-sid.
        R{{account}} Account object with basic details
        R{{err}} Error occured when getting account details by http call or parsing the response into json
    }
    public function getAccountDetails() returns (Account|error);

    documentation { Send sms from the given account-sid
        P{{fromNo}} Mobile number which the SMS should be send from
        P{{toNo}} Mobile number which the SMS should be received to
        P{{message}} Message body of the SMS
        R{{smsResponse}} Sms response object with basic details
        R{{err}} Error occured when sending sms by http call or parsing the response into json
    }
    public function sendSms(string fromNo, string toNo, string message) returns (SmsResponse|error);

    documentation { Make a voice call from the given account-sid
        P{{fromNo}} Mobile number which the voice call should be send from
        P{{toNo}} Mobile number which the voice call should be received to
        P{{twiml}} TwiML URL which the response of the voice call is stated
        R{{voiceCallResponse}} Voice call response object with basic details
        R{{err}} Error occured when making voice call by http call or parsing the response into json
    }
    public function makeVoiceCall(string fromNo, string toNo, string twiml) returns (VoiceCallResponse|error);

};

public function TwilioConnector::getAccountDetails() returns (Account|error) {

    endpoint http:Client httpClient = self.basicClient;
    http:Request request = new();

    string requestPath = ACCOUNTS_API + self.accountSid + RESPONSE_TYPE_JSON;
    var response = httpClient -> get(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            Account account = {};
            account.sid = jsonPayload.sid.toString() but { () => EMPTY_STRING };
            account.name = jsonPayload.friendly_name.toString() but { () => EMPTY_STRING };
            account.status = jsonPayload.status.toString() but { () => EMPTY_STRING };
            account.^"type" = jsonPayload.^"type".toString() but { () => EMPTY_STRING };
            account.createdDate = jsonPayload.date_created.toString() but { () => EMPTY_STRING };
            account.updatedDate = jsonPayload.date_updated.toString() but { () => EMPTY_STRING };
            return account;
        }
        error err => return err;
    }
}

public function TwilioConnector::sendSms(string fromNo, string toNo, string message) returns (SmsResponse|error) {

    endpoint http:Client httpClient = self.basicClient;
    http:Request request = new();
    constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
    request.setStringPayload(requestBody);

    string requestPath = ACCOUNTS_API + self.accountSid + SMS_API + RESPONSE_TYPE_JSON;
    var response = httpClient -> post(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            SmsResponse smsResponse = {};
            smsResponse.sid = jsonPayload.sid.toString() but { () => EMPTY_STRING };
            smsResponse.status = jsonPayload.status.toString() but { () => EMPTY_STRING };
            smsResponse.price = jsonPayload.price.toString() but { () => EMPTY_STRING };
            smsResponse.priceUnit = jsonPayload.price_unit.toString() but { () => EMPTY_STRING };
            return smsResponse;
        }
        error err => return err;
    }
}

public function TwilioConnector::makeVoiceCall(string fromNo, string toNo, string twiml) returns (VoiceCallResponse|error) {

    endpoint http:Client httpClient = self.basicClient;
    http:Request request = new();
    constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, URL, twiml);
    request.setStringPayload(requestBody);

    string requestPath = ACCOUNTS_API + self.accountSid + VOICE_API + RESPONSE_TYPE_JSON;
    var response = httpClient -> post(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            VoiceCallResponse voiceCallResponse = {};
            voiceCallResponse.sid = jsonPayload.sid.toString() but { () => EMPTY_STRING };
            voiceCallResponse.status = jsonPayload.status.toString() but { () => EMPTY_STRING };
            voiceCallResponse.price = jsonPayload.price.toString() but { () => EMPTY_STRING };
            voiceCallResponse.priceUnit = jsonPayload.price_unit.toString() but { () => EMPTY_STRING };
            return voiceCallResponse;
        }
        error err => return err;
    }
}
