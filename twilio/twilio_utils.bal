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

import ballerina/util;

@Description {value:"Add authentication headers as basic authentication to the HTTP request."}
@Param {value:"request: http OutRequest."}
public function <TwilioConnector twilioConnector> constructAuthenticationHeaders (http:Request request) {
    request.addHeader("Authorization", "Basic " + util:base64Encode(twilioConnector.accountSid + ":" + twilioConnector.authToken));
}

@Description {value:"Parse http response object into json."}
@Param {value:"response: http response or http connector error with network related errors."}
@Return {value:"Json payload."}
@Return {value:"Error occured."}
public function parseResponseToJson (http:Response|http:HttpConnectorError response) returns (json|error) {
    json result = {};
    match response {
        http:Response httpResponse => {
            var jsonPayload = httpResponse.getJsonPayload();
            match jsonPayload {
                json payload => return payload;
                http:PayloadError payloadError => return payloadError;
            }
        }
        http:HttpConnectorError httpError => return httpError;
    }
}