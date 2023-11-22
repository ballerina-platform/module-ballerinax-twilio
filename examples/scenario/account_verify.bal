// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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
import ballerina/io;
import ballerina/os;
import ballerina/random;
import ballerinax/twilio;

// Account configurations
configurable string accountSID = os:getEnv("ACCOUNT_SID");
configurable string authToken = os:getEnv("AUTH_TOKEN");
configurable string twilioPhoneNumber = os:getEnv("PHONE_NUMBER");

public function main() returns error? {
    // Twilio Client configuration
    twilio:ConnectionConfig twilioConfig = {
        auth: {
            username: accountSID,
            password: authToken
        }
    };
    // User Phone Number
    string phoneNumber = "+xxxxxxxxxxx";
    // Initialize Twilio Client
    twilio:Client twilio = check new (twilioConfig);
    // Generate a random verification code
    string|error verificationCode = generateVerificationCode();
    if verificationCode is string {
        check sendSMSVerification(twilio, phoneNumber, verificationCode);
        check makeCallVerification(twilio, phoneNumber, verificationCode);
    }
}

# Generates a random 6 digit verification code
function generateVerificationCode() returns string|error {
    int min = 100000;
    int max = 999999;
    int|error code = random:createIntInRange(min, max);
    if code is error {
        return code;
    }
    return code.toString();
}

# Sends an SMS verification
function sendSMSVerification(twilio:Client twilio, string phoneNumber, string verificationCode) returns error? {
    twilio:CreateMessageRequest messageRequest = {
        To: phoneNumber,
        From: twilioPhoneNumber,
        Body: "Your verification code is: " + verificationCode
    };
    twilio:Message response = check twilio->createMessage(messageRequest);
    io:println("SMS verification sent with status: ", response?.status);
}

# Makes a call verification
function makeCallVerification(twilio:Client twilio, string phoneNumber, string verificationCode) returns error? {
    twilio:CreateCallRequest callRequest = {
        To: phoneNumber,
        From: twilioPhoneNumber,
        Url: "http://yourserver.com/verify-call.xml?code=" + verificationCode
    };
    twilio:Call response = check twilio->createCall(callRequest);
    io:println("Call verification initiated with status: ", response?.status);
}
