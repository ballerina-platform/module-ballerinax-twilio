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

@Description {value:"Get account details of the given account-sid."}
@Return {value:"Account object with basic details."}
@Return {value:"Error occured when getting account details by http call or parsing the response into json."}
public function <TwilioConnector twilioConnector> getAccountDetails () returns (Account|error) {
    endpoint http:ClientEndpoint clientEndpoint = twilioConnector.clientEndpoint;
    http:Request request = new ();
    string authHeaderValue = getAuthorizationHeaderValue(twilioConnector.accountSid, twilioConnector.authToken);
    constructRequestHeaders(request, AUTHORIZATION, authHeaderValue);

    string requestPath = ACCOUNTS_API + twilioConnector.accountSid + RESPONSE_TYPE_JSON;
    var response = clientEndpoint -> get(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            Account account = {};
            account.sid = jsonPayload.sid.toString();
            account.name = jsonPayload.friendly_name.toString();
            account.status = jsonPayload.status.toString();
            account.^"type" = jsonPayload.^"type".toString();
            account.createdDate = jsonPayload.date_created.toString();
            account.updatedDate = jsonPayload.date_updated.toString();
            return account;
        }
        error err => return err;
    }
}

@Description {value:"Send sms from the given account-sid."}
@Return {value:"Sms response object with basic details."}
@Return {value:"Error occured when sending sms by http call or parsing the response into json."}
public function <TwilioConnector twilioConnector> sendSms (string fromNo, string toNo, string message) returns (SmsResponse|error) {
    endpoint http:ClientEndpoint clientEndpoint = twilioConnector.clientEndpoint;
    http:Request request = new ();
    string authHeaderValue = getAuthorizationHeaderValue(twilioConnector.accountSid, twilioConnector.authToken);
    constructRequestHeaders(request, AUTHORIZATION, authHeaderValue);
    constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
    request.setStringPayload(requestBody);

    string requestPath = ACCOUNTS_API + twilioConnector.accountSid + SMS_API + RESPONSE_TYPE_JSON;
    var response = clientEndpoint -> post(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            SmsResponse smsResponse = {};
            smsResponse.sid = jsonPayload.sid.toString();
            smsResponse.status = jsonPayload.status.toString();
            smsResponse.price = jsonPayload.price.toString();
            smsResponse.priceUnit = jsonPayload.price_unit.toString();
            return smsResponse;
        }
        error err => return err;
    }
}

@Description {value:"Make a voice call from the given account-sid."}
@Return {value:"Voice call response object with basic details."}
@Return {value:"Error occured when making voice call by http call or parsing the response into json."}
public function <TwilioConnector twilioConnector> makeVoiceCall (string fromNo, string toNo, string twiml) returns (VoiceCallResponse|error) {
    endpoint http:ClientEndpoint clientEndpoint = twilioConnector.clientEndpoint;
    http:Request request = new ();
    string authHeaderValue = getAuthorizationHeaderValue(twilioConnector.accountSid, twilioConnector.authToken);
    constructRequestHeaders(request, AUTHORIZATION, authHeaderValue);
    constructRequestHeaders(request, CONTENT_TYPE, APPLICATION_URL_FROM_ENCODED);

    string requestBody;
    requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
    requestBody = check createUrlEncodedRequestBody(requestBody, URL, twiml);
    request.setStringPayload(requestBody);

    string requestPath = ACCOUNTS_API + twilioConnector.accountSid + VOICE_API + RESPONSE_TYPE_JSON;
    var response = clientEndpoint -> post(requestPath, request);
    var jsonResponse = parseResponseToJson(response);
    match jsonResponse {
        json jsonPayload => {
            VoiceCallResponse voiceCallResponse = {};
            voiceCallResponse.sid = jsonPayload.sid.toString();
            voiceCallResponse.status = jsonPayload.status.toString();
            voiceCallResponse.price = jsonPayload.price.toString();
            voiceCallResponse.priceUnit = jsonPayload.price_unit.toString();
            return voiceCallResponse;
        }
        error err => return err;
    }
}
