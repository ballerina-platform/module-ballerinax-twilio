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

package twilio;

import ballerina/net.http;

@Description {value:"Get account details of the given account-sid."}
@Return {value:"json of account details."}
@Return {value:"err: returns error if an exception raised in getting account details."}
public function <TwilioConnector twilioConnector> getAccountDetails () returns (json|error) {
    endpoint http:ClientEndpoint clientEndpoint = twilioConnector.clientEndpoint;
    http:Request request = {};
    twilioConnector.constructAuthenticationHeaders(request);
    string requestPath = ACCOUNTS_API + twilioConnector.accountSid + SYMBOL_FORWARD_SLASH + RESPONSE_TYPE_JSON;
    var response = clientEndpoint -> get(requestPath, request);
    match response {
        http:Response httpResponse => {
            return httpResponse.getJsonPayload();
        }
        error err => {
            return err;
        }
    }
}