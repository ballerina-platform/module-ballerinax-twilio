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

import ballerina/http;

documentation {Object for Twilio endpoint.
    F{{clientConfig}} Reference to http:ClientEndpointConfig type
    F{{twilioConnector}} Reference to TwilioConnector type
}
public type Client object {

    public {
        http:ClientEndpointConfig clientConfig;
        TwilioConnector twilioConnector = new();
    }

    documentation { Initialize Twilio endpoint
        P{{clientConfig}} HTTP configuration for Twilio
    }
    public function init (http:ClientEndpointConfig clientConfig);

    documentation { Register Twilio connector endpoint
        P{{serviceType}} Accepts types of data (int, float, string, boolean, etc)
    }
    public function register (typedesc serviceType);

    documentation { Start Twilio connector endpoint }
    public function start ();

    documentation { Initialize Twilio endpoint
        R{{}} The Twilio connector object
    }
    public function getClient () returns TwilioConnector;

    documentation { Start Twilio connector endpoint }
    public function stop ();
};

public function Client::init(http:ClientEndpointConfig clientConfig) {
    match clientConfig.auth {
        () => {}
        http:AuthConfig authConfig => self.twilioConnector.accountSid = authConfig.username;
    }
    clientConfig.targets = [{url:BASE_URL}];
    self.twilioConnector.client.init(clientConfig);
}

public function Client::getClient() returns TwilioConnector {
    return self.twilioConnector;
}

public function Client::start() {}

public function Client::stop() {}

public function Client::register(typedesc serviceType) {}
