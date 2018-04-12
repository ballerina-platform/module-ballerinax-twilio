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
// under the License.package tests;

import ballerina/io;
import ballerina/log;
import ballerina/test;
import ballerina/config;

endpoint Client twilioClient {
    accountSid:config:getAsString(ACCOUNT_SID, default = EMPTY_STRING),
    clientConfig:{
        auth:{
            scheme:"basic",
            username:config:getAsString(ACCOUNT_SID, default = EMPTY_STRING),
            password:config:getAsString(AUTH_TOKEN, default = EMPTY_STRING)
        }
    }
};

@test:Config
function testAccountDetails() {
    log:printInfo("twilioClient -> getAccountDetails()");
    var details = twilioClient -> getAccountDetails();
    match details {
        Account account => {
            io:println(account);
            test:assertNotEquals(account.sid, EMPTY_STRING, msg = "Failed to get account details");
        }
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config
function testSendSms() {
    log:printInfo("twilioClient -> sendSms()");
    string fromMobile = config:getAsString(FROM_MOBILE, default = EMPTY_STRING);
    string toMobile = config:getAsString(TO_MOBILE, default = EMPTY_STRING);
    string message = config:getAsString(MESSAGE, default = EMPTY_STRING);
    var details = twilioClient -> sendSms(fromMobile, toMobile, message);
    match details {
        SmsResponse smsResponse => {
            io:println(smsResponse);
            test:assertNotEquals(smsResponse.sid, EMPTY_STRING, msg = "Failed to get sms response details");
        }
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config
function testMakeVoiceCall() {
    log:printInfo("twilioClient -> makeVoiceCall()");
    string fromMobile = config:getAsString(FROM_MOBILE, default = EMPTY_STRING);
    string toMobile = config:getAsString(TO_MOBILE, default = EMPTY_STRING);
    string twimlUrl = config:getAsString(TWIML_URL, default = EMPTY_STRING);
    var details = twilioClient -> makeVoiceCall(fromMobile, toMobile, twimlUrl);
    match details {
        VoiceCallResponse voiceCallResponse => {
            io:println(voiceCallResponse);
            test:assertNotEquals(voiceCallResponse.sid, EMPTY_STRING, msg = "Failed to get voice call response details");
        }
        error err => test:assertFail(msg = err.message);
    }
}