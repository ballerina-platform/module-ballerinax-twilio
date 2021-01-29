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

public type SmsStatusChangeEvent record {|
    string SmsSid;
    string SmsStatus;
    string From;
    string To;
    string ApiVersion;
    string MessageSid;
    string AccountSid;
    string MessageStatus;
|};

public type IncomingSmsEvent record {|
    string SmsSid;
    string SmsStatus;
    string From;
    string To;
    string ApiVersion;
    string MessageSid;
    string AccountSid;
    string ToCountry="";
    string ToState="";
    string SmsMessageSid;
    string NumMedia?; 
    string ToCity?; 
    string FromZip=""; 
    string FromState="";
    string FromCity="";
    string Body?;
    string FromCountry?; 
    string ToZip="";
    string NumSegments;
|};

public type CallStatusChangeEvent record {|

    string AccountSid; 
    string ApiVersion; 
    string CallSid; 
    string CallStatus;  
    string Called;
    string CalledCity=""; 
    string CalledCountry; 
    string CalledState="";
    string CalledZip="";
    string Caller; 
    string CallerCountry?; 
    string CallerCity; 
    string CallerZip?; 
    string CallerState?; 
    string Direction; 
    string From; 
    string FromCity=""; 
    string FromCountry; 
    string FromState=""; 
    string FromZip=""; 
    string To; 
    string ToCity=""; 
    string ToCountry; 
    string ToZip="";
    string ToState="";
    string Timestamp; 
    string CallbackSource; 
    string SequenceNumber; 
    string SipResponseCode?;
|};

public type IncomingCallEvent record {|
    string AccountSid; 
    string ApiVersion; 
    string CallSid; 
    string CallStatus;  
    string Called;  
    string CalledCity; 
    string CalledCountry; 
    string CalledState?;
    string CalledZip?;
    string Caller; 
    string CallDuration?;
    string CallerCity?; 
    string CallerCountry?; 
    string CallerState?; 
    string CallerZip?; 
    string Direction;  
    string From; 
    string FromCity=""; 
    string FromCountry?; 
    string FromState=""; 
    string FromZip=""; 
    string To; 
    string ToCity?; 
    string ToCountry; 
    string ToState="";
    string ToZip="";
    string SipResponseCode?;
|};

public type CallRecordingEvent record {|
    string AccountSid;
    string CallSid;
    string RecordingSid;
    string RecordingUrl;
    string RecordingStatus;
    float RecordingDuration;
    int RecordingChanels;
    string RecordingStartTime;
    string RecordingSource;
    string RecordingTrack;
|};

public type TwilioEvent IncomingCallEvent|CallStatusChangeEvent|IncomingSmsEvent|SmsStatusChangeEvent;
