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

import ballerina/http;

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

# Create URL encoded request body with given key and value.
# + requestBody - Request body to be appended values
# + key - Key of the form value parameter
# + value - Value of the form value parameter
# + return - Created request body with encoded string or `error` if anything wrong happen when encoding the value
function createUrlEncodedRequestBody(string requestBody, string key, string value) returns string|error {
    var encodedVar = http:encode(value, CHARSET_UTF8);
    string encodedString = "";
    string body = "";
    if (encodedVar is string) {
        encodedString = encodedVar;
    } else {
        error err = error(TWILIO_ERROR_CODE, { message: "Error occurred while encoding the string" });
        return err;
    }
    if (requestBody != EMPTY_STRING) {
        body = requestBody + AMPERSAND_SYMBOL;
    }
    return body + key + EQUAL_SYMBOL + encodedString;
}
