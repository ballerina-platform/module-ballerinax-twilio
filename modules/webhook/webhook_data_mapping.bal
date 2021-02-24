//Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

isolated function mapPayloadToCallEvent(map<string> payload) returns TwilioEvent {
    CallStatusChangeEvent callStatusChangeEvent = {};
    callStatusChangeEvent.AccountSid = payload["account_sid"].toString();
    callStatusChangeEvent.ApiVersion = payload["api_version"].toString();
    callStatusChangeEvent.CallSid = payload["CallSid"].toString();
    callStatusChangeEvent.CallStatus = payload["CallStatus"].toString();
    callStatusChangeEvent.Called = payload["Called"].toString();
    callStatusChangeEvent.CalledCity = payload["CalledCity"].toString();
    callStatusChangeEvent.CalledCountry = payload["CalledCountry"].toString();
    callStatusChangeEvent.CalledState = payload["CalledState"].toString();
    callStatusChangeEvent.CalledZip = payload["CalledZip"].toString();
    callStatusChangeEvent.Caller = payload["Caller"].toString();
    callStatusChangeEvent.CallerCity = payload["CallerCity"].toString();
    callStatusChangeEvent.CallerCountry = payload["CallerCountry"].toString();
    callStatusChangeEvent.CallerState = payload["CallerState"].toString();
    callStatusChangeEvent.CallerZip = payload["CallerZip"].toString();
    callStatusChangeEvent.Direction = payload["Direction"].toString();
    callStatusChangeEvent.From = payload["From"].toString();
    callStatusChangeEvent.FromCity = payload["FromCity"].toString();
    callStatusChangeEvent.FromCountry = payload["FromCountry"].toString();
    callStatusChangeEvent.FromState = payload["FromState"].toString();
    callStatusChangeEvent.FromZip = payload["FromZip"].toString();
    callStatusChangeEvent.To = payload["To"].toString();
    callStatusChangeEvent.ToCity = payload["ToCity"].toString();
    callStatusChangeEvent.ToCountry = payload["ToCountry"].toString();
    callStatusChangeEvent.ToState = payload["ToState"].toString();
    callStatusChangeEvent.ToZip = payload["ToZip"].toString();
    callStatusChangeEvent.SipResponseCode = payload["SipResponseCode"].toString();
    callStatusChangeEvent.Timestamp = payload["Timestamp"].toString();
    callStatusChangeEvent.CallbackSource = payload["CallbackSource"].toString();
    callStatusChangeEvent.SequenceNumber = payload["SequenceNumber"].toString();
    return callStatusChangeEvent;
}

isolated function mapPayloadToSMSEvent(map<string> payload) returns TwilioEvent {
    SmsStatusChangeEvent smsStatusChangeEvent= {};
    smsStatusChangeEvent.SmsSid = payload["SmsSid"].toString();
    smsStatusChangeEvent.SmsStatus = payload["SmsStatus"].toString();
    smsStatusChangeEvent.From = payload["From"].toString();
    smsStatusChangeEvent.To = payload["To"].toString();
    smsStatusChangeEvent.ApiVersion = payload["ApiVersion"].toString();
    smsStatusChangeEvent.MessageSid = payload["MessageSid"].toString();
    smsStatusChangeEvent.AccountSid = payload["AccountSid"].toString();
    smsStatusChangeEvent.ToCountry = payload["ToCountry"].toString();
    smsStatusChangeEvent.ToState = payload["ToState"].toString();
    smsStatusChangeEvent.SmsMessageSid = payload["SmsMessageSid"].toString();
    smsStatusChangeEvent.NumMedia = payload["NumMedia"].toString();
    smsStatusChangeEvent.ToCity = payload["ToCity"].toString();
    smsStatusChangeEvent.FromZip = payload["FromZip"].toString();
    smsStatusChangeEvent.FromState = payload["FromState"].toString();
    smsStatusChangeEvent.FromCity = payload["FromCity"].toString();
    smsStatusChangeEvent.Body = payload["Body"].toString();
    smsStatusChangeEvent.FromCountry = payload["FromCountry"].toString();
    smsStatusChangeEvent.ToZip = payload["ToZip"].toString();
    smsStatusChangeEvent.NumSegments = payload["NumSegments"].toString();
    smsStatusChangeEvent.MessageStatus = payload["MessageStatus"].toString();
    return smsStatusChangeEvent;
}


