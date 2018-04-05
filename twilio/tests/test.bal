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

package tests;

import ballerina/io;
import ballerina/log;
import ballerina/test;

endpoint TwilioEndpoint twilioEP {
    accountSid:ACCOUNT_SID,
    authToken:AUTH_TOKEN,
    uri:BASE_URL
};

@test:Config {
    groups:["network-calls"]
}
function testAccountDetails () {
    log:printInfo("twilioEndpoint -> getAccountDetails()");
    var details = twilioEP -> getAccountDetails();
    match details {
        Account account => {
            io:println(account);
            test:assertTrue(account.sid != EMPTY_STRING);
        }
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testSendSms () {
    log:printInfo("twilioEndpoint -> sendSms()");
    var details = twilioEP -> sendSms(FROM_MOBILE, TO_MOBILE, MESSAGE);
    match details {
        SmsResponse smsResponse => {
            io:println(smsResponse);
            test:assertTrue(smsResponse.sid != EMPTY_STRING);
        }
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testMakeVoiceCall () {
    log:printInfo("twilioEndpoint -> makeVoiceCall()");
    var details = twilioEP -> makeVoiceCall(FROM_MOBILE, TO_MOBILE, TWIML_URL);
    match details {
        VoiceCallResponse voiceCallResponse => {
            io:println(voiceCallResponse);
            test:assertTrue(voiceCallResponse.sid != EMPTY_STRING);
        }
        error err => test:assertFail(msg = err.message);
    }
}
