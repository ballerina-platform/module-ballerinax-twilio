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

# Represents Twilio account.
# + sid - Unique identifier of the account
# + name - The name of the account
# + status - The status of the account (active, suspended, closed)
# + type - The type of this account (`Trial`, `Full`)
# + createdDate - The date that this account was created
# + updatedDate - The date that this account was last updated
public type Account record {
    string sid = "";
    string name = "";
    string status = "";
    string 'type = "";
    string createdDate = "";
    string updatedDate = "";
};

# Represents Twilio SMS response.
# + sid - Unique identifier of the account
# + dateCreated - The date and time at which this resource was created
# + dateUpdated - The date and time at which this resource was last updated
# + dateSent - The date and time at which the outgoing message was sent
# + accountSid - The unique identifier of the account, which sent the message
# + toNumber - The phone number to which the message was sent
# + fromNumber - The phone number from which the message was sent
# + body - The text of the message to be sent
# + status - Status of the voice call (queued, failed, sent, delivered, undelivered)
# + direction - The direction of the message (inbound, outbound-api, outbound-call, outbound-reply)
# + apiVersion - The API version, which is used to process the message
# + price - The price amount of the SMS
# + priceUnit - The price currency
# + uri - The URI of the resource relative to https://api.twilio.com
# + numSegments - The number of segments, which make up the complete message
public type SmsResponse record {
    string sid = "";
    string dateCreated = "";
    string dateUpdated = "";
    string dateSent = "";
    string accountSid = "";
    string toNumber = "";
    string fromNumber = "";
    string body = "";
    string status = "";
    string direction = "";
    string apiVersion = "";
    string price = "";
    string priceUnit = "";
    string uri = "";
    string numSegments = "";
};

# Represents the Twilio WhatsApp message response. More details of the message format is
# accessible from https://www.twilio.com/docs/sms/api/message-resource#create-a-message-resource
# + sid - Unique identifier of the account
# + dateCreated - The date and time at which this resource was created
# + dateUpdated - The date and time at which this resource was last updated
# + dateSent - The date and time at which the outgoing message was sent
# + accountSid - The unique identifier of the account, which sent the message
# + toNumber - The phone number to which the message was sent
# + fromNumber - The phone number from which the message was sent
# + messageServiceSid - The SID of the Messaging Service, which will be associated with the message
# + body - The text of the message to be sent
# + status - Status of the voice call (queued, failed, sent, delivered, undelivered)
# + numSegments - The number of segments, which make up the complete message
# + numMedia - The number of associated media files 
# + direction - The direction of the message (inbound, outbound-api, outbound-call, outbound-reply)
# + apiVersion - The API version used to process the message
# + price - The price of the SMS (This is set to null for WhatsApp messages)
# + priceUnit - The currency of the price (This is set to null for WhatsApp messages)
# + errorCode - The error code returned if the message status is failed or undelivered
# + errorMessage - The description of the error_code if the message status is failed or undelivered
# + uri - The URI of the resource relative to https://api.twilio.com
# + subresourceUris - A list of related resources identified by their URIs relative to https://api.twilio.com 
public type WhatsAppResponse record {
    string sid = "";
    string dateCreated = "";
    string dateUpdated = "";
    string dateSent = "";
    string accountSid = "";
    string toNumber = "";
    string fromNumber = "";
    string messageServiceSid = "";
    string body = "";
    string status = "";
    string numSegments = "";
    string numMedia = "";
    string direction = "";
    string apiVersion = "";
    string price = "";
    string priceUnit = "";
    string errorCode = "";
    string errorMessage = "";
    string uri = "";
    json subresourceUris = {};
};

# Represents Twilio voice call response.
# + sid - Unique identifier of the account
# + status - Status of the voice call (queued, initiated, ringing, answered, completed)
# + price - The price amount of the call
# + priceUnit - The price currency
public type VoiceCallResponse record {
    string sid = "";
    string status = "";
    string price = "";
    string priceUnit = "";
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
    string appId = "";
    string name = "";
    string plan = "";
    boolean isSmsEnabled = false;
    boolean isPhoneCallsEnabled = false;
    boolean isOnetouchEnabled = false;
    string message = "";
    boolean isSuccess = false;
};

# Represents Authy user adding response.
# + userId - Unique identifier of the user
# + message - A messaging indicating the result of the operation
# + isSuccess - Is the request was success or not
public type AuthyUserAddResponse record {
    string userId = "";
    string message = "";
    boolean isSuccess = false;
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
    string userId = "";
    boolean isConfirmed = false;
    boolean isRegistered = false;
    string countryCode = "";
    string phoneNumber = "";
    boolean isAccountDisabled = false;
    string message = "";
    boolean isSuccess = false;
};

# Represents Authy user delete response.
# + message - A messaging indicating the result of the operation
# + isSuccess - Is the request was success or not
public type AuthyUserDeleteResponse record {
    string message = "";
    boolean isSuccess = false;
};

# Represents Authy user secret response.
# + issuer - Name of the Authy name
# + label - A custom label given by the user. If not, the name of the authy app
# + qrCodeUrl - URL for the generated qr code
# + isSuccess - Is the request was success or not
public type AuthyUserSecretResponse record {
    string issuer = "";
    string label = "";
    string qrCodeUrl = "";
    boolean isSuccess = false;
};

# Represents Authy OTP response.
# + message - A messaging indicating the result of the operation
# + cellphone - Phone number used to send the message or call
# + isIgnored - True if we detected an Authy or SDK enabled app installed
# + isSuccess - Is the request was success or not
public type AuthyOtpResponse record {
    string message = "";
    string cellphone = "";
    boolean isIgnored = false;
    boolean isSuccess = false;
};

# Represents Authy OTP verify response.
# + message - A messaging indicating the result of the operation
# + token - Either "is valid" or "is invalid"
# + isSuccess - Is the OTP was valid or not
public type AuthyOtpVerifyResponse record {
    string message = "";
    string token = "";
    boolean isSuccess = false;
};
