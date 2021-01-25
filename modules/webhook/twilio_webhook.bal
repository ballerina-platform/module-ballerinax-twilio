// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/websub;

////////////////////////////////////////////////////////////////////
/// Twilio Webhook Listener (WebSub Subscriber Service Listener) ///
////////////////////////////////////////////////////////////////////
# Object representing the Twilio Webhook (WebSub Subscriber Service) Listener.
public class TwilioWebhookListener {

    private websub:Listener websubListener;

    public isolated function init(int port) {
        websub:SubscriberListenerConfiguration slConfig = {};
        self.websubListener = new (port, slConfig);
    }

    public isolated function attach(service object {} s, string[]|string? name = ()) returns error? {
        return self.websubListener.attach(s, name);
    }

    public isolated function detach(service object {} s) returns error? {
        return self.websubListener.detach(s);
    }

    public function 'start() returns error? {
        return self.websubListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        return self.websubListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        return self.websubListener.immediateStop();
    }

    # Returns TwilioEvent corresponding to the incoming Notification
    # + notification - websub Notification object containing the event payload and information
    # + return - If success, returns TwilioEvent object, else returns error
    public isolated function getEventType(websub:Notification notification) returns @tainted error|TwilioEvent {
        map<string> ss = check notification.getFormParams();
        TwilioEvent eventPayload = check ss.cloneWithType(TwilioEvent);
        return eventPayload;
    }
}

