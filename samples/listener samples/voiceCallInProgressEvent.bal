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

import ballerina/log;
import ballerinax/twilio;
import ballerinax/twilio.webhook as webhook;
import ballerina/http;

configurable string fromMobile = ?;
configurable string toMobile = ?;
configurable string accountSId = ?;
configurable string authToken = ?;
configurable string twimlURL = ?;

//ngork is used to get the callback url eg: http://6d602a963438.ngrok.io/twilio
configurable string statusCallbackUrl = ?;

//Starting a service with using twilio listner by providing port,authToken, status call back url.
listener webhook:TwilioEventListener twilioListener = new (9090, authToken, statusCallbackUrl);
service / on twilioListener {
    resource function post twilio(http:Caller caller, http:Request request) returns error? {
        var payload = check twilioListener.getEventType(caller, request);
        if (payload is webhook:CallStatusChangeEvent) {
            if (payload.CallStatus == webhook:IN_PROGRESS) {
                log:print("The call has been answered");
            } 
        } 
    }
}

public function main() {
    twilio:TwilioConfiguration twilioConfig = {
        accountSId: accountSId,
        authToken: authToken
    };
    twilio:Client twilioClient = new (twilioConfig);
    
    //Setting webhook callback details
    twilio:StatusCallback webhookCallbackInfo = {
        url: statusCallbackUrl,
        method: webhook:POST,
        events: [webhook:ANSWERED]
    };
    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlURL, webhookCallbackInfo);
    if (details is error) {
        log:print(details.message());
    }

}
