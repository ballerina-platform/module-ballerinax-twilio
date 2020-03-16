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

import ballerina/lang.'boolean;

function mapJsonToAccount(json jsonPayload) returns Account {
    Account account = {};
    account.sid = jsonPayload.sid.toString();
    account.name = jsonPayload.friendly_name.toString();
    account.status = jsonPayload.status.toString();
    account.'type =jsonPayload.'type.toString();
    account.createdDate = jsonPayload.date_created.toString();
    account.updatedDate = jsonPayload.date_updated.toString();
    return account;
}

function mapJsonToSmsResponse(json jsonPayload) returns SmsResponse {
    SmsResponse smsResponse = {};
    smsResponse.sid = jsonPayload.sid.toString();
    smsResponse.dateCreated = jsonPayload.date_created.toString();
    smsResponse.dateUpdated = jsonPayload.date_updated.toString();
    smsResponse.dateSent = jsonPayload.date_sent.toString();
    smsResponse.accountSid = jsonPayload.account_sid.toString();
    smsResponse.toNumber = jsonPayload.to.toString();
    smsResponse.fromNumber = jsonPayload.'from.toString();
    smsResponse.body = jsonPayload.body.toString();
    smsResponse.status = jsonPayload.status.toString();
    smsResponse.direction = jsonPayload.direction.toString();
    smsResponse.apiVersion = jsonPayload.api_version.toString();
    smsResponse.price = jsonPayload.price.toString();
    smsResponse.priceUnit = jsonPayload.price_unit.toString();
    smsResponse.uri = jsonPayload.uri.toString();
    smsResponse.numSegments = jsonPayload.num_segments.toString();

    return smsResponse;
}

function mapJsonToWhatsAppResponse(json jsonPayload) returns WhatsAppResponse {
    WhatsAppResponse whatsAppResponse = {};
    whatsAppResponse.sid = jsonPayload.sid.toString();
    whatsAppResponse.dateCreated = jsonPayload.date_created.toString();
    whatsAppResponse.dateUpdated = jsonPayload.date_updated.toString();
    whatsAppResponse.dateSent = jsonPayload.date_sent.toString();
    whatsAppResponse.accountSid = jsonPayload.account_sid.toString();
    whatsAppResponse.toNumber = jsonPayload.to.toString();
    whatsAppResponse.fromNumber = jsonPayload.'from.toString();
    whatsAppResponse.messageServiceSid = jsonPayload.messaging_service_sid.toString();
    whatsAppResponse.body = jsonPayload.body.toString();
    whatsAppResponse.status = jsonPayload.status.toString();
    whatsAppResponse.numSegments = jsonPayload.num_segments.toString();
    whatsAppResponse.numMedia = jsonPayload.num_media.toString();
    whatsAppResponse.direction = jsonPayload.direction.toString();
    whatsAppResponse.apiVersion = jsonPayload.api_version.toString();
    whatsAppResponse.price = jsonPayload.price.toString();
    whatsAppResponse.priceUnit = jsonPayload.price_unit.toString();
    whatsAppResponse.errorCode = jsonPayload.error_code.toString();
    whatsAppResponse.errorMessage = jsonPayload.error_message.toString();
    whatsAppResponse.subresourceUris = jsonPayload.subresource_uris.toString();
    return whatsAppResponse;
}

function mapJsonToVoiceCallResponse(json jsonPayload) returns VoiceCallResponse {
    VoiceCallResponse voiceCallResponse = {};
    voiceCallResponse.sid = jsonPayload.sid.toString();
    voiceCallResponse.status = jsonPayload.status.toString();
    voiceCallResponse.price = jsonPayload.price.toString();
    voiceCallResponse.priceUnit = jsonPayload.price_unit.toString();
    return voiceCallResponse;
}

