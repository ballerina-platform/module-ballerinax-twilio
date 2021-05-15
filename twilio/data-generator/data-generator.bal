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
import ballerina/io;
import ballerina/os;
import ballerinax/twilio;
import ballerinax/twilio.'listener as twilioListener;

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

// Constants
string COMMA = ",";
string SQUARE_BRACKET_LEFT = "[";
string SQUARE_BRACKET_RIGHT = "]";

twilio:TwilioConfiguration twilioConfig = {
    accountSId: twilioAccountSid,
    authToken: twilioAuthToken
};
twilio:Client twilioClient = new (twilioConfig);
string connecterVersion = "0.99.8";

// Configuration related to data generation
final string rootPath = "./data/";
final string fileExtension = "_data.json";

// Output files
string Account = rootPath + "Account"+fileExtension;
string SmsResponse = rootPath + "SmsResponse"+fileExtension;
string MessageResourceResponse = rootPath + "MessageResourceResponse"+fileExtension;
string WhatsAppResponse = rootPath + "WhatsAppResponse"+fileExtension;
string VoiceCallResponse = rootPath + "VoiceCallResponse"+fileExtension;
string SmsStatusChangeEvent = rootPath + "SmsStatusChangeEvent"+fileExtension;
string CallStatusChangeEvent = rootPath + "CallStatusChangeEvent"+fileExtension;

public function main() returns error? {
    _ = check generateAccountData();
    _ = check generateSmsResponseData();
    _ = check generateMessageResourceResponseData();
    _ = check generateWhatsAppResponseData();
    _ = check generateVoiceCallResponseData();
    _ = check generateOnSmsReceivedData();
    _ = check generateOnCallCompletedData();
}

function generateAccountData() returns error? {
    log:printInfo("SampleDataGenerator -> generateAccountData()");
    twilio:Account details1 = check twilioClient->getAccountDetails();
    twilio:Account details2 = check twilioClient->getAccountDetails();
    twilio:Account details3 = check twilioClient->getAccountDetails();
    string array = SQUARE_BRACKET_LEFT + details1.toJsonString() + COMMA 
                                + details2.toJsonString() + COMMA + details3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/twilio:"+connecterVersion+":Account\""+":"+array+"}";
    check io:fileWriteJson(Account, check preparedJson.cloneWithType(json));                   
}

function generateSmsResponseData() returns error? {
    log:printInfo("SampleDataGenerator -> generateSmsResponseData()");
    string fromMobile = fromNumber;
    string toMobile = toNumber;
    string message = test_message;
    twilio:SmsResponse details1 = check twilioClient->sendSms(fromMobile, toMobile, message);
    twilio:SmsResponse details2 = check twilioClient->sendSms(fromMobile, toMobile, message);
    twilio:SmsResponse details3 = check twilioClient->sendSms(fromMobile, toMobile, message);
    string array = SQUARE_BRACKET_LEFT + details1.toJsonString() + COMMA 
                                + details2.toJsonString() + COMMA + details3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/twilio:"+connecterVersion+":SmsResponse\""+":"+array+"}";
    check io:fileWriteJson(SmsResponse, check preparedJson.cloneWithType(json));     
}

function generateMessageResourceResponseData() returns error? {
    log:printInfo("SampleDataGenerator -> generateMessageResourceResponseData()");    
    twilio:MessageResourceResponse details1 = check twilioClient->getMessage(messageSid);
    twilio:MessageResourceResponse details2 = check twilioClient->getMessage(messageSid);
    twilio:MessageResourceResponse details3 = check twilioClient->getMessage(messageSid);
    string array = SQUARE_BRACKET_LEFT + details1.toJsonString() + COMMA 
                                + details2.toJsonString() + COMMA + details3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/twilio:"+connecterVersion+":MessageResourceResponse\""+":"+array+"}";
    check io:fileWriteJson(MessageResourceResponse, check preparedJson.cloneWithType(json));     
}

function generateWhatsAppResponseData() returns error? {
    log:printInfo("SampleDataGenerator -> generateWhatsAppResponseData()"); 
    string fromMobile = fromWhatsappNumber;
    string toMobile = toNumber;
    string message = test_message;
    twilio:WhatsAppResponse details1 = check twilioClient->sendWhatsAppMessage(fromMobile, toMobile, message);
    twilio:WhatsAppResponse details2 = check twilioClient->sendWhatsAppMessage(fromMobile, toMobile, message);
    twilio:WhatsAppResponse details3 = check twilioClient->sendWhatsAppMessage(fromMobile, toMobile, message);
    string array = SQUARE_BRACKET_LEFT + details1.toJsonString() + COMMA 
                                + details2.toJsonString() + COMMA + details3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/twilio:"+connecterVersion+":WhatsAppResponse\""+":"+array+"}";
    check io:fileWriteJson(WhatsAppResponse, check preparedJson.cloneWithType(json));
}

function generateVoiceCallResponseData() returns error? {
    log:printInfo("SampleDataGenerator -> generateVoiceCallResponseData()"); 
    string fromMobile = fromNumber;
    string toMobile = toNumber;
    string twimlURL = twimlUrl;
    twilio:VoiceCallResponse details = check twilioClient->makeVoiceCall(fromMobile, toMobile, twimlURL);
    string array = SQUARE_BRACKET_LEFT + details.toJsonString() + COMMA 
                                + details.toJsonString() + COMMA + details.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/twilio:"+connecterVersion+":VoiceCallResponse\""+":"+array+"}";
    check io:fileWriteJson(VoiceCallResponse, check preparedJson.cloneWithType(json));
}

