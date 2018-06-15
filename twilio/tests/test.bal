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

// This user-id is initialized after the testAuthyUserAdd() function call and will be used for testAuthyUserDelete()
string tmpUserId;

// ACCOUNT_SID, AUTH_TOKEN, AUTHY_API_KEY should be changed with your own account credentials
endpoint Client twilioClient {
    accountSId:config:getAsString(ACCOUNT_SID),
    authToken:config:getAsString(AUTH_TOKEN),
    xAuthyKey:config:getAsString(AUTHY_API_KEY)
};

@test:Config {
    groups:["basic", "root"]
}
function testAccountDetails() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAccountDetails()");

    var details = twilioClient->getAccountDetails();
    match details {
        Account account => io:println(account);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["basic"],
    dependsOn:["testAccountDetails"]
}
function testSendSms() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> sendSms()");

    string fromMobile = config:getAsString("SAMPLE_FROM_MOBILE");
    string toMobile = config:getAsString("SAMPLE_TO_MOBILE");
    string message = config:getAsString("SAMPLE_MESSAGE");

    var details = twilioClient->sendSms(fromMobile, toMobile, message);
    match details {
        SmsResponse smsResponse => io:println(smsResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["basic"],
    dependsOn:["testAccountDetails"]
}
function testMakeVoiceCall() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> makeVoiceCall()");

    string fromMobile = config:getAsString("SAMPLE_FROM_MOBILE");
    string toMobile = config:getAsString("SAMPLE_TO_MOBILE");
    string twimlUrl = config:getAsString("SAMPLE_TWIML_URL");

    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlUrl);
    match details {
        VoiceCallResponse voiceCallResponse => io:println(voiceCallResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy", "root"]
}
function testAuthyAppDetails() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAuthyAppDetails()");

    var details = twilioClient->getAuthyAppDetails();
    match details {
        AuthyAppDetailsResponse authyAppDetailsResponse => io:println(authyAppDetailsResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy"],
    dependsOn:["testAuthyAppDetails"]
}
function testAuthyUserAdd() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> addAuthyUser()");

    string email = config:getAsString("SAMPLE_USER_EMAIL");
    string phone = config:getAsString("SAMPLE_USER_PHONE");
    string countryCode = config:getAsString("SAMPLE_USER_COUNTRY_CODE");

    var details = twilioClient->addAuthyUser(email, phone, countryCode);
    match details {
        AuthyUserAddResponse authyUserAddResponse => {
            io:println(authyUserAddResponse);
            tmpUserId = authyUserAddResponse.userId;
        }
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy"],
    dependsOn:["testAuthyUserAdd"]
}
function testAuthyUserStatus() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAuthyUserStatus()");

    var details = twilioClient->getAuthyUserStatus(tmpUserId);
    match details {
        AuthyUserStatusResponse authyUserStatusResponse => io:println(authyUserStatusResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy"],
    dependsOn:["testAuthyUserAdd", "testAuthyUserStatus", "testAuthyUserSecret", "testAuthyOtpViaSms",
    "testAuthyOtpViaCall", "testAuthyOtpVerify"]
}
function testAuthyUserDelete() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> deleteAuthyUser()");

    var details = twilioClient->deleteAuthyUser(tmpUserId);
    match details {
        AuthyUserDeleteResponse authyUserDeleteResponse => io:println(authyUserDeleteResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy"],
    dependsOn:["testAuthyUserAdd"]
}
function testAuthyUserSecret() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> getAuthyUserSecret()");

    var details = twilioClient->getAuthyUserSecret(tmpUserId);
    match details {
        AuthyUserSecretResponse authyUserSecretResponse => io:println(authyUserSecretResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy"],
    dependsOn:["testAuthyUserAdd"]
}
function testAuthyOtpViaSms() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> requestOtpViaSms()");

    var details = twilioClient->requestOtpViaSms(tmpUserId);
    match details {
        AuthyOtpResponse authyOtpResponse => io:println(authyOtpResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy"],
    dependsOn:["testAuthyUserAdd"]
}
function testAuthyOtpViaCall() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> requestOtpViaCall()");

    var details = twilioClient->requestOtpViaCall(tmpUserId);
    match details {
        AuthyOtpResponse authyOtpResponse => io:println(authyOtpResponse);
        TwilioError twilioError => test:assertFail(msg = twilioError.message);
    }
}

@test:Config {
    groups:["authy"],
    dependsOn:["testAuthyUserAdd"]
}
function testAuthyOtpVerify() {
    io:println("\n ---------------------------------------------------------------------------");
    log:printInfo("twilioClient -> verifyOtp()");

    string token = "8875458";

    var details = twilioClient->verifyOtp(tmpUserId, token);
    match details {
        AuthyOtpVerifyResponse authyOtpVerifyResponse => io:println(authyOtpVerifyResponse);
        // This always returns a TwilioError since the token should be what the user get.
        TwilioError twilioError => io:println(twilioError.message);
    }
}
