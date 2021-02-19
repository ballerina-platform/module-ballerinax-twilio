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
# + xAuthyKey - Unique identifier of Authy API account
# + basicClient - HTTP client endpoint for basic api
# + authyClient - HTTP client endpoint for authy api
public client class Client {

    public string accountSId;
    public string? xAuthyKey;
    public http:Client basicClient;
    public http:Client authyClient;

    public function init(TwilioConfiguration twilioConfig) {
        self.accountSId = twilioConfig.accountSId;
        self.xAuthyKey = twilioConfig?.xAuthyKey;

        auth:OutboundBasicAuthProvider basicAuthProvider = new ({
            username: twilioConfig.accountSId,
            password: twilioConfig.authToken
        });
        http:BasicAuthHandler basicAuthHandler = new (basicAuthProvider);

        var secureSocket = twilioConfig?.secureSocket;
        if (secureSocket is http:ClientSecureSocket) {
            self.basicClient = new (TWILIO_API_BASE_URL, config = {
                auth: {authHandler: basicAuthHandler},
                secureSocket: secureSocket
            });
            self.authyClient = new (AUTHY_API_BASE_URL, config = {
                auth: {authHandler: basicAuthHandler},
                secureSocket: secureSocket
            });
        } else {
            self.basicClient = new (TWILIO_API_BASE_URL, config = {
                auth: {authHandler: basicAuthHandler},
                secureSocket: {disable: true}
            });
            self.authyClient = new (AUTHY_API_BASE_URL, config = {
                auth: {authHandler: basicAuthHandler},
                secureSocket: {disable: true}
            });
        }
    }

    # Return account details of the given account-sid.
    #
    # + return - If success, returns account object with basic details, else returns error
    remote function getAccountDetails() returns @tainted Account|Error {
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + JSON_EXTENSION;
        var response = self.basicClient->get(requestPath);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAccount(jsonResponse);
    }

    # Send SMS from the given account-sid.
    #
    # + fromNo - Mobile number which the SMS should be send from
    # + toNo - Mobile number which the SMS should be received to
    # + message - Message body of the SMS
    # + statusCallbackUrl - (optional) Callback URL where the status callback events needs to be dispatched
    # + return - If success, returns a programmable SMS response object, else returns error
    remote function sendSms(string fromNo, string toNo, string message, string? statusCallbackUrl = ()) returns @tainted 
    SmsResponse|Error {
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
        var response = self.basicClient->post(requestPath, req);

        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToSmsResponse(jsonResponse);
    }

    # Get the relavant message from a given message-sid.
    #
    # + messageSid - Message-sid of a relavant message
    # + return - If success, returns a message resourse responce record, else returns error
    remote function getMessage(string messageSid) returns @tainted MessageResourceResponse|Error {
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + MESSAGE + messageSid + JSON_EXTENSION;
        var response = self.basicClient->get(requestPath);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToMessageResourceResponse(jsonResponse);
    }

    # Send WhatsApp message from the given Sender ID of the account.
    #
    # + fromNo - Mobile number from which the WhatsApp message should be sent
    # + toNo - Mobile number by which the WhatsApp message should be received
    # + message - Message body of the WhatsApp message
    # + return - If success, returns a WhatsAppResponse object, else returns error
    remote function sendWhatsAppMessage(string fromNo, string toNo, string message) returns @tainted WhatsAppResponse|
    Error {
        http:Request req = new;
        string requestBody = "";
        requestBody = check createUrlEncodedRequestBody(requestBody, FROM, WHATSAPP + ":" + fromNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, TO, WHATSAPP + ":" + toNo);
        requestBody = check createUrlEncodedRequestBody(requestBody, BODY, message);
        req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);
        string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + WHATSAPP_SEND;
        var response = self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);

        return mapJsonToWhatsAppResponse(jsonResponse);
    }

    # Make a voice call from the given account-sid.
    #
    # + fromNo - Mobile number which the voice call should be send from
    # + toNo - Mobile number which the voice call should be received to
    # + twiml - TwiML URL which the response of the voice call is stated
    # + statusCallback - (optional) StatusCallback record which contains the callback url and the events whose status needs to be delivered.
    # + return - If success, returns voice call response object with basic details, else returns error
    remote function makeVoiceCall(string fromNo, string toNo, string twiml, StatusCallback? statusCallback = ()) returns @tainted 
    VoiceCallResponse|Error {
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
        var response = self.basicClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToVoiceCallResponse(jsonResponse);
    }

    # Get the Authy app details.
    #
    # + return - If success, returns Authy app response object with basic details, else returns error
    remote function getAuthyAppDetails() returns @tainted AuthyAppDetailsResponse|Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestPath = AUTHY_APP_API;
        var response = self.authyClient->get(requestPath, message = req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyAppDetailsResponse(jsonResponse);
    }

    # Add an user for Authy app.
    #
    # + email - Email of the new user
    # + phone - Phone number of the new user
    # + countryCode - Country code of the new user
    # + return - If success, returns Authy user add response object with basic details, else returns error
    remote function addAuthyUser(string email, string phone, string countryCode) returns @tainted AuthyUserAddResponse|
    Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestBody = "";
        requestBody = check createUrlEncodedRequestBody(requestBody, "user[email]", email);
        requestBody = check createUrlEncodedRequestBody(requestBody, "user[cellphone]", phone);
        requestBody = check createUrlEncodedRequestBody(requestBody, "user[country_code]", countryCode);
        req.setTextPayload(requestBody, contentType = mime:APPLICATION_FORM_URLENCODED);

        string requestPath = AUTHY_USER_API + USER_ADD;
        var response = self.authyClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyUserAddRespones(jsonResponse);
    }

    # Get the user details of Authy for the given user-id.
    #
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user status response object with basic details, else returns error
    remote function getAuthyUserStatus(string userId) returns @tainted AuthyUserStatusResponse|Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_STATUS;
        var response = self.authyClient->get(requestPath, message = req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyUserStatusResponse(jsonResponse);
    }

    # Delete the user of Authy for the given user-id.
    #
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user delete response object with basic details, else returns error
    remote function deleteAuthyUser(string userId) returns @tainted AuthyUserDeleteResponse|Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_REMOVE;
        var response = self.authyClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyUserDeleteResponse(jsonResponse);
    }

    # Get the user secret of Authy user for the given user-id.
    #
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy user secret response object with basic details, else returns error
    remote function getAuthyUserSecret(string userId) returns @tainted AuthyUserSecretResponse|Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestPath = AUTHY_USER_API + FORWARD_SLASH + userId + USER_SECRET;
        var response = self.authyClient->post(requestPath, req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyUserSecretResponse(jsonResponse);
    }

    # Request OTP for the user of Authy via SMS for the given user-id.
    #
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error
    remote function requestOtpViaSms(string userId) returns @tainted AuthyOtpResponse|Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestPath = AUTHY_OTP_SMS_API + FORWARD_SLASH + userId;
        var response = self.authyClient->get(requestPath, message = req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyOtpResponse(jsonResponse);
    }

    # Request OTP for the user of Authy via call for the given user-id.
    #
    # + userId - Unique identifier of the user
    # + return - If success, returns Authy OTP response object with basic details, else returns error
    remote function requestOtpViaCall(string userId) returns @tainted AuthyOtpResponse|Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestPath = AUTHY_OTP_CALL_API + FORWARD_SLASH + userId;
        var response = self.authyClient->get(requestPath, message = req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyOtpResponse(jsonResponse);
    }

    # Verify OTP for the user of Authy for the given user-id.
    #
    # + userId - Unique identifier of the user
    # + token - The OTP token to be verified
    # + return - If success, returns Authy OTP verify response object with basic details, else returns error
    remote function verifyOtp(string userId, string token) returns @tainted AuthyOtpVerifyResponse|Error {
        http:Request req = new;
        if (self.xAuthyKey != ()) {
            req.addHeader(X_AUTHY_API_KEY, <string>self.xAuthyKey);
        } else {
            return prepareError("No xAuthyKey found");
        }
        string requestPath = AUTHY_OTP_VERIFY_API + FORWARD_SLASH + token + FORWARD_SLASH + userId;
        var response = self.authyClient->get(requestPath, message = req);
        json jsonResponse = check parseResponseToJson(<http:Response>response);
        return mapJsonToAuthyOtpVerifyResponse(jsonResponse);
    }
}

# Twilio Configuration.
#
# + accountSId - Unique identifier of the account
# + authToken - The authentication token of the account
# + xAuthyKey - The authentication token for the Authy API
# + secureSocket - ???
public type TwilioConfiguration record {
    string accountSId;
    string authToken;
    string xAuthyKey?;
    http:ClientSecureSocket secureSocket?;
};
