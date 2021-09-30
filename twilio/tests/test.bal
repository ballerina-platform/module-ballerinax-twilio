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
// under the License.

import ballerina/log;
import ballerina/test;
import ballerina/os;

// This user-id is initialized after the testAuthyUserAdd() function call and will be used for testAuthyUserDelete()
string testUserId = EMPTY_STRING;

// This is message SID that provided by twilio.
string messageSid = EMPTY_STRING;

// ACCOUNT_SID, AUTH_TOKEN, AUTHY_API_KEY should be changed with your own account credentials
configurable string twilioAccountSid = os:getEnv("ACCOUNT_SID");
configurable string twilioAuthToken = os:getEnv("AUTH_TOKEN");
configurable string fromNumber = os:getEnv("SAMPLE_FROM_MOBILE");
configurable string toNumber = os:getEnv("SAMPLE_TO_MOBILE");
configurable string test_message = os:getEnv("SAMPLE_MESSAGE");
configurable string fromWhatsappNumber = os:getEnv("SAMPLE_WHATSAPP_SANDBOX");
configurable string twimlUrl = os:getEnv("SAMPLE_TWIML_URL");
configurable string twilioAPIKey = os:getEnv("twilioAPIKey");
configurable string twilioAPISecret = os:getEnv("twilioAPISecret");

ConnectionConfig twilioConfig = {
    auth: {
        accountSId: twilioAccountSid,
        authToken: twilioAuthToken
    }
};

// ConnectionConfig twilioConfig = {
//     auth: {
//         accountSId: twilioAccountSid,
//         apiKey: twilioAPIKey,
//         apiSecret: twilioAPISecret
//     }
// };

Client twilioClient = check new (twilioConfig);

@test:Config {
    groups: ["basic", "root"],
    enable: true
}
function testAccountDetails() {
    log:printInfo("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAccountDetails()");
    var details = twilioClient->getAccountDetails();
    if (details is Account) {
        log:printInfo("Account Name: " + details.name.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: [testAccountDetails],
    enable: true
}
function testSendSms() {
    log:printInfo("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> sendSms()");
    string fromMobile = fromNumber;
    string toMobile = toNumber;
    string message = test_message;
    var details = twilioClient->sendSms(fromMobile, toMobile, message);
    if (details is SmsResponse) {
        log:printInfo("SMS_SID: " + details.sid.toBalString() + ", Body: " + details.body.toBalString());
        messageSid = <@untainted>details.sid;
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: [testAccountDetails, testSendSms],
    enable: true
}
function testGetMessage() {
    log:printInfo("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getMessage()");
    var details = twilioClient->getMessage(messageSid);
    if (details is MessageResourceResponse) {
        log:printInfo("MESSAGE_SID: " + details.sid.toBalString() + ", Body: " + details.body.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: [testAccountDetails],
    enable: false
}
function testSendWhatsAppMessage() {
    log:printInfo("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> sendWhatsAppMessage()");
    string fromMobile = fromWhatsappNumber;
    string toMobile = toNumber;
    string message = test_message;
    var details = twilioClient->sendWhatsAppMessage(fromMobile, toMobile, message);
    if (details is WhatsAppResponse) {
        log:printInfo("WhatsAPP_MSID: " + details.sid.toBalString() + ", Body: " + details.body.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: [testAccountDetails],
    enable: true
}
function testMakeVoiceCall() {
    log:printInfo("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> makeVoiceCall()");
    string fromMobile = fromNumber;
    string toMobile = toNumber;
    //Set string Message or Twiml Link
    //string twimlURL = twimlUrl; 
    string message = "This is a test call from eco system team";
    VoiceCallInput voiceInput = { userInput:message, userInputType: MESSAGE_IN_TEXT};
    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, voiceInput);
    if (details is VoiceCallResponse) {
        log:printInfo(details.sid.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }
}
