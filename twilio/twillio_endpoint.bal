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

@Description {value:"Initialize Twilio endpoint."}
@Param {value:"twilioConfig:Configuration from Twilio."}
public function <TwilioEndpoint twilioEndpoint> init (TwilioConfiguration twilioConfig) {
    http:HttpClient httpClient = http:createHttpClient(twilioConfig.uri, twilioConfig.clientConfig);
    twilioEndpoint.twilioConnector = {accountSid:twilioConfig.accountSid, authToken:twilioConfig.authToken};
    twilioEndpoint.twilioConnector.clientEndpoint.httpClient = httpClient;
}

@Description {value:"Returns the connector that client code uses."}
@Return {value:"The connector that client code uses."}
public function <TwilioEndpoint twilioEndpoint> getClient () returns TwilioConnector {
    return twilioEndpoint.twilioConnector;
}