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
    F{{twilioConfig}} Reference to TwilioBasicConfiguration type
    F{{twilioConnector}} Reference to TwilioConnector type
}
public type Client object {

    public {
        TwilioConfiguration twilioConfig;
        TwilioConnector twilioConnector = new();
    }

    documentation { Initialize Twilio endpoint
        P{{twilioConfig}} Twilio configuraion
    }
    public function init (TwilioConfiguration twilioConfig) {
        self.twilioConnector.accountSid = twilioConfig.accountSid;
        twilioConfig.basicClientConfig.targets = [{url:BASE_URL}];
        http:AuthConfig authConfig = {scheme:"basic", username:twilioConfig.accountSid, password:twilioConfig.authToken};
        twilioConfig.basicClientConfig.auth = authConfig;
        self.twilioConnector.basicClient.init(twilioConfig.basicClientConfig);
    }

    documentation { Register Twilio connector endpoint
        P{{serviceType}} Accepts types of data (int, float, string, boolean, etc)
    }
    public function register (typedesc serviceType);

    documentation { Start Twilio connector endpoint }
    public function start ();

    documentation { Initialize Twilio endpoint
        R{{}} The Twilio connector object
    }
    public function getClient () returns TwilioConnector {
        return self.twilioConnector;
    }

    documentation { Start Twilio connector endpoint }
    public function stop ();
};

public type TwilioConfiguration {
    string accountSid;
    string authToken;
    http:ClientEndpointConfig basicClientConfig;
};
