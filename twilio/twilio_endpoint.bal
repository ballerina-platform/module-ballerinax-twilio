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
    F{{twilioBasicConfig}} Reference to TwilioBasicConfiguration type
    F{{twilioConnector}} Reference to TwilioConnector type
}
public type BasicClient object {

    public {
        TwilioBasicConfiguration twilioBasicConfig;
        TwilioConnector twilioConnector = new();
    }

    documentation { Initialize Twilio endpoint
        P{{twilioBasicConfig}} Twilio basic configuraion
    }
    public function init (TwilioBasicConfiguration twilioBasicConfig) {
        self.twilioConnector.accountSid = twilioBasicConfig.accountSid;
        twilioBasicConfig.basicClientConfig.targets = [{url:BASE_URL}];
        self.twilioConnector.client.init(twilioBasicConfig.basicClientConfig);
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

public type TwilioBasicConfiguration {
    string accountSid;
    http:ClientEndpointConfig basicClientConfig;
};
