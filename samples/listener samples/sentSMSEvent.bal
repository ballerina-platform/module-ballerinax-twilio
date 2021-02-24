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
configurable string message = "Wso2-Test-SMS-Message";

//ngork is used to get the callback url eg: http://6d602a963438.ngrok.io/twilio
configurable string statusCallbackUrl = ?;


//Starting a service with twilio listner by providing port,authToken, status call back url.
listener webhook:TwilioEventListener twilioListener = new (9090, authToken, statusCallbackUrl);
service / on twilioListener {
    resource function post twilio(http:Caller caller, http:Request request) returns error? {
        var payload = check twilioListener.getEventType(caller, request);

        //Check for the event and get the status of the event.
        if (payload is webhook:SmsStatusChangeEvent) {
            if (payload.SmsStatus == webhook:SENT) {
                log:print("An SMS has been sent");
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
    var details = twilioClient->sendSms(fromMobile, toMobile, message, statusCallbackUrl);
    if (details is error) {
        log:print(details.message());
    }

}
