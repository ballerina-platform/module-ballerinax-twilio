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
string testUserId = "";

// This is message SID that provided by twilio.
string messageSid = "";

// ACCOUNT_SID, AUTH_TOKEN, AUTHY_API_KEY should be changed with your own account credentials

configurable string twilioAccountSid = os:getEnv("ACCOUNT_SID");
configurable string twilioAuthToken = os:getEnv("AUTH_TOKEN");
configurable string fromNumber = os:getEnv("SAMPLE_FROM_MOBILE");
configurable string toNumber = os:getEnv("SAMPLE_TO_MOBILE");
configurable string test_message = os:getEnv("SAMPLE_MESSAGE");
configurable string fromWhatsappNumber = os:getEnv("SAMPLE_WHATSAPP_SANDBOX");
configurable string twimlUrl = os:getEnv("SAMPLE_TWIML_URL");

TwilioConfiguration twilioConfig = {
    accountSId: twilioAccountSid,
    authToken: twilioAuthToken
};
Client twilioClient = new (twilioConfig);

@test:Config {
    groups: ["basic", "root"],
    enable: true
}
function testAccountDetails() {
    TwilioConfiguration twilioConfig = {
        accountSId: twilioAccountSid,
        authToken: twilioAuthToken
    };
    Client twilioClient = new (twilioConfig);
    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioClient -> getAccountDetails()");
    var details = twilioClient->getAccountDetails();
    if (details is Account) {
        log:print("Account Name: " + details.name.toBalString());
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
    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioClient -> sendSms()");
    string fromMobile = fromNumber;
    string toMobile = toNumber;
    string message = test_message;
    var details = twilioClient->sendSms(fromMobile, toMobile, message);
    if (details is SmsResponse) {
        log:print("SMS_SID: " + details.sid.toBalString() + ", Body: " + details.body.toBalString());
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
    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioClient -> getMessage()");
    var details = twilioClient->getMessage(messageSid);
    if (details is MessageResourceResponse) {
        log:print("MESSAGE_SID: " + details.sid.toBalString() + ", Body: " + details.body.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }
}

@test:Config {
    groups: ["basic"],
    dependsOn: [testAccountDetails],
    enable: true
}
function testSendWhatsAppMessage() {
    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioClient -> sendWhatsAppMessage()");
    string fromMobile = fromWhatsappNumber;
    string toMobile = toNumber;
    string message = test_message;
    var details = twilioClient->sendWhatsAppMessage(fromMobile, toMobile, message);
    if (details is WhatsAppResponse) {
        log:print("WhatsAPP_MSID: " + details.sid.toBalString() + ", Body: " + details.body.toBalString());
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
    log:print("\n ---------------------------------------------------------------------------");
    log:print("twilioClient -> makeVoiceCall()");
    string fromMobile = fromNumber;
    string toMobile = toNumber;
    string twimlURL = twimlUrl;
    var details = twilioClient->makeVoiceCall(fromMobile, toMobile, twimlURL);
    if (details is VoiceCallResponse) {
        log:print(details.sid.toBalString());
    } else {
        test:assertFail(msg = details.message());
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                  Authy Releated Operation will not be support by the connector at the moment                       //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@test:Config {
//     groups: ["authy", "root"],
//     enable: true
// }
// function testAuthyAppDetails() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> getAuthyAppDetails()");

//     var details = twilioClient->getAuthyAppDetails();
//     if (details is AuthyAppDetailsResponse) {
//         log:print(details.toBalString());
//     } else {
//         test:assertFail(msg = details.message());
//     }
// }

// @test:Config {
//     groups: ["authy"],
//     dependsOn: [testAuthyAppDetails],
//     enable: true
// }
// function testAuthyUserAdd() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> addAuthyUser()");

//     string email = "";
//     string phone = "";
//     string countryCode = "";

//     var details = twilioClient->addAuthyUser(email, phone, countryCode);
//     if (details is AuthyUserAddResponse) {
//         log:print(details.toBalString());
//         testUserId = <@untainted>details.userId;
//     } else {
//         test:assertFail(msg = details.message());
//     }
// }

// @test:Config {
//     groups: ["authy"],
//     dependsOn: [testAuthyUserAdd],
//     enable: true
// }
// function testAuthyUserStatus() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> getAuthyUserStatus()");

//     var details = twilioClient->getAuthyUserStatus(testUserId);
//     if (details is AuthyUserStatusResponse) {
//         log:print(details.toBalString());
//     } else {
//         test:assertFail(msg = details.message());
//     }
// }

// @test:Config 
// {
//     groups: ["authy"],
//     dependsOn: 
//     [testAuthyUserAdd, testAuthyUserStatus, testAuthyUserSecret, testAuthyOtpViaSms, testAuthyOtpViaCall, testAuthyOtpVerify],
//     enable: true
// }
// function testAuthyUserDelete() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> deleteAuthyUser()");

//     var details = twilioClient->deleteAuthyUser(testUserId);
//     if (details is AuthyUserDeleteResponse) {
//         log:print(details.toBalString());
//     } else {
//         test:assertFail(msg = details.message());
//     }
// }

// @test:Config {
//     groups: ["authy"],
//     dependsOn: [testAuthyUserAdd],
//     enable: true
// }
// function testAuthyUserSecret() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> getAuthyUserSecret()");

//     var details = twilioClient->getAuthyUserSecret(testUserId);
//     if (details is AuthyUserSecretResponse) {
//         log:print(details.toBalString());
//     } else {
//         test:assertFail(msg = details.message());
//     }
// }

// @test:Config {
//     groups: ["authy"],
//     dependsOn: [testAuthyUserAdd],
//     enable: true
// }
// function testAuthyOtpViaSms() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> requestOtpViaSms()");

//     var details = twilioClient->requestOtpViaSms(testUserId);
//     if (details is AuthyOtpResponse) {
//         log:print(details.toBalString());
//     } else {
//         test:assertFail(msg = details.message());
//     }
// }

// @test:Config {
//     groups: ["authy"],
//     dependsOn: [testAuthyUserAdd],
//     enable: true
// }
// function testAuthyOtpViaCall() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> requestOtpViaCall()");

//     var details = twilioClient->requestOtpViaCall(testUserId);
//     if (details is AuthyOtpResponse) {
//         log:print(details.toBalString());
//     } else {
//         test:assertFail(msg = details.message());
//     }
// }

// @test:Config {
//     groups: ["authy"],
//     dependsOn: [testAuthyUserAdd],
//     enable: true
// }
// function testAuthyOtpVerify() {
//     log:print("\n ---------------------------------------------------------------------------");
//     log:print("twilioClient -> verifyOtp()");

//     string token = "8875458";

//     var details = twilioClient->verifyOtp(testUserId, token);
//     if (details is AuthyOtpVerifyResponse) {
//         log:print(details.toBalString());
//     } else {
//         // This always returns a error since the token should be what the user get.
//         log:print(details.message());
//     }
// }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                          End of Authy App Releated Tests                                                           //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////