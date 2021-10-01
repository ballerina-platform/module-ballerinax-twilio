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

# Description
#
# + SmsSid - Twilio SID of the SMS  
# + SmsStatus - Status of the SMS  
# + From - From phone number  
# + To - To phone number  
# + ApiVersion - Twilio API version  
# + MessageSid - Message SID  
# + AccountSid - Account SID  
# + ToCountry - To country of the SMS
# + ToState - To state of the SMS  
# + SmsMessageSid - SMS message SID  
# + NumMedia - Number Media  
# + ToCity - To city of the SMS  
# + FromZip - From Zip of the SMS  
# + FromState - From State of the SMS  
# + FromCity - From City of the SMS  
# + Body - Body of the SMS  
# + FromCountry - From country of the SMS  
# + ToZip - To zip of the SMS  
# + NumSegments - Number segments of the SMS  
# + MessageStatus - Message Status  
public type SmsStatusChangeEvent record {|
    string SmsSid?;
    string SmsStatus?;
    string From?;
    string To?;
    string? ApiVersion?;
    string MessageSid?;
    string AccountSid?;
    string ToCountry?;
    string? ToState?;
    string? SmsMessageSid?;
    string NumMedia?;
    string? ToCity?;
    string? FromZip?;
    string? FromState?;
    string? FromCity?;
    string? Body?;
    string FromCountry?;
    string? ToZip?;
    string NumSegments?;
    string? MessageStatus?;
|};

# Description
#
# + AccountSid - Account SID  
# + ApiVersion - Twilio API version  
# + CallSid - Call SID  
# + CallStatus - A descriptive status for the call  
# + Called - The called number
# + CalledCity - The city of the call  
# + CalledCountry - The country of the call  
# + CalledState - The state of the call  
# + CalledZip - The zip of the call  
# + Caller - The caller number  
# + CallerCountry - The country of the caller  
# + CallDuration - Duration of the call  
# + CallerCity - The city of the caller  
# + CallerZip - The zip of the caller  
# + CallerState - The state of the caller  
# + Direction - The direction of the call  
# + Duration - Time duration of the call  
# + From - From phone number of the call  
# + FromCity - From city of the call  
# + FromCountry - From country of the call  
# + FromState - From state of the call  
# + FromZip - From zip of the call  
# + To - To phone number of the call  
# + ToCity - To city of the call   
# + ToCountry - To country of the call  
# + ToZip - To zip of the call  
# + ToState - To state of the call  
# + Timestamp - Timestamp of the call  
# + CallbackSource - The source of the webhook   
# + SequenceNumber - The order in which the events were fired, starting from 0  
# + SipResponseCode - The SIP code that resulted in a failed call 
public type CallStatusChangeEvent record {|
    string AccountSid?;
    string? ApiVersion?;
    string CallSid?;
    string CallStatus?;
    string Called?;
    string? CalledCity?;
    string CalledCountry?;
    string? CalledState?;
    string? CalledZip?;
    string Caller?;
    string CallerCountry?;
    string CallDuration?;
    string? CallerCity?;
    string? CallerZip?;
    string? CallerState?;
    string Direction?;
    string Duration?;
    string From?;
    string? FromCity?;
    string FromCountry?;
    string? FromState?;
    string? FromZip?;
    string To?;
    string? ToCity?;
    string ToCountry?;
    string? ToZip?;
    string? ToState?;
    string Timestamp?;
    string CallbackSource?;
    string SequenceNumber?;
    string SipResponseCode?;
|};

# Union type for status   
public type TwilioEvent CallStatusChangeEvent|SmsStatusChangeEvent;
