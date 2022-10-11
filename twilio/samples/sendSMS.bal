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

import ballerina/log;
import ballerinax/twilio;

configurable string fromMobile = ?;
configurable string toMobile = ?;
configurable string accountSId = ?;
configurable string authToken = ?;
configurable string message = "Wso2-Test-SMS-Message";


public function main() returns error? {
    //Twilio Client configuration
    twilio:ConnectionConfig twilioConfig = {
        twilioAuth: {
            accountSId: accountSId,
            authToken: authToken
        }
    };

    //Twilio Client
    twilio:Client twilioClient = check new (twilioConfig);

    //Send SMS remote function is called by the twilio client
    twilio:SmsResponse response = check twilioClient->sendSms(fromMobile, toMobile, message);
    log:printInfo("SMS_SID: " + response.sid.toString() + ", Body: " + response.body.toString());
}
