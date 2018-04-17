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

import ballerina/http;

documentation {
    F{{sid}} Unique identifier of the account
    F{{name}} The name of the account
    F{{status}} The status of the account (active, suspended, closed)
    F{{^"type"}} The type of this account (Trial, Full)
    F{{createdDate}} The date that this account was created
    F{{updatedDate}} The date that this account was last updated
}
public type Account {
    string sid;
    string name;
    string status;
    string ^"type";
    string createdDate;
    string updatedDate;
};

documentation {
    F{{sid}} Unique identifier of the account
    F{{status}} Status of the voice call (queued, failed, sent, delivered, undelivered)
    F{{price}} The price amount of the sms
    F{{priceUnit}} The price currency
}
public type SmsResponse {
    string sid;
    string status;
    string price;
    string priceUnit;
};

documentation {
    F{{sid}} Unique identifier of the account
    F{{status}} Status of the voice call (queued, initiated, ringing, answered, completed)
    F{{price}} The price amount of the call
    F{{priceUnit}} The price currency
}
public type VoiceCallResponse {
    string sid;
    string status;
    string price;
    string priceUnit;
};
