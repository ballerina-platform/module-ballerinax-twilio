//Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/encoding;
import ballerina/crypto;

//todo:Verify by signing secret
@display {label: "Twilio Listener"}
public class TwilioEventListener {
    private http:Listener httpListener;
    private string callbackUrl = "";
    private string authToken = "";

    public isolated function init(int port, string authToken, string callbackUrl) {
        self.authToken = authToken;
        self.callbackUrl = callbackUrl;
        self.httpListener = checkpanic new (port);
    }

    public isolated function attach(http:Service s, string[]|string? name) returns error? {
        return self.httpListener.attach(s, name);
    }

    public isolated function detach(http:Service s) returns error? {
        return self.httpListener.detach(s);
    }

    public isolated function 'start() returns error? {
        return self.httpListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        return ();
    }

    public isolated function immediateStop() returns error? {
        return self.httpListener.immediateStop();
    }

    # Returns TwilioEvent corresponding to the incoming Notification
    # + caller - The http caller object for responding to requests 
    # + twilioRequest - The HTTP request.
    # + return - If success, returns TwilioEvent object, else returns error
    public isolated function getEventType(http:Caller caller, http:Request twilioRequest) returns @tainted error|TwilioEvent {
        map<string> payload = check twilioRequest.getFormParams();
        string generatedSignature = "";
        if(payload.hasKey("CallStatus")) {
            TwilioEvent eventPayload = mapPayloadToCallEvent(payload);
            generatedSignature = check self.getSignature(self.authToken, self.callbackUrl, eventPayload);
            return eventPayload;
        } else if (payload.hasKey("SmsStatus")) {
            TwilioEvent eventPayload = mapPayloadToSMSEvent(payload);
            generatedSignature = check self.getSignature(self.authToken, self.callbackUrl, eventPayload);
            return eventPayload;
        } else {
            return error("Invalid payload or an eventtype listener currently does not support");
        }
        // Signature check
        // string incomingTwilioSignature = check  twilioRequest.getHeader("X-Twilio-Signature");
        // //string incomingTwilioSignature = notification.getHeader("X-Twilio-Signature");
        // if (generatedSignature != incomingTwilioSignature) {
        //     return error(INVALID_SIGNATURE);
        // }
    }

    # Generate a signature from the incoming request
    # + authToken - Auth Token from the twilio account
    # + url - Registered callback URL where the event payload dispatched
    # + eventPayload - Event payload
    # + return - Generated signature out of the data from the incoming request payload.
    isolated function getSignature(string authToken, string url, TwilioEvent eventPayload) returns error|string {
        final map<string> keyValueMap = {};
        string[] keys = [];
        foreach var [key, value] in eventPayload.entries() {
            if(keyValueMap[key] == "") {
                keys.push(key);
                keyValueMap[key] = value;
            }
        }
        string[] sortedKeyArray = keys.sort();
        // accumated string of key values pairs from the payload, initialized with the URL
        string accumilatedKeyValue = url;
        foreach var key in sortedKeyArray {
            accumilatedKeyValue = accumilatedKeyValue + key + <string>eventPayload[key];
        }
        var decodedMessageBody = check encoding:decodeUriComponent(accumilatedKeyValue, "UTF-8");
        byte[] hmac = check crypto:hmacSha1(decodedMessageBody.toBytes(), authToken.toBytes());
        string urlEncodedValue = hmac.toBase64();

        return urlEncodedValue;
    }
}
