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

package twilio;

import ballerina/http;

@Description {value:"Get account details of the given account-sid."}
@Return {value:"Account struct with basic details."}
@Return {value:"Error occured when getting account details by http call or parsing the response into json."}
public function <TwilioConnector twilioConnector> getAccountDetails () returns (Account|error) {
    endpoint http:ClientEndpoint clientEndpoint = twilioConnector.clientEndpoint;
    http:Request request = {};
    string authHeaderValue = twilioConnector.getAuthorizationHeaderValue();
    twilioConnector.constructRequestHeaders(request, AUTHORIZATION, authHeaderValue);

    string requestPath = ACCOUNTS_API + twilioConnector.accountSid + RESPONSE_TYPE_JSON;
    var response = clientEndpoint -> get(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            Account account = {};
            account.sid = jsonPayload.sid != null ? jsonPayload.sid.toString() : EMPTY_STRING;
            account.name = jsonPayload.friendly_name != null ? jsonPayload.friendly_name.toString() : EMPTY_STRING;
            account.status = jsonPayload.status != null ? jsonPayload.status.toString() : EMPTY_STRING;
            account.^"type" = jsonPayload.^"type" != null ? jsonPayload.^"type".toString() : EMPTY_STRING;
            account.createdDate = jsonPayload.date_created != null ? jsonPayload.date_created.toString() : EMPTY_STRING;
            account.updatedDate = jsonPayload.date_updated != null ? jsonPayload.date_updated.toString() : EMPTY_STRING;
            return account;
        }
        error err => return err;
    }
}

@Description {value:"Send sms from the given account-sid."}
@Return {value:"Sms response struct with basic details."}
@Return {value:"Error occured when sending sms by http call or parsing the response into json."}
public function <TwilioConnector twilioConnector> sendSms (string fromNo, string toNo, string message) returns (SmsResponse|error) {
    endpoint http:ClientEndpoint clientEndpoint = twilioConnector.clientEndpoint;
    http:Request request = {};
    string authHeaderValue = twilioConnector.getAuthorizationHeaderValue();
    twilioConnector.constructRequestHeaders(request, AUTHORIZATION, authHeaderValue);
    twilioConnector.constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody = EMPTY_STRING;
    requestBody =? createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody =? createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody =? createUrlEncodedRequestBody(requestBody, BODY, message);
    request.setStringPayload(requestBody);

    string requestPath = ACCOUNTS_API + twilioConnector.accountSid + SMS_API + RESPONSE_TYPE_JSON;
    var response = clientEndpoint -> post(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            SmsResponse smsResponse = {};
            smsResponse.sid = jsonPayload.sid != null ? jsonPayload.sid.toString() : EMPTY_STRING;
            smsResponse.status = jsonPayload.status != null ? jsonPayload.status.toString() : EMPTY_STRING;
            smsResponse.price = jsonPayload.price != null ? jsonPayload.price.toString() : EMPTY_STRING;
            smsResponse.priceUnit = jsonPayload.price_unit != null ? jsonPayload.price_unit.toString() : EMPTY_STRING;
            return smsResponse;
        }
        error err => return err;
    }
}

@Description {value:"Make a voice call from the given account-sid."}
@Return {value:"Voice call response struct with basic details."}
@Return {value:"Error occured when making voice call by http call or parsing the response into json."}
public function <TwilioConnector twilioConnector> makeVoiceCall (string fromNo, string toNo, string twiml) returns (VoiceCallResponse|error) {
    endpoint http:ClientEndpoint clientEndpoint = twilioConnector.clientEndpoint;
    http:Request request = {};
    string authHeaderValue = twilioConnector.getAuthorizationHeaderValue();
    twilioConnector.constructRequestHeaders(request, AUTHORIZATION, authHeaderValue);
    twilioConnector.constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody = EMPTY_STRING;
    requestBody =? createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody =? createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody =? createUrlEncodedRequestBody(requestBody, URL, twiml);
    request.setStringPayload(requestBody);

    string requestPath = ACCOUNTS_API + twilioConnector.accountSid + VOICE_API + RESPONSE_TYPE_JSON;
    var response = clientEndpoint -> post(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            VoiceCallResponse voiceCallResponse = {};
            voiceCallResponse.sid = jsonPayload.sid != null ? jsonPayload.sid.toString() : EMPTY_STRING;
            voiceCallResponse.status = jsonPayload.status != null ? jsonPayload.status.toString() : EMPTY_STRING;
            voiceCallResponse.price = jsonPayload.price != null ? jsonPayload.price.toString() : EMPTY_STRING;
            voiceCallResponse.priceUnit = jsonPayload.price_unit != null ? jsonPayload.price_unit.toString() : EMPTY_STRING;
            return voiceCallResponse;
        }
        error err => return err;
    }
}