function mapJsonToAuthyAppDetailsResponse(json jsonPayload) returns AuthyAppDetailsResponse|error {
    AuthyAppDetailsResponse authyAppDetailsResponse = {};
    authyAppDetailsResponse.appId = jsonPayload.app.app_id.toString();
    authyAppDetailsResponse.name = jsonPayload.app.name.toString();
    authyAppDetailsResponse.plan = jsonPayload.app.plan.toString();
    authyAppDetailsResponse.isSmsEnabled = check 'boolean:fromString(jsonPayload.app.sms_enabled.toString());
    authyAppDetailsResponse.isPhoneCallsEnabled = check 'boolean:fromString(jsonPayload.app.phone_calls_enabled.toString());
    authyAppDetailsResponse.isOnetouchEnabled = check 'boolean:fromString(jsonPayload.app.onetouch_enabled.toString());
    authyAppDetailsResponse.message = jsonPayload.message.toString();
    authyAppDetailsResponse.isSuccess = check 'boolean:fromString(jsonPayload.success.toString());
    return authyAppDetailsResponse;
}

function mapJsonToAuthyUserAddRespones(json jsonPayload) returns AuthyUserAddResponse|error {
    AuthyUserAddResponse authyUserAddResponse = {};
    authyUserAddResponse.userId = jsonPayload.user.id.toString();
    authyUserAddResponse.message = jsonPayload.message.toString();
    authyUserAddResponse.isSuccess = check 'boolean:fromString(jsonPayload.success.toString());
    return authyUserAddResponse;
}

function mapJsonToAuthyUserStatusResponse(json jsonPayload) returns AuthyUserStatusResponse|error {
    AuthyUserStatusResponse authyUserStatusResponse = {};
    authyUserStatusResponse.userId = jsonPayload.status.authy_id.toString();
    authyUserStatusResponse.isConfirmed = check 'boolean:fromString(jsonPayload.status.confirmed.toString());
    authyUserStatusResponse.isRegistered = check 'boolean:fromString(jsonPayload.status.registered.toString());
    authyUserStatusResponse.countryCode = jsonPayload.status.country_code.toString();
    authyUserStatusResponse.phoneNumber = jsonPayload.status.phone_number.toString();
    authyUserStatusResponse.isAccountDisabled = check 'boolean:fromString(jsonPayload.status.account_disabled.toString());
    authyUserStatusResponse.message = jsonPayload.message.toString();
    authyUserStatusResponse.isSuccess = check 'boolean:fromString(jsonPayload.success.toString());
    return authyUserStatusResponse;
}

function mapJsonToAuthyUserDeleteResponse(json jsonPayload) returns AuthyUserDeleteResponse|error {
    AuthyUserDeleteResponse authyUserDeleteResponse = {};
    authyUserDeleteResponse.message = jsonPayload.message.toString();
    authyUserDeleteResponse.isSuccess = check 'boolean:fromString(jsonPayload.success.toString());
    return authyUserDeleteResponse;
}

function mapJsonToAuthyUserSecretResponse(json jsonPayload) returns AuthyUserSecretResponse|error {
    AuthyUserSecretResponse authyUserSecretResponse = {};
    authyUserSecretResponse.issuer = jsonPayload.issuer.toString();
    authyUserSecretResponse.label = jsonPayload.label.toString();
    authyUserSecretResponse.qrCodeUrl = jsonPayload.qr_code.toString();
    authyUserSecretResponse.isSuccess = check 'boolean:fromString(jsonPayload.success.toString());
    return authyUserSecretResponse;
}

function mapJsonToAuthyOtpResponse(json jsonPayload) returns AuthyOtpResponse|error {
    AuthyOtpResponse authyOtpResponse = {};
    authyOtpResponse.message = jsonPayload.message.toString();
    authyOtpResponse.cellphone = jsonPayload.cellphone.toString();
    authyOtpResponse.isIgnored = check 'boolean:fromString(jsonPayload.ignored.toString());
    authyOtpResponse.isSuccess = check 'boolean:fromString(jsonPayload.success.toString());
    return authyOtpResponse;
}

function mapJsonToAuthyOtpVerifyResponse(json jsonPayload) returns AuthyOtpVerifyResponse|error {
    AuthyOtpVerifyResponse authyOtpVerifyResponse = {};
    authyOtpVerifyResponse.message = jsonPayload.message.toString();
    authyOtpVerifyResponse.token = jsonPayload.token.toString();
    authyOtpVerifyResponse.isSuccess = check 'boolean:fromString(jsonPayload.success.toString());
    return authyOtpVerifyResponse;
}
