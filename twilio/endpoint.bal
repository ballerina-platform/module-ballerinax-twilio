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

import ballerina/auth;
import ballerina/http;
import ballerina/mime;

# The Twilio API provides capability to access its platform for communications. These APIs connects 
# the software layer and communications networks around the world to allow users to call and message anyone, globally. 
#
# + accountSId - Unique identifier of the account
# + basicClient - HTTP client endpoint for basic api
@display {label: "Twilio Client", iconPath: "resources/twilio.svg"}
public isolated client class Client {
    private final string accountSId;
    private final http:Client basicClient;

    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials. 
    # Create a [Twilio](https://www.twilio.com/) account and obtain account SID and auth token at [console](twilio.com/console) 
    # or else follow this [guide](https://www.twilio.com/docs/usage/api#authenticate-with-http) for more details.
    #
    # + twilioConfig - Twilio connection configuration 
    # + return - `http:Error` in case of failure to initialize or `null` if successfully initialized
    public isolated function init(ConnectionConfig twilioConfig, http:ClientConfiguration httpClientConfig = {}) returns error? {
        self.accountSId = twilioConfig.auth.accountSId;
        if (twilioConfig.auth is TokenBasedAuthentication) {
            auth:CredentialsConfig credentialsConfig = {
                username: self.accountSId,
                password: twilioConfig.auth?.authToken.toString()
            };
            httpClientConfig.auth = credentialsConfig;
        } else {
            auth:CredentialsConfig credentialsConfig = {
                username: twilioConfig.auth?.apiKey.toString(),
                password: twilioConfig.auth?.apiSecret.toString()
            };
            httpClientConfig.auth = credentialsConfig;
        } 
        self.basicClient = check new (TWILIO_API_BASE_URL, httpClientConfig);
    }

    # Gets account details of the given account-sid.
    #
    # + return - An account object with basic details or else an error
    @display {label: "Get Twilio Account Details"}
    remote isolated function getAccountDetails() returns @tainted @display {label: "Account"} Account|error {
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + JSON_EXTENSION;
        http:Response response = check self.basicClient->get(requestPath);
        map<json> payloadMap = <map<json>> check parseResponseToJson(response);
        return mapJsonToAccount(payloadMap);
    }

    # Sends SMS from the given account-sid.
    #
    # + fromNo - Mobile number which the SMS should be sent from
    # + toNo - Mobile number which the SMS should be received to
    # + message - Message body of the SMS
    # + statusCallbackUrl - (optional) Callback URL where the status callback events are needed to be dispatched
    # + return - A programmable SMS response object or else an error
    @display {label: "Send SMS"}
    remote isolated function sendSms(@display {label: "Sender's Number"} string fromNo, 
                                     @display {label: "Recipient's Number"} string toNo, 
                                     @display {label: "Message"} string message, 
                                     @display {label: "Callback URL"} string? statusCallbackUrl = ()) returns 
                                     @tainted @display {label: "SMS Response"} SmsResponse|error {
        http:Request req = new;
        string requestBody = EMPTY_STRING;
        requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
        if (statusCallbackUrl is string) {
            requestBody = check createUrlEncodedRequestBody(requestBody, STATUS_CALLBACK_URL, statusCallbackUrl);
        }

        req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + SMS_SEND;
        http:Response response = check self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToSmsResponse(payloadMap);
    }

    # Gets the relevant message from a given message-sid.
    #
    # + messageSid - Message-sid of a relevant message
    # + return -  A message resource response record or else an error
    @display {label: "Get Message Details"}
    remote isolated function getMessage(@display {label: "Message SID"} string messageSid) returns @tainted 
                                        @display {label: "Message Resource Response"} MessageResourceResponse|error {
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + MESSAGE + messageSid 
            + JSON_EXTENSION;
        http:Response response = check self.basicClient->get(requestPath);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToMessageResourceResponse(payloadMap);
    }

    # Sends WhatsApp message from the given Sender ID of the account.
    #
    # + fromNo - Mobile number from which the WhatsApp message should be sent
    # + toNo - Mobile number by which the WhatsApp message should be received
    # + message - Message body of the WhatsApp message
    # + return - A whatsAppResponse object or else an error
    @display {label: "Send WhatsApp Message"}
    remote isolated function sendWhatsAppMessage(@display {label: "Sender's Number"} string fromNo, 
                                                 @display {label: "Recipient's Number"} string toNo, 
                                                 @display {label: "Message"} string message) returns 
                                                 @tainted @display {label: "WhatsApp Message Response"} WhatsAppResponse
                                                 |error {
        http:Request req = new;
        string requestBody = EMPTY_STRING;
        requestBody = check createUrlEncodedRequestBody(requestBody, FROM, WHATSAPP + COLON + fromNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, TO, WHATSAPP + COLON + toNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
        req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + WHATSAPP_SEND;
        http:Response response = check self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToWhatsAppResponse(payloadMap);
    }

    # Makes a voice call from the given account-sid.
    #
    # + fromNo - Mobile number which the voice call should be sent from
    # + toNo - Mobile number which the voice call should be received to
    # + voiceCallInput - What should be heard when the other party picks up the phone (a Url that returns TwiML Voice instructions or 
    #                    inline message. example: "http://demo.twilio.com/docs/voice.xml" or "Thank you for calling")
    # + statusCallback - (optional) StatusCallback record which contains the callback url and the events whose status 
    #                     needs to be delivered
    # + return - A voiceCallresponse object with basic details or else an error
    @display {label: "Make Voice Call"}
    remote isolated function makeVoiceCall(@display {label: "Caller Number"} string fromNo, 
                                           @display {label: "Callee Number"} string toNo, 
                                           @display {label: "Input"} VoiceCallInput voiceCallInput, 
                                           @display {label: "Callback URL"} StatusCallback? statusCallback = ()) returns 
                                           @tainted  @display {label: "Voice Call Response"} VoiceCallResponse|error {
        http:Request req = new;
        string requestBody = EMPTY_STRING;
        requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
        if(voiceCallInput.userInputType == TWIML_URL)  {
            requestBody = check createUrlEncodedRequestBody(requestBody, URL, voiceCallInput.userInput);
        } else {
            string voiceMessage = string `<Response><Say>${voiceCallInput.userInput}</Say></Response>`;
            requestBody = check createUrlEncodedRequestBody(requestBody, TWIML, voiceMessage);
        }
        if (statusCallback is StatusCallback) {
            requestBody = check createUrlEncodedRequestBody(requestBody, STATUS_CALLBACK_URL, statusCallback.url);
            requestBody = check createUrlEncodedRequestBody(requestBody, STATUS_CALLBACK_METHOD, statusCallback.method);
            string[]? events = statusCallback?.events;
            
            if (events is string[]) {
                foreach string event in events {
                    requestBody = check createUrlEncodedRequestBody(requestBody, STATUS_CALLBACK_EVENT, event);
                }
            }
        }

        req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + VOICE_CALL;
        http:Response response = check self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToVoiceCallResponse(payloadMap);
    }
}

# Twilio Configuration.
#
# + auth - Twilio authentication configuration 
@display{label: "Connection Config"} 
public type ConnectionConfig record {
    @display{label: "Authentication Configuration"} 
    TokenBasedAuthentication|APIKeyBasedAuthentication auth;
};

# Twilio Token Based Authentication
#
# + accountSId - Twilio account SID  
# + authToken - The authentication token of the account 
@display{label: "Auth Token Based Connection Config"} 
public type TokenBasedAuthentication record {
    @display{label: "Account SID"} 
    string accountSId;
    @display{label: "Auth Token"} 
    string authToken;
};

# Twilio API Key Based Authentication
#
# + accountSId - Twilio account SID  
# + apiKey - Twilio API key SID 
# + apiSecret - Twilio API key Secret
@display{label: "API Key Based Connection Config"} 
public type APIKeyBasedAuthentication record {
    @display{label: "Twilio Account SID"} 
    string accountSId;
    @display{label: "API Key SID"} 
    string apiKey;
    @display{label: "API Key Secret"} 
    string apiSecret;
};
