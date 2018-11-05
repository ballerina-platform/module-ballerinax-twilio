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

import ballerina/http;

# Represents Twilio account.
# + sid - Unique identifier of the account
# + name - The name of the account
# + status - The status of the account (active, suspended, closed)
# + type - The type of this account (`Trial`, `Full`)
# + createdDate - The date that this account was created
# + updatedDate - The date that this account was last updated
public type Account record {
    string sid;
    string name;
    string status;
    string ^"type";
    string createdDate;
    string updatedDate;
};

# Represents Twilio SMS response.
# + sid - Unique identifier of the account
# + status - Status of the voice call (queued, failed, sent, delivered, undelivered)
# + price - The price amount of the SMS
# + priceUnit - The price currency
public type SmsResponse record {
    string sid;
    string status;
    string price;
    string priceUnit;
};

# Represents Twilio voice call response.
# + sid - Unique identifier of the account
# + status - Status of the voice call (queued, initiated, ringing, answered, completed)
# + price - The price amount of the call
# + priceUnit - The price currency
public type VoiceCallResponse record {
    string sid;
    string status;
    string price;
    string priceUnit;
};

# Represents Authy app details response.
# + appId - Unique identifier of the Authy app
# + name - Name of the Authy app
# + plan - The subscribed plan
# + isSmsEnabled - Status of whether SMS is enabled
# + isPhoneCallsEnabled - Status of whether phone call is enabled
# + isOnetouchEnabled - Status of whether one touch is enabled
# + message - A messaging indicating the result of the operation
# + isSuccess - Is the request was success or not
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

# Represents Authy user adding response.
# + userId - Unique identifier of the user
# + message - A messaging indicating the result of the operation
# + isSuccess - Is the request was success or not
public type AuthyUserAddResponse record {
    string userId;
    string message;
    boolean isSuccess;
};

# Represents Authy user status response.
# + userId - Unique identifier of the user
# + isConfirmed - Is user confirmed or not
# + isRegistered - Is user registerd or not
# + countryCode - Country code of user
# + phoneNumber - Phone number of user
# + isAccountDisabled - Is account disabled or not
# + message - A messaging indicating the result of the operation
# + isSuccess - Is the request was success or not
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

# Represents Authy user delete response.
# + message - A messaging indicating the result of the operation
# + isSuccess - Is the request was success or not
public type AuthyUserDeleteResponse record {
    string message;
    boolean isSuccess;
};

# Represents Authy user secret response.
# + issuer - Name of the Authy name
# + label - A custom label given by the user. If not, the name of the authy app
# + qrCodeUrl - URL for the generated qr code
# + isSuccess - Is the request was success or not
public type AuthyUserSecretResponse record {
    string issuer;
    string label;
    string qrCodeUrl;
    boolean isSuccess;
};

# Represents Authy OTP response.
# + message - A messaging indicating the result of the operation
# + cellphone - Phone number used to send the message or call
# + device - The type of the last device used by the user
# + isIgnored - True if we detected an Authy or SDK enabled app installed.
# + isSuccess - Is the request was success or not
public type AuthyOtpResponse record {
    string message;
    string cellphone;
    string device;
    boolean isIgnored;
    boolean isSuccess;
};

# Represents Authy OTP verify response.
# + message - A messaging indicating the result of the operation
# + token - Either "is valid" or "is invalid"
# + isSuccess - Is the OTP was valid or not
public type AuthyOtpVerifyResponse record {
    string message;
    string token;
    boolean isSuccess;
};

# Represents Twilio cusotm error.
# + message - A custom message about the error
# + cause - Error object reffered to the occurred error
public type TwilioError record {
    string message;
    error? cause;
};
