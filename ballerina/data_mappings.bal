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

isolated function mapJsonToAccount(map<json> jsonPayload) returns Account|error {
    Account account = {};
    account.sid = jsonPayload["sid"].toString();
    account.name = jsonPayload["friendly_name"].toString();
    account.status = jsonPayload["status"].toString();
    account.'type = jsonPayload["type"].toString();
    account.createdDate = jsonPayload["date_created"].toString();
    account.updatedDate = jsonPayload["date_updated"].toString();
    return account;
}

isolated function mapJsonToSmsResponse(map<json> jsonPayload) returns SmsResponse|error {
    SmsResponse smsResponse = {};
    smsResponse.sid = jsonPayload["sid"].toString();
    smsResponse.dateCreated = jsonPayload["date_created"].toString();
    smsResponse.dateUpdated = jsonPayload["date_updated"].toString();    
    smsResponse.dateSent = jsonPayload["date_sent"].toString();
    smsResponse.accountSid = jsonPayload["account_sid"].toString();
    smsResponse.toNumber = jsonPayload["to"].toString();
    smsResponse.fromNumber = jsonPayload["from"].toString();
    smsResponse.body = jsonPayload["body"].toString();
    smsResponse.status = jsonPayload["status"].toString();
    smsResponse.direction = jsonPayload["direction"].toString();
    smsResponse.apiVersion = jsonPayload["api_version"].toString();
    smsResponse.price = jsonPayload["price"].toString();
    smsResponse.priceUnit = jsonPayload["price_unit"].toString();
    smsResponse.uri = jsonPayload["uri"].toString();
    smsResponse.numSegments = jsonPayload["num_segments"].toString();
    return smsResponse;
}

isolated function mapJsonToWhatsAppResponse(map<json> jsonPayload) returns WhatsAppResponse|error {
    WhatsAppResponse whatsAppResponse = {};
    whatsAppResponse.sid = jsonPayload["sid"].toString();
    whatsAppResponse.dateCreated = jsonPayload["date_created"].toString();
    whatsAppResponse.dateUpdated = jsonPayload["date_updated"].toString();
    whatsAppResponse.dateSent = jsonPayload["date_sent"].toString();
    whatsAppResponse.accountSid = jsonPayload["account_sid"].toString();
    whatsAppResponse.toNumber = jsonPayload["to"].toString();
    whatsAppResponse.fromNumber = jsonPayload["from"].toString();
    whatsAppResponse.messageServiceSid = jsonPayload["messaging_service_sid"].toString();
    whatsAppResponse.body = jsonPayload["body"].toString();
    whatsAppResponse.status = jsonPayload["status"].toString();
    whatsAppResponse.numSegments = jsonPayload["num_segments"].toString();
    whatsAppResponse.numMedia = jsonPayload["num_media"].toString();
    whatsAppResponse.direction = jsonPayload["direction"].toString();
    whatsAppResponse.apiVersion = jsonPayload["api_version"].toString();
    whatsAppResponse.price = jsonPayload["price"].toString();
    whatsAppResponse.priceUnit = jsonPayload["price_unit"].toString();
    whatsAppResponse.errorCode = jsonPayload["error_code"].toString();
    whatsAppResponse.errorMessage = jsonPayload["error_message"].toString();
    whatsAppResponse.subresourceUris = jsonPayload["subresource_uris"].toString();
    return whatsAppResponse;
}

isolated function mapJsonToVoiceCallResponse(map<json> jsonPayload) returns VoiceCallResponse|error {
    VoiceCallResponse voiceCallResponse = {};
    voiceCallResponse.sid = jsonPayload["sid"].toString();
    voiceCallResponse.status = jsonPayload["status"].toString();
    voiceCallResponse.price = jsonPayload["price"].toString();
    voiceCallResponse.priceUnit = jsonPayload["price_unit"].toString();
    return voiceCallResponse;
}

isolated function mapJsonToMessageResourceResponse(map<json> jsonPayload) returns MessageResourceResponse|error {
    MessageResourceResponse messageResourceResponse = {};
    messageResourceResponse.body = jsonPayload["body"].toString();
    messageResourceResponse.numSegments = jsonPayload["num_segments"].toString();
    messageResourceResponse.direction = jsonPayload["direction"].toString();
    messageResourceResponse.fromNumber = jsonPayload["direction"].toString();
    messageResourceResponse.toNumber = jsonPayload["to"].toString();
    messageResourceResponse.dateUpdated = jsonPayload["date_updated"].toString();
    messageResourceResponse.price = jsonPayload["price"].toString();
    messageResourceResponse.errorMessage = jsonPayload["error_message"].toString();
    messageResourceResponse.uri = jsonPayload["uri"].toString();
    messageResourceResponse.accountSid = jsonPayload["account_sid"].toString();
    messageResourceResponse.numMedia = jsonPayload["num_media"].toString();
    messageResourceResponse.status = jsonPayload["status"].toString();
    messageResourceResponse.messagingServiceSid = jsonPayload["messaging_service_sid"].toString();
    messageResourceResponse.sid = jsonPayload["sid"].toString();
    messageResourceResponse.dateSent = jsonPayload["date_sent"].toString();
    messageResourceResponse.dateCreated = jsonPayload["date_created"].toString();
    messageResourceResponse.errorCode = jsonPayload["error_code"].toString();
    messageResourceResponse.priceUnit = jsonPayload["price_unit"].toString();
    messageResourceResponse.apiVersion = jsonPayload["api_version"].toString();
    messageResourceResponse.subresourceUris = jsonPayload["subresource_uris"].toString();
    return messageResourceResponse;
}
