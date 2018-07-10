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
    Represents Twilio account.

    F{{sid}} Unique identifier of the account
    F{{name}} The name of the account
    F{{status}} The status of the account (active, suspended, closed)
    F{{^"type"}} The type of this account (Trial, Full)
    F{{createdDate}} The date that this account was created
    F{{updatedDate}} The date that this account was last updated
}
public type Account record {
    string sid;
    string name;
    string status;
    string ^"type";
    string createdDate;
    string updatedDate;
};

documentation {
    Represents Twilio SMS response.

    F{{sid}} Unique identifier of the account
    F{{status}} Status of the voice call (queued, failed, sent, delivered, undelivered)
    F{{price}} The price amount of the SMS
    F{{priceUnit}} The price currency
}
public type SmsResponse record {
    string sid;
    string status;
    string price;
    string priceUnit;
};

documentation {
    Represents Twilio voice call response.

    F{{sid}} Unique identifier of the account
    F{{status}} Status of the voice call (queued, initiated, ringing, answered, completed)
    F{{price}} The price amount of the call
    F{{priceUnit}} The price currency
}
public type VoiceCallResponse record {
    string sid;
    string status;
    string price;
    string priceUnit;
};

documentation {
    Represents Authy app details response.

    F{{appId}} Unique identifier of the Authy app
    F{{name}} Name of the Authy app
    F{{plan}} The subscribed plan
    F{{isSmsEnabled}} Status of whether SMS is enabled
    F{{isPhoneCallsEnabled}} Status of whether phone call is enabled
    F{{isOnetouchEnabled}} Status of whether one touch is enabled
    F{{message}} A messaging indicating the result of the operation
    F{{isSuccess}} Is the request was success or not
}
public type AuthyAppDetailsResponse record {
    string appId;
    string name;
    string plan;
    boolean isSmsEnabled;
    boolean isPhoneCallsEnabled;
    boolean isOnetouchEnabled;
    string message;
    boolean isSuccess;
};

documentation {
    Represents Authy user adding response.

    F{{userId}} Unique identifier of the user
    F{{message}} A messaging indicating the result of the operation
    F{{isSuccess}} Is the request was success or not
}
public type AuthyUserAddResponse record {
    string userId;
    string message;
    boolean isSuccess;
};

documentation {
    Represents Authy user status response.

    F{{userId}} Unique identifier of the user
    F{{isConfirmed}} Is user confirmed or not
    F{{isRegistered}} Is user registerd or not
    F{{countryCode}} Country code of user
    F{{phoneNumber}} Phone number of user
    F{{isAccountDisabled}} Is account disabled or not
    F{{message}} A messaging indicating the result of the operation
    F{{isSuccess}} Is the request was success or not
}
public type AuthyUserStatusResponse record {
    string userId;
    boolean isConfirmed;
    boolean isRegistered;
    string countryCode;
    string phoneNumber;
    boolean isAccountDisabled;
    string message;
    boolean isSuccess;
};

documentation {
    Represents Authy user delete response.

    F{{message}} A messaging indicating the result of the operation
    F{{isSuccess}} Is the request was success or not
}
public type AuthyUserDeleteResponse record {
    string message;
    boolean isSuccess;
};

documentation {
    Represents Authy user secret response.

    F{{issuer}} Name of the Authy name
    F{{label}} A custom label given by the user. If not, the name of the authy app
    F{{qrCodeUrl}} Url for the generated qr code
    F{{isSuccess}} Is the request was success or not
}
public type AuthyUserSecretResponse record {
    string issuer;
    string label;
    string qrCodeUrl;
    boolean isSuccess;
};

documentation {
    Represents Authy OTP response.

    F{{message}} A messaging indicating the result of the operation
    F{{cellphone}} Phone number used to send the message or call
    F{{device}} The type of the last device used by the user
    F{{isIgnored}} True if we detected an Authy or SDK enabled app installed.
    F{{isSuccess}} Is the request was success or not
}
public type AuthyOtpResponse record {
    string message;
    string cellphone;
    string device;
    boolean isIgnored;
    boolean isSuccess;
};

documentation {
    Represents Authy OTP verify response.

    F{{message}} A messaging indicating the result of the operation
    F{{token}} Either "is valid" or "is invalid"
    F{{isSuccess}} Is the OTP was valid or not
}
public type AuthyOtpVerifyResponse record {
    string message;
    string token;
    boolean isSuccess;
};

documentation {
    Represents Twilio cusotm error.

    F{{message}} A custom message about the error
    F{{cause}} Error object reffered to the occurred error
}
public type TwilioError record {
    string message;
    error? cause;
};
