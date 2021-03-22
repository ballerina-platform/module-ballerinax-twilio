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

# Object for Twilio endpoint.
#
# + accountSId - Unique identifier of the account
# + basicClient - HTTP client endpoint for basic api
# + authyClient - HTTP client endpoint for authy api
@display {label: "Twilio Client", iconPath: "TwilioLogo.png"}
public client class Client {
    public string accountSId;
    public http:Client basicClient;
    public http:Client authyClient;

    public function init(TwilioConfiguration twilioConfig) {
        self.accountSId = twilioConfig.accountSId;

        auth:CredentialsConfig config = {
            username: twilioConfig.accountSId,
            password: twilioConfig.authToken
        };
        var secureSocket = twilioConfig?.secureSocket;
        if (secureSocket is http:ClientSecureSocket) {
            self.basicClient = checkpanic new (TWILIO_API_BASE_URL, config = {
                auth: config ,
                secureSocket: secureSocket
            });
            self.authyClient = checkpanic new (AUTHY_API_BASE_URL, config = {
                auth: config,
                secureSocket: secureSocket
            });
        } else {
            self.basicClient = checkpanic new (TWILIO_API_BASE_URL, config = {
                auth: config,
                secureSocket: {disable: true}
            });
            self.authyClient = checkpanic new (AUTHY_API_BASE_URL, config = {
                auth: config,
                secureSocket: {disable: true}
            });
        }
    }

    # Return account details of the given account-sid.
    #
    # + return - If success, returns account object with basic details, else returns error
    @display {label: "Get Account Details"}
    remote function getAccountDetails() returns @tainted @display {label: "Account"} Account|error {
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + JSON_EXTENSION;
        http:Response response = <http:Response> check self.basicClient->get(requestPath);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToAccount(payloadMap);
    }

    # Send SMS from the given account-sid.
    #
    # + fromNo - Mobile number which the SMS should be send from
    # + toNo - Mobile number which the SMS should be received to
    # + message - Message body of the SMS
    # + statusCallbackUrl - (optional) Callback URL where the status callback events needs to be dispatched
    # + return - If success, returns a programmable SMS response object, else returns error
    @display {label: "Send SMS"}
    remote function sendSms(@display {label: "Sender's Number"} string fromNo,
                            @display {label: "Receiver's Number"} string toNo, 
                            @display {label: "Message"} string message, 
                            @display {label: "Status callback URL"} string? statusCallbackUrl = ()) 
                            returns @tainted @display {label: "SMS Response"} SmsResponse|error {
        http:Request req = new;
        string requestBody = "";
        requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);

        if (statusCallbackUrl is string) {
            requestBody = check createUrlEncodedRequestBody(requestBody, STATUS_CALLBACK_URL, statusCallbackUrl);
        }

        req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + SMS_SEND;

        http:Response response = <http:Response>check self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToSmsResponse(payloadMap);
    }

    # Get the relavant message from a given message-sid.
    #
    # + messageSid - Message-sid of a relavant message
    # + return - If success, returns a message resourse responce record, else returns error
    @display {label: "Get message"}
    remote function getMessage(@display {label: "Message SID"} string messageSid) 
                                returns @tainted @display {label: "Message Response"} MessageResourceResponse|error {
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + MESSAGE + messageSid + JSON_EXTENSION;
        http:Response response = <http:Response>check self.basicClient->get(requestPath);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToMessageResourceResponse(payloadMap);
    }

    # Send WhatsApp message from the given Sender ID of the account.
    #
    # + fromNo - Mobile number from which the WhatsApp message should be sent
    # + toNo - Mobile number by which the WhatsApp message should be received
    # + message - Message body of the WhatsApp message
    # + return - If success, returns a WhatsAppResponse object, else returns error
    @display {label: "Send WhatsApp Message"}
    remote function sendWhatsAppMessage(@display {label: "Sender's Number"} string fromNo,
                                        @display {label: "Receiver's Number"} string toNo, 
                                        @display {label: "Message"} string message) 
                                        returns @tainted @display {label: "WhatsApp Response"} WhatsAppResponse|error {
        http:Request req = new;
        string requestBody = "";
        requestBody = check createUrlEncodedRequestBody(requestBody, FROM, WHATSAPP + ":" + fromNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, TO, WHATSAPP + ":" + toNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
        req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + WHATSAPP_SEND;
        http:Response response = <http:Response>check self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToWhatsAppResponse(payloadMap);
    }

    # Make a voice call from the given account-sid.
    #
    # + fromNo - Mobile number which the voice call should be send from
    # + toNo - Mobile number which the voice call should be received to
    # + twiml - TwiML URL which the response of the voice call is stated
    # + statusCallback - (optional) StatusCallback record which contains the callback url and the events whose status needs to be delivered.
    # + return - If success, returns voice call response object with basic details, else returns error
    @display {label: "Make Voice Call"}
    remote function makeVoiceCall(@display {label: "Sender's Number"} string fromNo,
                                  @display {label: "Receiver's Number"} string toNo, 
                                  @display {label: "TwiML URL"} string twiml, 
                                  @display {label: "Status callback"} StatusCallback? statusCallback = ()) 
                                  returns @tainted @display {label: "Voice Call Response"} VoiceCallResponse|error {
        http:Request req = new;
        string requestBody = "";
        requestBody = check createUrlEncodedRequestBody(requestBody, FROM, fromNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, TO, toNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, URL, twiml);

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
        http:Response response = <http:Response>check self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(response);
        map<json> payloadMap = <map<json>>jsonResponse;
        return mapJsonToVoiceCallResponse(payloadMap);
    }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  The Authy:2FA and Passwordless Login(Actions) will not be supported by the connector at the moment                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // # Get the Authy app details.
    // #
    // # + return - If success, returns Authy app response object with basic details, else returns error
    // remote function getAuthyAppDetails() returns @tainted AuthyAppDetailsResponse|Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestPath = AUTHY_APP_API;
    //     http:Response response = <http:Response> check self.authyClient->get(requestPath, message = req);
    //     json jsonResponse = check parseResponseToJson(response);
    //     return mapJsonToAuthyAppDetailsResponse(jsonResponse);
    // }

    // # Add an user for Authy app.
    // #
    // # + email - Email of the new user
    // # + phone - Phone number of the new user
    // # + countryCode - Country code of the new user
    // # + return - If success, returns Authy user add response object with basic details, else returns error
    // remote function addAuthyUser(string email, string phone, string countryCode) returns @tainted AuthyUserAddResponse|
    // Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestBody = "";
    //     requestBody = check createUrlEncodedRequestBody(requestBody, "user[email]", email);
    //     requestBody = check createUrlEncodedRequestBody(requestBody, "user[cellphone]", phone);
    //     requestBody = check createUrlEncodedRequestBody(requestBody, "user[country_code]", countryCode);
    //     req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

    //     string requestPath = AUTHY_USER_API + USER_ADD;
    //     http:Response response = <http:Response> check self.authyClient->post(requestPath, req);
    //     json jsonResponse = check parseResponseToJson(response);
    //     return mapJsonToAuthyUserAddRespones(jsonResponse);
    // }

    // # Get the user details of Authy for the given user-id.
    // #
    // # + userId - Unique identifier of the user
    // # + return - If success, returns Authy user status response object with basic details, else returns error
    // remote function getAuthyUserStatus(string userId) returns @tainted AuthyUserStatusResponse|Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_STATUS;
    //     http:Response response = <http:Response>check self.authyClient->get(requestPath, message = req);
    //     json jsonResponse = check parseResponseToJson(response);
    //     return mapJsonToAuthyUserStatusResponse(jsonResponse);
    // }

    // # Delete the user of Authy for the given user-id.
    // #
    // # + userId - Unique identifier of the user
    // # + return - If success, returns Authy user delete response object with basic details, else returns error
    // remote function deleteAuthyUser(string userId) returns @tainted AuthyUserDeleteResponse|Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_REMOVE;
    //     http:Response response = <http:Response>check self.authyClient->post(requestPath, req);
    //     json jsonResponse = check parseResponseToJson(response);
    //     map<json> payloadMap = <map<json>>jsonResponse;
    //     return mapJsonToAuthyUserDeleteResponse(payloadMap);
    // }

    // # Get the user secret of Authy user for the given user-id.
    // #
    // # + userId - Unique identifier of the user
    // # + return - If success, returns Authy user secret response object with basic details, else returns error
    // remote function getAuthyUserSecret(string userId) returns @tainted AuthyUserSecretResponse|Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_SECRET;
    //     http:Response response = <http:Response>check self.authyClient->post(requestPath, req);
    //     json jsonResponse = check parseResponseToJson(response);
    //     map<json> payloadMap = <map<json>>jsonResponse;
    //     return mapJsonToAuthyUserSecretResponse(payloadMap);
    // }

    // # Request OTP for the user of Authy via SMS for the given user-id.
    // #
    // # + userId - Unique identifier of the user
    // # + return - If success, returns Authy OTP response object with basic details, else returns error
    // remote function requestOtpViaSms(string userId) returns @tainted AuthyOtpResponse|Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestPath = AUTHY_OTP_SMS_API + FORWARD_SLASH + userId;
    //     http:Response response = <http:Response>check self.authyClient->get(requestPath, message = req);
    //     json jsonResponse = check parseResponseToJson(response);
    //     map<json> payloadMap = <map<json>>jsonResponse;
    //     return mapJsonToAuthyOtpResponse(payloadMap);
    // }

    // # Request OTP for the user of Authy via call for the given user-id.
    // #
    // # + userId - Unique identifier of the user
    // # + return - If success, returns Authy OTP response object with basic details, else returns error
    // remote function requestOtpViaCall(string userId) returns @tainted AuthyOtpResponse|Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestPath = AUTHY_OTP_CALL_API + FORWARD_SLASH + userId;
    //     http:Response response = <http:Response>check self.authyClient->get(requestPath, message = req);
    //     json jsonResponse = check parseResponseToJson(<http:Response>response);
    //     map<json> payloadMap = <map<json>>jsonResponse;
    //     return mapJsonToAuthyOtpResponse(payloadMap);
    // }

    // # Verify OTP for the user of Authy for the given user-id.
    // #
    // # + userId - Unique identifier of the user
    // # + token - The OTP token to be verified
    // # + return - If success, returns Authy OTP verify response object with basic details, else returns error
    // remote function verifyOtp(string userId, string token) returns @tainted AuthyOtpVerifyResponse|Error|error {
    //     http:Request req = new;
    //     if (self.xAuthyKey != ()) {
    //         req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
    //     } else {
    //         return prepareError("No xAuthyKey found");
    //     }
    //     string requestPath = AUTHY_OTP_VERIFY_API + FORWARD_SLASH + token + FORWARD_SLASH + userId;
    //     http:Response response = <http:Response>check self.authyClient->get(requestPath, message = req);
    //     json jsonResponse = check parseResponseToJson(response);
    //     map<json> payloadMap = <map<json>>jsonResponse;
    //     return mapJsonToAuthyOtpVerifyResponse(payloadMap);
    // }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                                      End of Authy Releated Action Operations                                       //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

# Twilio Configuration.
#
# + accountSId - Unique identifier of the account
# + authToken - The authentication token of the account
# + secureSocket - ???
public type TwilioConfiguration record {
    string accountSId;
    string authToken;
    http:ClientSecureSocket secureSocket?;
};
