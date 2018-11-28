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

// This guide is created for the reference of "How to Extend Ballerina" in ballerina.io
// https://ballerina.io/learn/how-to-extend-ballerina/

import ballerina/http;
import ballerina/io;

// Endpoint
documentation {Object for Twilio endpoint.
    F{{twilioConfig}} Reference to TwilioBasicConfiguration type
    F{{twilioConnector}} Reference to TwilioConnector type
}
public type TwilioClient object {

    public TwilioConfiguration twilioConfig;
    public TwilioConnector twilioConnector = new;

    documentation { Initialize Twilio endpoint
        P{{config}} Twilio configuraion
    }
    public function init(TwilioConfiguration config);

    documentation { Initialize Twilio endpoint
        R{{}} The Twilio connector object
    }
    public function getCallerActions() returns TwilioConnector;

};

// Configuration
documentation {
    F{{clientConfig}} The http client endpoint for basic configuration
}
public type TwilioConfiguration record {
    http:ClientEndpointConfig clientConfig;
};

// Connector
documentation {Object to initialize the connection with Twilio.
    F{{accountSId}} Unique identifier of the account
    F{{client}} Http client endpoint for basic api
}
public type TwilioConnector object {

    public string accountSId;
    public http:Client client;

    documentation { Return account details of the given account-sid
        R{{}} If success, returns account object with basic details, else returns error
    }
    public function getAccountDetails() returns Account|error;
};

//Record to represent type
documentation {
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

// Constants
@final string BASE_URL = "https://api.twilio.com/2010-04-01";
@final string ACCOUNTS_API = "/Accounts/";
@final string RESPONSE_TYPE_JSON = ".json";
@final string EMPTY_STRING = "";

// =========== Implementation of the Endpoint
function TwilioClient::init(TwilioConfiguration config) {

    config.clientConfig.url = BASE_URL;
    string username;
    string password;

    var usernameOrEmpty = config.clientConfig.auth.username;
    match usernameOrEmpty {
        string usernameString => username = usernameString;
        () => {
            error err = { message: "Username cannot be empty" };
            throw err;
        }
    }

    var passwordOrEmpty = config.clientConfig.auth.password;
    match passwordOrEmpty {
        string passwordString => password = passwordString;
        () => {
            error err = { message: "Password cannot be empty" };
            throw err;
        }
    }

    self.twilioConnector.accountSId = username;
    self.twilioConnector.client.init(config.clientConfig);
}

function TwilioClient::getCallerActions() returns TwilioConnector {
    return self.twilioConnector;
}
// =========== End of implementation of the Endpoint


// =========== Implementation for Connector
function TwilioConnector::getAccountDetails() returns Account|error {
    endpoint http:Client httpClient = self.client;
    string requestPath = ACCOUNTS_API + self.accountSId + RESPONSE_TYPE_JSON;
    var response = httpClient->get(requestPath);
    json jsonResponse = check parseResponseToJson(response);
    return mapJsonToAccount(jsonResponse);
}
// =========== End of implementation for Connector


// =========== Implementation of Util methods
function parseResponseToJson(http:Response|error response) returns json|error {
    json result = {};
    match response {
        http:Response httpResponse => {
            var jsonPayload = httpResponse.getJsonPayload();
            match jsonPayload {
                json payload => {
                    return payload;
                }
                error err => {
                    return err;
                }
            }
        }
        error err => {
            return err;
        }
    }
}

function mapJsonToAccount(json jsonPayload) returns Account {
    Account account;
    account.sid = jsonPayload.sid.toString();
    account.name = jsonPayload.friendly_name.toString();
    account.status = jsonPayload.status.toString();
    account.^"type" = jsonPayload.^"type".toString();
    account.createdDate = jsonPayload.date_created.toString();
    account.updatedDate = jsonPayload.date_updated.toString();
    return account;
}
// =========== End of implementation of Util methods


function main(string... args) {
    endpoint TwilioClient twilioClient {
        clientConfig: {
            auth: {
                scheme: http:BASIC_AUTH,
                username: "",
                password: ""
            }
        }
    };

    Account account = check twilioClient->getAccountDetails();
    io:println(account);
}
