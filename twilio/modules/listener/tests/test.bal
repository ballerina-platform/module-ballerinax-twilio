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

import ballerina/lang.'int as ints;
import ballerina/lang.runtime;
import ballerina/log;
import ballerina/os;
import ballerina/test;
import ballerina/http;

configurable string & readonly twilioAccountSid = os:getEnv("ACCOUNT_SID");
configurable string & readonly twilioAuthToken = os:getEnv("AUTH_TOKEN");
configurable string & readonly fromNumber = os:getEnv("SAMPLE_FROM_MOBILE");
configurable string & readonly toNumber = os:getEnv("SAMPLE_TO_MOBILE");
configurable string & readonly test_message = os:getEnv("SAMPLE_MESSAGE");
configurable string & readonly twimlUrl = os:getEnv("TWIML_URL");
configurable string & readonly callbackUrl = os:getEnv("CALLBACK_URL");
configurable string & readonly port = os:getEnv("PORT");

int PORT = check ints:fromString(port);
listener Listener twilioListener = new (PORT, twilioAuthToken, callbackUrl);

@test:BeforeSuite
isolated function beforeSuit() {
    log:printInfo("Listener Started");
    runtime:sleep(10);
}

service / on twilioListener {
    isolated remote function onSmsSent(SmsStatusChangeEvent event) returns error? {
        log:printInfo("Received onSmsSent-message ", eventMsg = event);
    }
    isolated remote function onSmsDelivered(SmsStatusChangeEvent event) returns error? {
        log:printInfo("Received onSmsDelivered-message ", eventMsg = event);
    }
}

http:Client httpClient = checkpanic new("http://localhost:8080/onChange");

@test:Config {}
function testOnSmsSent() returns @tainted error? {
    http:Request request = new;
    json payload = {SmsSid:"SMa0244efd22094511a99a27282a98ea02", SmsStatus:"sent", From:"%2B14156620230",
                    To:"%2B94776718102", ApiVersion:"2010-04-01", MessageSid:"SMa0244efd22094511a99a27282a98ea02",
                    AccountSid:"AC0c2ca82ba8140a1a3af02adb5d307a88", MessageStatus:"sent"};
    request.setPayload(payload);
    request.setHeader("Content-type","application/x-www-form-urlencoded");

    var response = httpClient->post("/", request);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 200);
    } else {
        test:assertFail("Twilio listener onSmsSent test failed");
    }
}

@test:Config {}
function testOnSmsDelivered() returns @tainted error? {
    http:Request request = new;
    json payload = {SmsSid:"SMa0244efd22094511a99a27282a98ea02", SmsStatus:"delivered", From:"%2B14156620230",
                    To:"%2B94776718102", ApiVersion:"2010-04-01", MessageSid:"SMa0244efd22094511a99a27282a98ea02",
                    AccountSid:"AC0c2ca82ba8140a1a3af02adb5d307a88", MessageStatus:"delivered"};
    request.setPayload(payload);
    request.setHeader("Content-type","application/x-www-form-urlencoded");

    var response = httpClient->post("/", request);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 200);
    } else {
        test:assertFail("Twilio listener onSmsDelivered test failed");
    }
}

@test:AfterSuite {}
isolated function AfterSuite() {
    runtime:sleep(10);    
    log:printInfo("Listener Stopped");
}
