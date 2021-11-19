//Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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


# Listener for the Twilio connector
@display {label: "Twilio Listener", iconPath: "resources/twilio.svg"}
public class Listener {
    private HttpService? httpService;
    private http:Listener httpListener;
    private string callbackUrl = "";
    private string authToken = "";
    
    public isolated function init(@display{label: "Port to listen on"} int port, 
                                  @display{label: "Auth Token"} string authToken, 
                                  @display{label: "Callback URL"} string callbackUrl) returns error? {
        self.authToken = authToken;
        self.callbackUrl = callbackUrl;
        self.httpListener = check new (port);
        self.httpService = ();
    }

    public isolated function attach(SimpleHttpService s, string[]|string? name) returns error? {  
        HttpToTwilioAdaptor adaptor = check new (s);    
        HttpService currentHttpService = new HttpService(adaptor, self.callbackUrl, self.authToken);
        self.httpService = currentHttpService;
        check self.httpListener.attach(currentHttpService, name);
    }

    public isolated function detach(SimpleHttpService s) returns error? {
        HttpService? currentHttpService = self.httpService;
        if currentHttpService is HttpService {
            return self.httpListener.detach(currentHttpService);
        } 
    }

    public isolated function 'start() returns error? {
        return self.httpListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        return self.httpListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        return self.httpListener.immediateStop();
    }
}
