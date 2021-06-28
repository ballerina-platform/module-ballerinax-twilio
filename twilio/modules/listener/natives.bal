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

import ballerina/jballerina.java;

isolated class HttpToTwilioAdaptor {
    isolated function init(SimpleHttpService serviceObj) returns error? {
        externInit(self, serviceObj);
    }

    isolated function callOnSmsReceived(SmsStatusChangeEvent event) returns error? = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;

    isolated function callOnSmsQueued(SmsStatusChangeEvent event) returns error? = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;

    isolated function callOnSmsSent(SmsStatusChangeEvent event) returns error? = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;

    isolated function callOnSmsDelivered(SmsStatusChangeEvent event) returns error? = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;

    isolated function callOnCallRang(CallStatusChangeEvent event) returns error? = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;

    isolated function callOnCallAnswered(CallStatusChangeEvent event) returns error? = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;

    isolated function callOnCallCompleted(CallStatusChangeEvent event) returns error? = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;

    # Invoke native method to retrieve implemented method names in the subscriber service
    #
    # + return - {@code string[]} containing the method-names in current implementation
    isolated function getServiceMethodNames() returns string[] = @java:Method {
        'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
    } external;
}

isolated function externInit(HttpToTwilioAdaptor adaptor, SimpleHttpService serviceObj) = @java:Method {
    'class: "org.ballerinalang.twilio.NativeHttpToTwilioAdaptor"
} external;