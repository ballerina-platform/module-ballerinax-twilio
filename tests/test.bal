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

import ballerina/config;
import ballerina/io;
import ballerina/log;
import ballerina/test;

// This user-id is initialized after the testAuthyUserAdd() function call and will be used for testAuthyUserDelete()
string testUserId = "";

// ACCOUNT_SID, AUTH_TOKEN, AUTHY_API_KEY should be changed with your own account credentials
TwilioConfiguration twilioConfig = {
    accountSId: config:getAsString(ACCOUNT_SID),
    authToken: config:getAsString(AUTH_TOKEN),
    xAuthyKey: config:getAsString(AUTHY_API_KEY)
};
Client twilioClient = new(twilioConfig);

@test:Config {
    groups: ["basic", "root"]
}
function testAccountDetails() {
    TwilioConfiguration twilioConfig = {
        accountSId: config:getAsString(ACCOUNT_SID),
        authToken: config:getAsString(AUTH_TOKEN),
        xAuthyKey: config:getAsString(AUTHY_API_KEY)
    };
    Client twilioClient = new(twilioConfig);

    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAccountDetails()");

    var details = twilioClient->getAccountDetails();
    if (details is Account) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: ["testAccountDetails"]
}
function testSendSms() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> sendSms()");

    string fromMobile = config:getAsString("SAMPLE_FROM_MOBILE");
    string toMobile = config:getAsString("SAMPLE_TO_MOBILE");
    string message = config:getAsString("SAMPLE_MESSAGE");


    var details = twilioClient->sendSms(fromMobile, toMobile, message);
    if (details is SmsResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: ["testAccountDetails"]
}
function testSendWhatsAppMessage() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> sendWhatsAppMessage()");

    string fromMobile = config:getAsString("SAMPLE_WHATSAPP_SANDBOX");
    string toMobile = config:getAsString("SAMPLE_TO_MOBILE");
    string message = config:getAsString("SAMPLE_MESSAGE");

    var details = twilioClient->sendWhatsAppMessage(fromMobile, toMobile, message);
    if (details is WhatsAppResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: ["testAccountDetails"]
}
function testMakeVoiceCall() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> makeVoiceCall()");

    string fromMobile = config:getAsString("SAMPLE_FROM_MOBILE");
    string toMobile = config:getAsString("SAMPLE_TO_MOBILE");
    string twimlUrl = config:getAsString("SAMPLE_TWIML_URL");

    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlUrl);
    if (details is VoiceCallResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy", "root"]
}
function testAuthyAppDetails() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAuthyAppDetails()");

    var details = twilioClient->getAuthyAppDetails();
    if (details is AuthyAppDetailsResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy"],
    dependsOn: ["testAuthyAppDetails"]
}
function testAuthyUserAdd() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> addAuthyUser()");

    string email = config:getAsString("SAMPLE_AUTHY_USER_EMAIL");
    string phone = config:getAsString("SAMPLE_AUTHY_USER_PHONE");
    string countryCode = config:getAsString("SAMPLE_AUTHY_USER_COUNTRY_CODE");

    var details = twilioClient->addAuthyUser(email, phone, countryCode);
    if (details is AuthyUserAddResponse) {
        io:println(details);
        testUserId = <@untainted>details.userId;
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy"],
    dependsOn: ["testAuthyUserAdd"]
}
function testAuthyUserStatus() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAuthyUserStatus()");

    var details = twilioClient->getAuthyUserStatus(testUserId);
    if (details is AuthyUserStatusResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy"],
    dependsOn: ["testAuthyUserAdd", "testAuthyUserStatus", "testAuthyUserSecret", "testAuthyOtpViaSms",
    "testAuthyOtpViaCall", "testAuthyOtpVerify"]
}
function testAuthyUserDelete() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> deleteAuthyUser()");

    var details = twilioClient->deleteAuthyUser(testUserId);
    if (details is AuthyUserDeleteResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy"],
    dependsOn: ["testAuthyUserAdd"]
}
function testAuthyUserSecret() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAuthyUserSecret()");

    var details = twilioClient->getAuthyUserSecret(testUserId);
    if (details is AuthyUserSecretResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy"],
    dependsOn: ["testAuthyUserAdd"]
}
function testAuthyOtpViaSms() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> requestOtpViaSms()");

    var details = twilioClient->requestOtpViaSms(testUserId);
    if (details is AuthyOtpResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy"],
    dependsOn: ["testAuthyUserAdd"]
}
function testAuthyOtpViaCall() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> requestOtpViaCall()");

    var details = twilioClient->requestOtpViaCall(testUserId);
    if (details is AuthyOtpResponse) {
        io:println(details);
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["authy"],
    dependsOn: ["testAuthyUserAdd"]
}
function testAuthyOtpVerify() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> verifyOtp()");

    string token = "8875458";

    var details = twilioClient->verifyOtp(testUserId, token);
    if (details is AuthyOtpVerifyResponse) {
        io:println(details);
    } else {
        // This always returns a error since the token should be what the user get.
        io:println(details.message());
    }
}
