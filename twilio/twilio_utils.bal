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

import ballerina/net.uri;
import ballerina/util;

@Description {value:"Create basic authorization header value with encoded account sid and auth token."}
@Return {value:"Encoded header value."}
public function <TwilioConnector twilioConnector> getAuthorizationHeaderValue () returns string {
    return BASIC + WHITE_SPACE + util:base64Encode(twilioConnector.accountSid + COLON_SYMBOL + twilioConnector.authToken);
}

@Description {value:"Add headers to the HTTP request."}
public function <TwilioConnector twilioConnector> constructRequestHeaders (http:Request request, string key, string value) {
    request.addHeader(key, value);
}

@Description {value:"Parse http response object into json."}
@Param {value:"response: Http response or http connector error with network related errors."}
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

@Description {value:"Create url encoded request body with given key and value."}
@Param {value:"requestBody: Request body to be appended values."}
@Param {value:"key: Key of the form value parameter."}
@Param {value:"value: Value of the form value parameter."}
@Return {value:"Created request body with encoded string."}
function createUrlEncodedRequestBody (string requestBody, string key, string value) returns (string|error) {
    var encodedVar = uri:encode(value, CHARSET_UTF8);
    string encodedString;
    match encodedVar {
        string encoded => encodedString = encoded;
        error err => return err;
    }
    if (requestBody != EMPTY_STRING) {
        requestBody = requestBody + AMPERSAND_SYMBOL;
    }
    return requestBody + key + EQUAL_SYMBOL + encodedString;
}
