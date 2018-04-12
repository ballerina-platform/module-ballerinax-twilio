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

documentation {Object for Twilio endpoint.
    F{{clientConfig}} Reference to http:ClientEndpointConfig type
    F{{twilioConnector}} Reference to TwilioConnector type
}
public type Client object {

    public {
    http:ClientEndpointConfig clientConfig;
        TwilioConnector twilioConnector = new();
    }

documentation { Initialize Twilio endpoint
        P{{clientConfig}} HTTP configuration for Twilio
    }
public function init (http:ClientEndpointConfig clientConfig);

documentation { Register Twilio connector endpoint
        P{{serviceType}} Accepts types of data (int, float, string, boolean, etc)
    }
    public function register (typedesc serviceType);

documentation { Start Twilio connector endpoint }
    public function start ();

documentation { Initialize Twilio endpoint
        R{{}} The Twilio connector object
    }
    public function getClient () returns TwilioConnector;

documentation { Start Twilio connector endpoint }
    public function stop ();
};

documentation {Object to initialize the connection with Twilio.
    F{{accountSid}} Unique identifier of the account
    F{{client}} Http client endpoint
}
public type TwilioConnector object {

    public {
        string accountSid;
        http:Client client;
    }

documentation { Return account details of the given account-sid.
        R{{account}} Account object with basic details
        R{{err}} Error occured when getting account details by http call or parsing the response into json
    }
public function getAccountDetails() returns (Account|error);

documentation { Send sms from the given account-sid
        P{{fromNo}} Mobile number which the SMS should be send from
        P{{toNo}} Mobile number which the SMS should be received to
        P{{message}} Message body of the SMS
        R{{smsResponse}} Sms response object with basic details
        R{{err}} Error occured when sending sms by http call or parsing the response into json
    }
public function sendSms(string fromNo, string toNo, string message) returns (SmsResponse|error);

documentation { Make a voice call from the given account-sid
        P{{fromNo}} Mobile number which the voice call should be send from
        P{{toNo}} Mobile number which the voice call should be received to
        P{{twiml}} TwiML URL which the response of the voice call is stated
        R{{voiceCallResponse}} Voice call response object with basic details
        R{{err}} Error occured when making voice call by http call or parsing the response into json
    }
public function makeVoiceCall(string fromNo, string toNo, string twiml) returns (VoiceCallResponse|error);

};

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
