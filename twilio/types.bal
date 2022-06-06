// Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

# Represents the Twilio error. This will be returned if an error occurred on Twilio operations.
public type TwilioError distinct error;

# Represents the Twilio module related error.
public type Error TwilioError;

# Represents the StatusCallback record for registering status change callback URL for Twilio Voice status change events.
# + url - Callback URL where the status changes needs to be delivered.
# + method - HTTP method in which the event payload needs to be delivered
# + events - Interested list of status change events.
public type StatusCallback record {
    string url;
    string method;
    string[] events?;
};

# Represents the message resource in the Twilio Rest API.
# + body - The message body 
# + numSegments - The number of segments, which make up the complete message
# + direction - The direction of the message (inbound, outbound-api, outbound-call, outbound-reply)
# + fromNumber - The phone number from which the message sent
# + toNumber - The phone number to which the message received
# + dateUpdated - The date and time at which this resource was last updated
# + price - The price amount of the message
# + errorMessage - The description of the error_code if the message status is failed or undelivered
# + uri -The URI of the resource relative to https://api.twilio.com
# + accountSid - The unique identifier of the account, which sent the message
# + numMedia - The number of associated media files 
# + status - The status of the message
# + messagingServiceSid - The SID of the Messaging Service used with the message. The value is null if a Messaging Service was not used
# + sid - The unique string that created to identify the message resource
# + dateSent - The date and time in GMT that the resource was sent specified in RFC 2822 format
# + dateCreated - The date and time in GMT that the resource was created specified in RFC 2822 format
# + errorCode - The error code returned if your message status is failed or undelivered
# + priceUnit - The currency in which price is measured, in ISO 4127 format
# + apiVersion - The API version used to process the message
# + subresourceUris - A list of related resources identified by their URIs relative to https://api.twilio.com
public type MessageResourceResponse record {
    string body = "";
    string numSegments = "";
    string direction = "";
    string fromNumber = "";
    string toNumber = "";
    string dateUpdated = "";
    string price = "";
    string errorMessage = "";
    string uri = "";
    string accountSid = "";
    string numMedia = "";
    string status = "";
    string messagingServiceSid = "";
    string sid = "";
    string dateSent = "";
    string dateCreated = "";
    string errorCode = "";
    string priceUnit = "";
    string apiVersion = "";
    json subresourceUris = {};
};

# Represents voice call message input options.
#
# + userInput - A Twiml URL or an inline Message that what should be heard when the other party picks up the phone 
# + userInputType - Whether the userInput is a URL or inline message  
public type VoiceCallInput record {
    VoiceCallInputType userInputType;
    string userInput;
};

# Represents voice call input types.
#
# + TWIML_URL - A URL that returns TwiML Voice instructions
# + MESSAGE_IN_TEXT - A message in plain text format
public enum VoiceCallInputType {
    TWIML_URL,
    MESSAGE_IN_TEXT
}
