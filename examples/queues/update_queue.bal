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
import ballerinax/twilio;

configurable string accountSID = os:getEnv("ACCOUNT_SID");
configurable string authToken = os:getEnv("AUTH_TOKEN");

// Twilio configurations
twilio:ConnectionConfig twilioConfig = {
    auth: {
        username: accountSID,
        password: authToken
    }
};

// This sample demonstrates a scenario where Twilio connector is used to update a queue
public function main() returns error? {
    twilio:Client twilio = check new (twilioConfig);
    // QueueSID: An identifier of 34 digits in length that uniquely identifies a queue
    string QueueSID = "QUe770a247b1e6168d6acef1078c3c4828";
    twilio:UpdateQueueRequest queueRequest = {
        FriendlyName: "Sample Queue",
        MaxSize: 2000
    };
    twilio:Queue response = check twilio->updateQueue(QueueSID, queueRequest);
    io:println(response?.friendly_name, response?.max_size);
}