function generateOnSmsReceivedData() returns error? {
    log:printInfo("SampleDataGenerator -> generateOnSmsReceivedData()");
    twilioListener:SmsStatusChangeEvent details1 = {
        SmsSid : "SM2e6fe086f168eaafadd052ab5a9625a7",
        SmsStatus : "received",
        From : "%2B94756485071",
        To : "%2B18304838828",
        ApiVersion : "2010-04-01",
        MessageSid : "SM2e6fe086f168eaafadd052ab5a9625a7",
        AccountSid : "ACafcf4fc305eb56b37750abb5050fe9bd",
        ToCountry : "US",
        ToState : "TX",
        SmsMessageSid : "SM2e6fe086f168eaafadd052ab5a9625a7",
        NumMedia : "0",
        ToCity : "COTULLA",
        Body : "Adios",
        FromCountry : "LK",
        ToZip : "78014",
        NumSegments : "1" 
    };

    twilioListener:SmsStatusChangeEvent details2 = {
        SmsSid : "SM12142ee87c7b6ef12ec358c499778992",
        SmsStatus : "received",
        From : "%2B94756485071",
        To : "%2B18304838828",
        ApiVersion : "2010-04-01",
        MessageSid : "SM12142ee87c7b6ef12ec358c499778992",
        AccountSid : "ACafcf4fc305eb56b37750abb5050fe9bd",
        ToCountry : "US",
        ToState : "DE",
        SmsMessageSid : "SM12142ee87c7b6ef12ec358c499778992",
        NumMedia : "0",
        ToCity : "DOVER",
        Body : "Hello US",
        FromCountry : "LK",
        ToZip : "19901",
        NumSegments : "1" 
    };

    twilioListener:SmsStatusChangeEvent details3 = {
        SmsSid : "SM2e6fe086f168eaafadd052ab5a9625a7",
        SmsStatus : "received",
        From : "%2B94756485071",
        To : "%2B18304838828",
        ApiVersion : "2010-04-01",
        MessageSid : "SM2e6fe086f168eaafadd052ab5a9625a7",
        AccountSid : "ACafcf4fc305eb56b37750abb5050fe9bd",
        ToCountry : "US",
        ToState : "ID",
        SmsMessageSid : "SM2e6fe086f168eaafadd052ab5a9625a7",
        NumMedia : "0",
        ToCity : "BOISE",
        Body : "Hello from Srilanka",
        FromCountry : "LK",
        ToZip : "83702",
        NumSegments : "1" 
    };

    string array = SQUARE_BRACKET_LEFT + details1.toJsonString() + COMMA 
                                + details1.toJsonString() + COMMA + details1.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/SmsStatusChangeEvent:"+connecterVersion+":SmsStatusChangeEvent\""+":"+array+"}";
    check io:fileWriteJson(SmsStatusChangeEvent, check preparedJson.cloneWithType(json));
}

function generateOnCallCompletedData() returns error? {
    log:printInfo("SampleDataGenerator -> generateOnCallCompletedData()");
    twilioListener:CallStatusChangeEvent details1 = {
        "AccountSid":"AC1096e2715af9d49f2baa66fc26449122",
        "ApiVersion":"2010-04-01",
        "CallSid":"CA8a53d76030cbd2aabf235def8f8c426f",
        "CallStatus":"completed",
        "Called":"%2B447588744864",
        "CalledCountry":"GB",
        "Caller":"%2B94775856964",
        "CallerCountry":"LK",
        "CallDuration":"3",
        "Direction":"inbound",
        "Duration":"1",
        "From":"%2B94775856964",
        "FromCountry":"LK",
        "To":"%2B447588744864",
        "ToCountry":"GB",
        "Timestamp":"Sat%2C%2015%20May%202021%2004%3A17%3A08%20%2B0000",
        "CallbackSource":"call-progress-events",
        "SequenceNumber":"0"
    };

    twilioListener:CallStatusChangeEvent details2 = {
        "AccountSid":"AC1096e2715af9d49f2baa66fc26449122",
        "ApiVersion":"2010-04-01",
        "CallSid":"CA8a53d76030cbd2aabf235def8f8c426f",
        "CallStatus":"completed",
        "Called":"%2B447588744864",
        "CalledCountry":"GB",
        "Caller":"%2B94775856964",
        "CallerCountry":"LK",
        "CallDuration":"5",
        "Direction":"inbound",
        "Duration":"1",
        "From":"%2B94775856964",
        "FromCountry":"LK",
        "To":"%2B447588744864",
        "ToCountry":"GB",
        "Timestamp":"Sat%2C%2015%20May%202021%2004%3A17%3A08%20%2B0000",
        "CallbackSource":"call-progress-events",
        "SequenceNumber":"0"
    };

    twilioListener:CallStatusChangeEvent details3 = {
        "AccountSid":"AC1096e2715af9d49f2baa66fc26449122",
        "ApiVersion":"2010-04-01",
        "CallSid":"CA8a53d76030cbd2aabf235def8f8c426f",
        "CallStatus":"completed",
        "Called":"%2B447588744864",
        "CalledCountry":"GB",
        "Caller":"%2B94775856964",
        "CallerCountry":"LK",
        "CallDuration":"7",
        "Direction":"inbound",
        "Duration":"1",
        "From":"%2B94775856964",
        "FromCountry":"LK",
        "To":"%2B447588744864",
        "ToCountry":"GB",
        "Timestamp":"Sat%2C%2015%20May%202021%2004%3A17%3A08%20%2B0000",
        "CallbackSource":"call-progress-events",
        "SequenceNumber":"0"
    };

    string array = SQUARE_BRACKET_LEFT + details1.toJsonString() + COMMA 
                                + details2.toJsonString() + COMMA + details3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/SmsStatusChangeEvent:"+connecterVersion+":CallStatusChangeEvent\""+":"+array+"}";
    check io:fileWriteJson(CallStatusChangeEvent, check preparedJson.cloneWithType(json));
}
