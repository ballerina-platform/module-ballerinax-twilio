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

isolated service class HttpService {
    *http:Service;
    private final boolean isOnSmsQueued;
    private final boolean isOnSmsSent;
    private final boolean isOnSmsDelivered;
    private final boolean isOnSmsReceived;
    private final boolean isOnCallRang;
    private final boolean isOnCallAnswered;
    private final boolean isOnCallCompleted;
    private final HttpToTwilioAdaptor adaptor;
    private final string authToken;
    private final string callbackUrl;

    isolated function init(HttpToTwilioAdaptor adaptor, string callbackUrl, string authToken) {
        self.adaptor = adaptor;
        self.callbackUrl = callbackUrl;
        self.authToken = authToken;

        string[] methodNames = adaptor.getServiceMethodNames();
        self.isOnSmsReceived = isMethodAvailable("onSmsReceived", methodNames);
        self.isOnSmsQueued = isMethodAvailable("onSmsQueued", methodNames);
        self.isOnSmsSent = isMethodAvailable("onSmsSent", methodNames);
        self.isOnSmsDelivered = isMethodAvailable("onSmsDelivered", methodNames);
        self.isOnCallRang = isMethodAvailable("onCallRang", methodNames);
        self.isOnCallAnswered = isMethodAvailable("onCallAnswered", methodNames);
        self.isOnCallCompleted = isMethodAvailable("onCallCompleted", methodNames);

        if (methodNames.length() > 0) {
            foreach string methodName in methodNames {
                log:printError("Unrecognized method [" + methodName + "] found in user implementation."); 
            }
        }
    }

    # Returns TwilioEvent corresponding to the incoming Notification
    # + caller - The http caller object for responding to requests 
    # + twilioRequest - The HTTP request.
    # + return - If success, returns TwilioEvent object, else returns error
    isolated resource function post onChange(http:Caller caller, http:Request twilioRequest) returns 
                                           error? {
        map<string> payload = check twilioRequest.getFormParams();
        check caller->respond(http:STATUS_OK); 
        if(payload.hasKey("CallStatus")) {
            CallStatusChangeEvent eventPayload = check payload.cloneWithType(CallStatusChangeEvent);
            string? CallStatus =  eventPayload?.CallStatus;
            match CallStatus.toString() {
                RINGING => {
                    if (self.isOnCallRang) {
                        check self.adaptor.callOnCallRang(eventPayload);
                    }
                }
                IN_PROGRESS => {
                    if (self.isOnCallAnswered) {
                        check self.adaptor.callOnCallAnswered(eventPayload);
                    }
                }
                COMPLETED => {
                    if (self.isOnCallCompleted) {
                        check self.adaptor.callOnCallCompleted(eventPayload);
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
            string? SmsStatus = eventPayload?.SmsStatus;
            match SmsStatus.toString() {
                QUEUED => {
                    if (self.isOnSmsQueued) {
                        check self.adaptor.callOnSmsQueued(eventPayload);
                    }
                }
                SENT => {
                    if (self.isOnSmsSent) {
                        check self.adaptor.callOnSmsSent(eventPayload);
                    }
                }
                DELIVERED => {
                    if (self.isOnSmsDelivered) {
                        check self.adaptor.callOnSmsDelivered(eventPayload);
                    }
                }
                RECEIVED => {
                    if (self.isOnSmsReceived) {
                        check self.adaptor.callOnSmsReceived(eventPayload);
                    }
                }
                _ => {
                    log:printError("Unrecognized event type [" + SmsStatus.toString() 
                        + "] found in the response payload");
                }
            }
            return;
        } else {
            return error("Invalid payload or an event type listener currently does not support");
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
                keyValueMap[entry] = value.toString();
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

# Retrieves whether the particular remote method is available.
#
# + methodName - Name of the required method
# + methods - All available methods
# + return - `true` if method available or else `false`
isolated function isMethodAvailable(string methodName, string[] methods) returns boolean {
    boolean isAvailable = methods.indexOf(methodName) is int;
    if (isAvailable) {
        var index = methods.indexOf(methodName);
        if (index is int) {
            _ = methods.remove(index);
        }
    }
    return isAvailable;
}
