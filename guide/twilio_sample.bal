// Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

// This guide is created for the reference of "How to Extend Ballerina" in ballerina.io
// https://ballerina.io/learn/how-to-extend-ballerina/


import ballerina/http;
import ballerina/mime;

// Twilio API urls
final string TWILIO_API_BASE_URL = "https://api.twilio.com/2010-04-01";
final string AUTHY_API_BASE_URL = "https://api.authy.com/protected";
final string TWILIO_ACCOUNTS_API = "/Accounts";
final string FORWARD_SLASH = "/";
final string ACCOUNT_DETAILS = ".json";
final string TWILIO_ERROR_CODE = "(wso2/twilio)TwilioError";
final string DASH_WITH_WHITE_SPACES_SYMBOL = " - ";
final string WHITE_SPACE = " ";
final string COLON_WITH_WHITE_SPACES_SYMBOL = " : ";


# Object for Twilio endpoint.
# + accountSId - Unique identifier of the account
# + xAuthyKey - Unique identifier of Authy API account
# + basicClient - HTTP client endpoint for basic api
# + authyClient - HTTP client endpoint for authy api
public type Client client object {

    public string accountSId;
    public string xAuthyKey;
    public http:Client basicClient;
    public http:Client authyClient;

    public function __init(TwilioConfiguration twilioConfig) {
        self.init(twilioConfig);
        self.basicClient = new(TWILIO_API_BASE_URL, config = twilioConfig.basicClientConfig);
        self.authyClient = new(AUTHY_API_BASE_URL, config = twilioConfig.authyClientConfig);
        self.accountSId = twilioConfig.accountSId;
        self.xAuthyKey = twilioConfig.xAuthyKey;
    }

    # Initialize Twilio endpoint.
    # + twilioConfig - Twilio configuraion
    public function init(TwilioConfiguration twilioConfig);

    # Return account details of the given account-sid.
    # + return - If success, returns account object with basic details, else returns error
    public remote function getAccountDetails() returns Account|error;
};

# Twilio Configuration.
# + accountSId - Unique identifier of the account
# + authToken - The authentication token of the account
# + xAuthyKey - The authentication token for the Authy API
# + basicClientConfig - The HTTP client endpoint for basic configuration
# + authyClientConfig - The HTTP client endpoint for Authy configuration
public type TwilioConfiguration record {
    string accountSId;
    string authToken;
    string xAuthyKey = "";
    http:ClientEndpointConfig basicClientConfig = {};
    http:ClientEndpointConfig authyClientConfig = {};
};

public function Client.init(TwilioConfiguration twilioConfig) {
    http:AuthConfig authConfig = {
                            scheme: http:BASIC_AUTH,
                            username: twilioConfig.accountSId,
                            password: twilioConfig.authToken
    };
    twilioConfig.basicClientConfig.auth = authConfig;
}

public remote function Client.getAccountDetails() returns Account|error {
    string requestPath = TWILIO_ACCOUNTS_API + FORWARD_SLASH + self.accountSId + ACCOUNT_DETAILS;
    var response = self.basicClient->get(requestPath);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAccount(jsonResponse);
}

# Check for HTTP response and if response is success parse HTTP response object into `json` and parse error otherwise.
# + httpResponse - HTTP response or HTTP Connector error with network related errors
# + return - `json` payload or `error` if anything wrong happen when HTTP client invocation or parsing response to `json`
function parseResponseToJson(http:Response|error httpResponse) returns json|error {
    if (httpResponse is http:Response) {
        var jsonResponse = httpResponse.getJsonPayload();
        if (jsonResponse is json) {
            if (httpResponse.statusCode != http:OK_200 && httpResponse.statusCode != http:CREATED_201) {
                string errMsg = jsonResponse.message.toString();
                string errCode = "";
                if (jsonResponse.error_code != ()) {
                    errCode = jsonResponse.error_code.toString();
                } else if (jsonResponse["error"] != ()) {
                    errCode = jsonResponse["error"].toString();
                }
                error err = error(TWILIO_ERROR_CODE,
                { message: httpResponse.statusCode + WHITE_SPACE
                            + httpResponse.reasonPhrase + DASH_WITH_WHITE_SPACES_SYMBOL + errCode
                            + COLON_WITH_WHITE_SPACES_SYMBOL + errMsg });
                return err;
            }
            return jsonResponse;
        } else {
            error err = error(TWILIO_ERROR_CODE,
            { message: "Error occurred while accessing the JSON payload of the response" });
            return err;
        }
    } else {
        error err = error(TWILIO_ERROR_CODE, { message: "Error occurred while invoking the REST API" });
        return err;
    }
}

function mapJsonToAccount(json jsonPayload) returns Account {
    Account account = {};
    account.sid = jsonPayload.sid.toString();
    account.name = jsonPayload.friendly_name.toString();
    account.status = jsonPayload.status.toString();
    account.^"type" = jsonPayload.^"type".toString();
    account.createdDate = jsonPayload.date_created.toString();
    account.updatedDate = jsonPayload.date_updated.toString();
    return account;
}

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
    string ^"type" = "";
    string createdDate = "";
    string updatedDate = "";
};
