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
import ballerina/lang.'int as ints;
import ballerina/lang.runtime as runtime;
import ballerina/test;
import ballerinax/twilio;

configurable string twilioAccountSid = ?;
configurable string twilioAuthToken = ?;
configurable string fromNumber =  ?;
configurable string toNumber =  ?;
configurable string test_message = ?;
configurable string port =  ?;
configurable string twimlUrl =  ?;
configurable string callbackUrl =  ?;

int PORT = check ints:fromString(port);
listener TwilioEventListener twilioListener = new (PORT, twilioAuthToken, callbackUrl);

boolean smsQueuedNotified = false;
boolean smsSentNotified = false;
boolean smsRecievedNotified = false;
boolean callQueuedNotified = false;
boolean callRingingNotified = false;
boolean callInProgressNotified = false;
boolean callCompletedNotified = false;

// Mock service for testing webhook events
//Please Uncomment the Service before test the listener and import ballerina/http 
// service / on twilioListener {
//      resource function post twilio(http:Caller caller, http:Request request) returns error? {
//         var payload = twilioListener.getEventType(caller, request);
//         if (payload is SmsStatusChangeEvent) {
//             if (payload.SmsStatus == QUEUED) {
//                 smsQueuedNotified = true;
//             } else if (payload.SmsStatus == SENT) {
//                 smsSentNotified = true;
//             } else if (payload.SmsStatus == RECEIVED) {
//                 smsRecievedNotified = true;
//             }
//         } else if (payload is CallStatusChangeEvent) {
//             if (payload.CallStatus == QUEUED) {
//                 callQueuedNotified = true;
//             } else if (payload.CallStatus == RINGING) {
//                 callRingingNotified = true;
//             } else if (payload.CallStatus == IN_PROGRESS) {
//                 callInProgressNotified = true;
//             } else if (payload.CallStatus == COMPLETED) {
//                 callCompletedNotified = true;
//             }
//         } else {
//             log:print(payload.message());
//         }
//     }

// }
// Test functions for twilio webhook events

twilio:TwilioConfiguration twilioConfig = {
    accountSId: twilioAccountSid,
    authToken: twilioAuthToken
};

twilio:Client twilioClient = new (twilioConfig);

@test:Config {enable: false}
function testSmsQueued() {
    var details = twilioClient->sendSms(fromNumber, toNumber, test_message, callbackUrl);
    if (details is twilio:SmsResponse) {
        log:print(details.sid.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!smsQueuedNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }

    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioWebhook -> recieveSmsQueued()");

    test:assertTrue(smsSentNotified, msg = "expected a sms to be send and receive a queued notification");

}

@test:Config {enable: false}
function testSmsSent() {
    var details = twilioClient->sendSms(fromNumber, toNumber, test_message, callbackUrl);
    if (details is twilio:SmsResponse) {
        log:print(details.sid.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!smsSentNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }

    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioWebhook -> testSmsSent()");

    test:assertTrue(smsSentNotified, msg = "expected a sms to be send and receive a sent notification");
}

@test:Config {enable: false}
function testVoiceCallRinging() {
    log:print("\n -------------------------Starting CallRingingEvent-------------------------------------------------");
    log:print("twilioWebhook -> testVoiceCallRinging()");
    twilio:StatusCallback statusCallback = {
        url: callbackUrl,
        method: POST,
        events: [RINGING]
    };
    runtime:sleep(10);
    var details = twilioClient->makeVoiceCall(fromNumber, toNumber, twimlUrl, statusCallback);
    log:print("\n ------------The call needn't to be answered--------------------------------------------------------");
    if (details is twilio:VoiceCallResponse) {
        log:print(details.status.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!callRingingNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }
    test:assertTrue(callRingingNotified, msg = "expected a call to be make and receive a ringing notification");
    log:print("\n -----------------------The End of CallRingingEvent Test--------------------------------------------");
}

@test:Config {enable: false }
function testVoiceCallAnswered() {
    log:print("\n --------------Starting CallAnswerdEvent------------------------------------------------------------");
    log:print("twilioWebhook -> testVoiceCallAnswered()");
    twilio:StatusCallback statusCallback = {
        url: callbackUrl,
        method: POST,
        events: [ANSWERED]
    };
    runtime:sleep(10);
    var details = twilioClient->makeVoiceCall(fromNumber, toNumber, twimlUrl, statusCallback);
    log:print("\n ------------The call should be answered------------------------------------------------------------");
    if (details is twilio:VoiceCallResponse) {
        log:print(details.status.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!callInProgressNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }
    test:assertTrue(callInProgressNotified, msg = "expected a call to be make and receive a answered notification");
    log:print("\n --------------The End of  CallAnswerdEvent Test--------------------------------------------------");
}

@test:Config {enable: false}
function testVoiceCallCompleted() {
    log:print("\n --------------Starting CallCompletedEvent Test-----------------------------------------------------");
    log:print("twilioWebhook -> testVoiceCallCompleted()");
    twilio:StatusCallback statusCallback = {
        url: callbackUrl,
        method: POST,
        events: [COMPLETED]
    };

    runtime:sleep(10);
    var details = twilioClient->makeVoiceCall(fromNumber, toNumber, twimlUrl, statusCallback);
    log:print("\n ------------The call should be answered------------------------------------------------------------");
    if (details is twilio:VoiceCallResponse) {
        log:print(details.status.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!callCompletedNotified && counter >= 0) {
        runtime:sleep(1);
        counter -= 1;
    }

    test:assertTrue(callCompletedNotified, msg = "expected a call to be make and receive a completed notification");
    log:print("\n --------------The End of  CallCompletedEvent Test--------------------------------------------------");
}
