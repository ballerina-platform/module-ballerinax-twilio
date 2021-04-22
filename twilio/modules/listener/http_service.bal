// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/crypto;
import ballerina/http;
import ballerina/log;
import ballerina/url;

service class HttpService {

    private boolean isOnSmsQueued = false;
    private boolean isOnSmsSent = false;
    private boolean isOnSmsDelivered = false;

    private boolean isOnCallRang = false;
    private boolean isOnCallAnswered = false;
    private boolean isOnCallCompleted = false;
    
    private SimpleHttpService httpService;
    private string authToken;
    private string callbackUrl;

    public isolated function init(SimpleHttpService httpService, string callbackUrl, string authToken) {
        self.httpService = httpService;
        self.callbackUrl = callbackUrl;
        self.authToken = authToken;
        string[] methodNames = getServiceMethodNames(httpService);

        foreach var methodName in methodNames {
            match methodName {
                "onSmsQueued" => {
                    self.isOnSmsQueued = true;
                }
                "onSmsSent" => {
                    self.isOnSmsSent = true;
                }
                "onSmsDelivered" => {
                    self.isOnSmsDelivered = true;
                }
                "onCallRang" => {
                    self.isOnCallRang = true;
                }
                "onCallAnswered" => {
                    self.isOnCallAnswered = true;
                }
                "onCallCompleted" => {
                    self.isOnCallCompleted = true;
                }
                _ => {
                    log:printError("Unrecognized method [" + methodName + "] found in the implementation");
                }
            }
        }
    }

    # Returns TwilioEvent corresponding to the incoming Notification
    # + caller - The http caller object for responding to requests 
    # + twilioRequest - The HTTP request.
    # + return - If success, returns TwilioEvent object, else returns error
    isolated resource function post onChange(http:Caller caller, http:Request twilioRequest) returns 
                                           error? {
        SmsStatusChangeEvent smsEvent = {};
        CallStatusChangeEvent callEvent = {};
        map<string> payload = check twilioRequest.getFormParams();
        check caller->respond(http:STATUS_OK); 
        if(payload.hasKey("CallStatus")) {
            CallStatusChangeEvent eventPayload = check payload.cloneWithType(CallStatusChangeEvent);
            string CallStatus = check eventPayload?.CallStatus;
            match CallStatus.toString() {
                RINGING => {
                    if (self.isOnCallRang) {
                        check callOnCallRang(self.httpService, eventPayload);
                    }
                }
                IN_PROGRESS => {
                    if (self.isOnCallAnswered) {
                        check callOnCallAnswered(self.httpService, eventPayload);
                    }
                }
                COMPLETED => {
                    if (self.isOnCallCompleted) {
                        check callOnCallCompleted(self.httpService, eventPayload);
                    }
                }
                _ => {
                    log:printError("Unrecognized event type [" + CallStatus.toString() 
                        + "] found in the response payload");
                }
            }
            return;
        } else if (payload.hasKey("SmsStatus")) {
            SmsStatusChangeEvent eventPayload = check payload.cloneWithType(SmsStatusChangeEvent);
            string SmsStatus = check eventPayload?.SmsStatus;
            match SmsStatus.toString() {
                QUEUED => {
                    if (self.isOnSmsQueued) {
                        check callOnSmsQueued(self.httpService, eventPayload);
                    }
                }
                SENT => {
                    if (self.isOnSmsSent) {
                        check callOnSmsSent(self.httpService, eventPayload);
                    }
                }
                DELIVERED => {
                    if (self.isOnCallCompleted) {
                        check callOnSmsDelivered(self.httpService, eventPayload);
                    }
                }
                _ => {
                    log:printError("Unrecognized event type [" + SmsStatus.toString() 
                        + "] found in the response payload");
                }
            }
            return;
        } else {
            return error("Invalid payload or an eventtype listener currently does not support");
        }
    }

    # Generate a signature from the incoming request
    # + authToken - Auth Token from the twilio account
    # + url - Registered callback URL where the event payload dispatched
    # + eventPayload - Event payload
    # + return - Generated signature out of the data from the incoming request payload.
    isolated function getSignature(string authToken, string url, TwilioEvent eventPayload) returns error|string {
        final map<string> keyValueMap = {};
        string[] keys = [];
        foreach var [entry, value] in eventPayload.entries() {
            if(keyValueMap[entry] == "") {
                keys.push(entry);
                keyValueMap[entry] = value;
            }
        }
        string[] sortedKeyArray = keys.sort();
        // accumated string of key values pairs from the payload, initialized with the URL
        string accumilatedKeyValue = url;
        foreach var entry in sortedKeyArray {
            accumilatedKeyValue = accumilatedKeyValue + entry + <string>eventPayload[entry];
        }
        string decodedMessageBody = check url:decode(accumilatedKeyValue, "UTF-8");
        byte[] hmac = check crypto:hmacSha1(decodedMessageBody.toBytes(), authToken.toBytes());
        string urlEncodedValue = hmac.toBase64();

        return urlEncodedValue;
    }
}
