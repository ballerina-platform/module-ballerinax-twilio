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

//todo:Verify by signing secret
public class Listener {
    private HttpService httpService;

    private http:Listener httpListener;

    private string callbackUrl = "";
    private string authToken = "";
    
    public isolated function init(int port, string authToken, string callbackUrl) returns error? {
        self.authToken = authToken;
        self.callbackUrl = callbackUrl;
        self.httpListener = check new (port);
    }

    public isolated function attach(SimpleHttpService s, string[]|string? name) returns error? {       
        self.httpService = new HttpService(s, self.callbackUrl, self.authToken);
        check self.httpListener.attach(self.httpService, name);
    }

    public isolated function detach(SimpleHttpService s) returns error? {
        return self.httpListener.detach(s);
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
