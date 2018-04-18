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
    account.sid = jsonPayload.sid.toString() but { () => EMPTY_STRING };
    account.name = jsonPayload.friendly_name.toString() but { () => EMPTY_STRING };
    account.status = jsonPayload.status.toString() but { () => EMPTY_STRING };
    account.^"type" = jsonPayload.^"type".toString() but { () => EMPTY_STRING };
    account.createdDate = jsonPayload.date_created.toString() but { () => EMPTY_STRING };
    account.updatedDate = jsonPayload.date_updated.toString() but { () => EMPTY_STRING };
    return account;
}

function mapJsonToSmsResponse(json jsonPayload) returns SmsResponse {
    SmsResponse smsResponse = {};
    smsResponse.sid = jsonPayload.sid.toString() but { () => EMPTY_STRING };
    smsResponse.status = jsonPayload.status.toString() but { () => EMPTY_STRING };
    smsResponse.price = jsonPayload.price.toString() but { () => EMPTY_STRING };
    smsResponse.priceUnit = jsonPayload.price_unit.toString() but { () => EMPTY_STRING };
    return smsResponse;
}

function mapJsonToVoiceCallResponse(json jsonPayload) returns VoiceCallResponse {
    VoiceCallResponse voiceCallResponse = {};
    voiceCallResponse.sid = jsonPayload.sid.toString() but { () => EMPTY_STRING };
    voiceCallResponse.status = jsonPayload.status.toString() but { () => EMPTY_STRING };
    voiceCallResponse.price = jsonPayload.price.toString() but { () => EMPTY_STRING };
    voiceCallResponse.priceUnit = jsonPayload.price_unit.toString() but { () => EMPTY_STRING };
    return voiceCallResponse;
}

function mapJsonToAuthyAppDetailsResponse(json jsonPayload) returns AuthyAppDetailsResponse {
    AuthyAppDetailsResponse authyAppDetailsResponse = {};
    authyAppDetailsResponse.appId = jsonPayload.app.app_id.toString() but { () => EMPTY_STRING };
    authyAppDetailsResponse.name = jsonPayload.app.name.toString() but { () => EMPTY_STRING };
    authyAppDetailsResponse.plan = jsonPayload.app.plan.toString() but { () => EMPTY_STRING };
    authyAppDetailsResponse.isSmsEnabled = jsonPayload.app.sms_enabled but { () => false };
    authyAppDetailsResponse.isPhoneCallsEnabled = jsonPayload.app.phone_calls_enabled but { () => false };
    authyAppDetailsResponse.isOnetouchEnabled = jsonPayload.app.onetouch_enabled but { () => false };
    authyAppDetailsResponse.message = jsonPayload.message but { () => EMPTY_STRING };
    authyAppDetailsResponse.isSuccess = jsonPayload.success but { () => false };
    return authyAppDetailsResponse;
}

function mapJsonToAuthyUserAddRespones(json jsonPayload) returns AuthyUserAddResponse {
    AuthyUserAddResponse authyUserAddResponse = {};
    authyUserAddResponse.userId = jsonPayload.user.id.toString() but { () => EMPTY_STRING };
    authyUserAddResponse.message = jsonPayload.message but { () => EMPTY_STRING };
    authyUserAddResponse.isSuccess = jsonPayload.success but { () => false };
    return authyUserAddResponse;
}

function mapJsonToAuthyUserStatusResponse(json jsonPayload) returns AuthyUserStatusResponse {
    AuthyUserStatusResponse authyUserStatusResponse = {};
    authyUserStatusResponse.userId = jsonPayload.status.authy_id.toString() but { () => EMPTY_STRING };
    authyUserStatusResponse.isConfirmed = jsonPayload.status.confirmed but { () => false };
    authyUserStatusResponse.isRegistered = jsonPayload.status.registered but { () => false };
    authyUserStatusResponse.countryCode = jsonPayload.status.country_code.toString() but { () => EMPTY_STRING };
    authyUserStatusResponse.phoneNumber = jsonPayload.status.phone_number.toString() but { () => EMPTY_STRING };
    authyUserStatusResponse.isAccountDisabled = jsonPayload.status.account_disabled but { () => false };
    authyUserStatusResponse.message = jsonPayload.message but { () => EMPTY_STRING };
    authyUserStatusResponse.isSuccess = jsonPayload.success but { () => false };
    return authyUserStatusResponse;
}

function mapJsonToAuthyUserDeleteResponse(json jsonPayload) returns AuthyUserDeleteResponse {
    AuthyUserDeleteResponse authyUserDeleteResponse = {};
    authyUserDeleteResponse.message = jsonPayload.message but { () => EMPTY_STRING };
    authyUserDeleteResponse.isSuccess = jsonPayload.success but { () => false };
    return authyUserDeleteResponse;
}

function mapJsonToAuthyUserSecretResponse(json jsonPayload) returns AuthyUserSecretResponse {
    AuthyUserSecretResponse authyUserSecretResponse = {};
    authyUserSecretResponse.issuer = jsonPayload.issuer.toString() but { () => EMPTY_STRING };
    authyUserSecretResponse.label = jsonPayload.label.toString() but { () => EMPTY_STRING };
    authyUserSecretResponse.qrCodeUrl = jsonPayload.qr_code.toString() but { () => EMPTY_STRING };
    authyUserSecretResponse.isSuccess = jsonPayload.success but { () => false };
    return authyUserSecretResponse;
}

function mapJsonToAuthyOtpResponse(json jsonPayload) returns AuthyOtpResponse {
    AuthyOtpResponse authyOtpResponse = {};
    authyOtpResponse.message = jsonPayload.message.toString() but { () => EMPTY_STRING };
    authyOtpResponse.cellphone = jsonPayload.cellphone.toString() but { () => EMPTY_STRING };
    authyOtpResponse.device = jsonPayload.device.toString() but { () => EMPTY_STRING };
    authyOtpResponse.isIgnored = jsonPayload.ignored but { () => false };
    authyOtpResponse.isSuccess = jsonPayload.success but { () => false };
    return authyOtpResponse;
}

function mapJsonToAuthyOtpVerifyResponse(json jsonPayload) returns AuthyOtpVerifyResponse {
    AuthyOtpVerifyResponse authyOtpVerifyResponse = {};
    authyOtpVerifyResponse.message = jsonPayload.message.toString() but { () => EMPTY_STRING };
    authyOtpVerifyResponse.token = jsonPayload.token.toString() but { () => EMPTY_STRING };
    string isSuccess = jsonPayload.success.toString() but { () => "false" };
    authyOtpVerifyResponse.isSuccess = <boolean>isSuccess;
    return authyOtpVerifyResponse;
}
