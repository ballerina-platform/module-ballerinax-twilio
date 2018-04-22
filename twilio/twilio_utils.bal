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

import ballerina/util;
import ballerina/http;

@Description {value:"Check for HTTP response and if response is success parse HTTP response object into json and parse error otherwise."}
@Param {value:"response: Http response or HTTP connector error with network related errors."}
@Return {value:"Json payload."}
@Return {value:"Twilio error occured."}
function parseResponseToJson(http:Response|http:HttpConnectorError response) returns (json|TwilioError) {
    json result = {};
    match response {
        http:Response httpResponse => {
            var jsonPayload = httpResponse.getJsonPayload();
            match jsonPayload {
                json payload => {
                    if (httpResponse.statusCode != http:OK_200 && httpResponse.statusCode != http:CREATED_201) {
                        string errMsg = payload.message.toString();
                        string errCode;
                        if (payload.error_code != ()) {
                            errCode = payload.error_code.toString();
                        } else if (payload.error != ()) {
                            errCode = payload.error.toString();
                        }
                        TwilioError twilioError = {message: httpResponse.statusCode + WHITE_SPACE
                            + httpResponse.reasonPhrase + DASH_WITH_WHITE_SPACES_SYMBOL + errCode
                            + COLON_WITH_WHITE_SPACES_SYMBOL + errMsg};
                        return twilioError;
                    }
                    return payload;
                }
                http:PayloadError payloadError => {
                    TwilioError twilioError = {message:"Error occurred when parsing response to json."};
                    twilioError.cause = payloadError.cause;
                    return twilioError;
                }
            }
        }
        http:HttpConnectorError httpError => {
            TwilioError twilioError = {message:"Error occurred when HTTP client invocation."};
            twilioError.cause = httpError.cause;
            return twilioError;
        }
    }
}

@Description {value:"Create url encoded request body with given key and value."}
@Param {value:"requestBody: Request body to be appended values."}
@Param {value:"key: Key of the form value parameter."}
@Param {value:"value: Value of the form value parameter."}
@Return {value:"Created request body with encoded string."}
@Return {value:"Twilio error occured."}
function createUrlEncodedRequestBody(string requestBody, string key, string value) returns (string|TwilioError) {
    var encodedVar = http:encode(value, CHARSET_UTF8);
    string encodedString;
    match encodedVar {
        string encoded => encodedString = encoded;
        error err => {
            TwilioError twilioError = {message:"Error occurred when encoding the value "  + value + " with charset " + CHARSET_UTF8};
            twilioError.cause = err.cause;
            return twilioError;
        }
    }
    if (requestBody != EMPTY_STRING) {
        requestBody += AMPERSAND_SYMBOL;
    }
    return requestBody + key + EQUAL_SYMBOL + encodedString;
}
