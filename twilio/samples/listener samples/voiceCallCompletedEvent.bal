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
import ballerinax/twilio.'listener as twilioListener;

configurable string & readonly twilioAccountSid = ?;
configurable string & readonly twilioAuthToken = ?;
configurable string & readonly fromNumber = ?;
configurable string & readonly toNumber = ?;
configurable string & readonly test_message = ?;
configurable string & readonly twimlUrl = ?;
configurable string & readonly callbackUrl = ?;
configurable int & readonly port = ?;

listener twilioListener:Listener tListener = new (port, twilioAuthToken, callbackUrl);

service / on tListener {
    remote function onCallCompleted(twilioListener:CallStatusChangeEvent event) returns error? {
        log:printInfo("Completed", event);
    }
}
