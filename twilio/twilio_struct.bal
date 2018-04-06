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
// under the License.package twilio;

package twilio;

@Description {value:"Struct to set the Twilio cnfiguration."}
public struct TwilioConfiguration {
    string accountSid;
    string authToken;
    string uri;
    http:ClientEndpointConfiguration clientConfig;
}

@Description {value:"Struct for Twilio endpoint."}
public struct TwilioEndpoint {
    TwilioConfiguration twilioConfig;
    TwilioConnector twilioConnector;
}

@Description {value:"Struct to initialize the connection with Twilio."}
public struct TwilioConnector {
    string accountSid;
    string authToken;
    http:ClientEndpoint clientEndpoint;
}

@Description {value:"Struct to get the details of a project."}
public struct Account {
    string sid;
    string name;
    string status;
    string ^"type";
    string createdDate;
    string updatedDate;
}

@Description {value:"Struct to get the details of a sms sending."}
public struct SmsResponse {
    string sid;
    string status;
    string price;
    string priceUnit;
}

@Description {value:"Struct to get the details of a making voice call."}
public struct VoiceCallResponse {
    string sid;
    string status;
    string price;
    string priceUnit;
}
