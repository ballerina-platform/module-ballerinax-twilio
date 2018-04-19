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

function mapJsonToAccount(json jsonPayload) returns Account {
    Account account = {};
    account.sid = jsonPayload.sid.toString();
    account.name = jsonPayload.friendly_name.toString();
    account.status = jsonPayload.status.toString();
    account.^"type" = jsonPayload.^"type".toString();
    account.createdDate = jsonPayload.date_created.toString();
    account.updatedDate = jsonPayload.date_updated.toString();
    return account;
}

function mapJsonToSmsResponse(json jsonPayload) returns SmsResponse {
    SmsResponse smsResponse = {};
    smsResponse.sid = jsonPayload.sid.toString();
    smsResponse.status = jsonPayload.status.toString();
    smsResponse.price = jsonPayload.price.toString();
    smsResponse.priceUnit = jsonPayload.price_unit.toString();
    return smsResponse;
}

function mapJsonToVoiceCallResponse(json jsonPayload) returns VoiceCallResponse {
    VoiceCallResponse voiceCallResponse = {};
    voiceCallResponse.sid = jsonPayload.sid.toString();
    voiceCallResponse.status = jsonPayload.status.toString();
    voiceCallResponse.price = jsonPayload.price.toString();
    voiceCallResponse.priceUnit = jsonPayload.price_unit.toString();
    return voiceCallResponse;
}

function mapJsonToAuthyAppDetailsResponse(json jsonPayload) returns AuthyAppDetailsResponse {
    AuthyAppDetailsResponse authyAppDetailsResponse = {};
    authyAppDetailsResponse.appId = jsonPayload.app.app_id.toString();
    authyAppDetailsResponse.name = jsonPayload.app.name.toString();
    authyAppDetailsResponse.plan = jsonPayload.app.plan.toString();
    authyAppDetailsResponse.isSmsEnabled = <boolean>jsonPayload.app.sms_enabled.toString();
    authyAppDetailsResponse.isPhoneCallsEnabled = <boolean>jsonPayload.app.phone_calls_enabled.toString();
    authyAppDetailsResponse.isOnetouchEnabled = <boolean>jsonPayload.app.onetouch_enabled.toString();
    authyAppDetailsResponse.message = jsonPayload.message.toString();
    authyAppDetailsResponse.isSuccess = <boolean>jsonPayload.success.toString();
    return authyAppDetailsResponse;
}

function mapJsonToAuthyUserAddRespones(json jsonPayload) returns AuthyUserAddResponse {
    AuthyUserAddResponse authyUserAddResponse = {};
    authyUserAddResponse.userId = jsonPayload.user.id.toString();
    authyUserAddResponse.message = jsonPayload.message.toString();
    authyUserAddResponse.isSuccess = <boolean>jsonPayload.success.toString();
    return authyUserAddResponse;
}

function mapJsonToAuthyUserStatusResponse(json jsonPayload) returns AuthyUserStatusResponse {
    AuthyUserStatusResponse authyUserStatusResponse = {};
    authyUserStatusResponse.userId = jsonPayload.status.authy_id.toString();
    authyUserStatusResponse.isConfirmed = <boolean>jsonPayload.status.confirmed.toString();
    authyUserStatusResponse.isRegistered = <boolean>jsonPayload.status.registered.toString();
    authyUserStatusResponse.countryCode = jsonPayload.status.country_code.toString();
    authyUserStatusResponse.phoneNumber = jsonPayload.status.phone_number.toString();
    authyUserStatusResponse.isAccountDisabled = <boolean>jsonPayload.status.account_disabled.toString();
    authyUserStatusResponse.message = jsonPayload.message.toString();
    authyUserStatusResponse.isSuccess = <boolean>jsonPayload.success.toString();
    return authyUserStatusResponse;
}

function mapJsonToAuthyUserDeleteResponse(json jsonPayload) returns AuthyUserDeleteResponse {
    AuthyUserDeleteResponse authyUserDeleteResponse = {};
    authyUserDeleteResponse.message = jsonPayload.message.toString();
    authyUserDeleteResponse.isSuccess = <boolean>jsonPayload.success.toString();
    return authyUserDeleteResponse;
}

function mapJsonToAuthyUserSecretResponse(json jsonPayload) returns AuthyUserSecretResponse {
    AuthyUserSecretResponse authyUserSecretResponse = {};
    authyUserSecretResponse.issuer = jsonPayload.issuer.toString();
    authyUserSecretResponse.label = jsonPayload.label.toString();
    authyUserSecretResponse.qrCodeUrl = jsonPayload.qr_code.toString();
    authyUserSecretResponse.isSuccess = <boolean>jsonPayload.success.toString();
    return authyUserSecretResponse;
}

function mapJsonToAuthyOtpResponse(json jsonPayload) returns AuthyOtpResponse {
    AuthyOtpResponse authyOtpResponse = {};
    authyOtpResponse.message = jsonPayload.message.toString();
    authyOtpResponse.cellphone = jsonPayload.cellphone.toString();
    authyOtpResponse.device = jsonPayload.device.toString();
    authyOtpResponse.isIgnored = <boolean>jsonPayload.ignored.toString();
    authyOtpResponse.isSuccess = <boolean>jsonPayload.success.toString();
    return authyOtpResponse;
}

function mapJsonToAuthyOtpVerifyResponse(json jsonPayload) returns AuthyOtpVerifyResponse {
    AuthyOtpVerifyResponse authyOtpVerifyResponse = {};
    authyOtpVerifyResponse.message = jsonPayload.message.toString();
    authyOtpVerifyResponse.token = jsonPayload.token.toString();
    authyOtpVerifyResponse.isSuccess = <boolean>jsonPayload.success.toString();
    return authyOtpVerifyResponse;
}
