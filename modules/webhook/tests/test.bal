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

import ballerina/config;
import ballerina/test;
import ballerina/websub;
import ballerinax/twilio;
import ballerina/runtime;
import ballerina/log;
import ballerina/lang.'int as ints;

string port = config:getAsString("PORT");
string fromMobile = config:getAsString("SAMPLE_FROM_MOBILE");
string toMobile = config:getAsString("SAMPLE_TO_MOBILE");
string message = config:getAsString("SAMPLE_MESSAGE");
string twimlUrl = config:getAsString("SAMPLE_TWIML_URL");
string statusCallbackUrl = config:getAsString("STATUS_CALLBACK_URL");

int PORT = check ints:fromString(port);
listener TwilioWebhookListener twilioListener = new (PORT);

boolean smsQueuedNotified = false;
boolean smsSentNotified = false;
boolean smsRecievedNotified = false;
boolean callQueuedNotified = false;
boolean callRingingNotified = false;
boolean callInProgressNotified = false;
boolean callCompletedNotified = false;


// Mock service for testing webhook events

@websub:SubscriberServiceConfig {subscribeOnStartUp: false}
service websub:SubscriberService /twilio on twilioListener {
    remote function onNotification(websub:Notification notification) {

        var payload = twilioListener.getEventType(notification);

        if (payload is SmsEvent) {

            if (payload.SmsStatus === QUEUED) {
                smsQueuedNotified = true;
            } else if (payload.SmsStatus === SENT) {
                smsSentNotified = true;
            } else if (payload.SmsStatus === RECEIVED) {
                smsRecievedNotified = true;
            }

        } else if (payload is CallEvent) {

            if (payload.CallStatus === QUEUED) {
                callQueuedNotified = true;
            } else if (payload.CallStatus === RINGING) {
                callRingingNotified = true;
            } else if (payload.CallStatus === IN_PROGRESS) {
                callInProgressNotified = true;
            } else if (payload.CallStatus === COMPLETED) {
                callCompletedNotified = true;
            }
        }
    }

}

// Test functions for twilio webhook events

twilio:TwilioConfiguration twilioConfig = {
    accountSId: config:getAsString("ACCOUNT_SID"),
    authToken: config:getAsString("AUTH_TOKEN"),
    xAuthyKey: config:getAsString("AUTHY_API_KEY")
};

twilio:Client twilioClient = new (twilioConfig);

@test:Config {enable: false}
function testSmsQueued() {

    var details = twilioClient->sendSms(fromMobile, toMobile, message, statusCallbackUrl);
    if (details is twilio:SmsResponse) {
        log:print(details.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!smsQueuedNotified && counter >= 0) {
        runtime:sleep(1000);
        counter -= 1;
    }

    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioWebhook -> recieveSmsQueued()");

    test:assertTrue(smsSentNotified, msg = "expected a sms to be send and receive a queued notification");

}

@test:Config {enable: false}
function testSmsSent() {

    var details = twilioClient->sendSms(fromMobile, toMobile, message, statusCallbackUrl);
    if (details is twilio:SmsResponse) {
        log:print(details.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!smsSentNotified && counter >= 0) {
        runtime:sleep(1000);
        counter -= 1;
    }

    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioWebhook -> testSmsSent()");

    test:assertTrue(smsSentNotified, msg = "expected a sms to be send and receive a sent notification");
}

@test:Config {enable: false}
function testVoiceCallRinging() {

    twilio:StatusCallback statusCallback = {
        url: statusCallbackUrl,
        method: POST,
        events: [RINGING]
    };

    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlUrl, statusCallback);
    if (details is twilio:VoiceCallResponse) {
        log:print(details.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!callRingingNotified && counter >= 0) {
        runtime:sleep(1000);
        counter -= 1;
    }

    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioWebhook -> testVoiceCallRinging()");

    test:assertTrue(callRingingNotified, msg = "expected a call to be make and receive a ringing notification");

}

@test:Config {enable: false, dependsOn: ["testVoiceCallRinging"]}
function testVoiceCallAnswered() {

    twilio:StatusCallback statusCallback = {
        url: statusCallbackUrl,
        method: POST,
        events: [ANSWERED]
    };

    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlUrl, statusCallback);
    if (details is twilio:VoiceCallResponse) {
        log:print(details.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!callInProgressNotified && counter >= 0) {
        runtime:sleep(1000);
        counter -= 1;
    }

    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioWebhook -> testVoiceCallAnswered()");

    test:assertTrue(callInProgressNotified, msg = "expected a call to be make and receive a answered notification");

}

@test:Config {enable: false, dependsOn: ["testVoiceCallAnswered"]}
function testVoiceCallCompleted() {

    twilio:StatusCallback statusCallback = {
        url: statusCallbackUrl,
        method: POST,
        events: [COMPLETED]
    };


    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlUrl, statusCallback);
    if (details is twilio:VoiceCallResponse) {
        log:print(details.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }

    int counter = 50;
    while (!callCompletedNotified && counter >= 0) {
        runtime:sleep(1000);
        counter -= 1;
    }

    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioWebhook -> testVoiceCallCompleted()");

    test:assertTrue(callCompletedNotified, msg = "expected a call to be make and receive a completed notification");

}

