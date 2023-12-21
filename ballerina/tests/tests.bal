// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import twilio.mock as _;

import ballerina/http;
import ballerina/log;
import ballerina/os;
import ballerina/test;

configurable boolean isTestOnLiveServer = os:getEnv("IS_TEST_ON_LIVE_SERVER") == "true";

// Configurables
configurable string accountSid = isTestOnLiveServer ? os:getEnv("ACCOUNT_SID"): "AC12345678901234567890123456789012";
configurable string authToken = isTestOnLiveServer ? os:getEnv("AUTH_TOKEN"): "AU12345678901234567890123456789012";
configurable string toPhoneNumber = isTestOnLiveServer ? os:getEnv("TO_PHONE"): "+011234567890";
configurable string fromPhoneNumber = isTestOnLiveServer ? os:getEnv("TWILIO_PHONE"): "+098765432101";

Client twilio = test:mock(Client);

// Common test data
string sampleName = "ballerina_test";
string messageBody = "Hello from Ballerina!";
string recordingURL = "http://demo.twilio.com/docs/voice.xml";
string globalCallSid = "";
string globalAddressSid = "";
string globalMsgSid = "";

CreateAccountRequest crAccReq = {
    FriendlyName: sampleName
};
UpdateAccountRequest upAccReq = {
    FriendlyName: "bellerina_test_master"
};
CreateAddressRequest crAddReq = {
    FriendlyName: sampleName,
    City: "city_of_ballerina",
    Street: "street_of_ballerina",
    CustomerName: "ballerina_tester",
    IsoCountry: "LK",
    PostalCode: "00000",
    Region: "region_of_ballerina"
};
UpdateAddressRequest upAddReq = {
    FriendlyName: "ballerina_test_updated"
};
CreateCallRequest callReq = {
    To: toPhoneNumber,
    From: fromPhoneNumber,
    Url: recordingURL
};
CreateMessageRequest msgReq = {
    To: toPhoneNumber,
    From: fromPhoneNumber,
    Body: messageBody
};


@test:BeforeSuite
function initializeClientsForTwilioServer () returns error? {
    if (isTestOnLiveServer) {
        log:printInfo("Running tests on actual server");
        twilio = check new ({auth: {username: accountSid, password: authToken}});
    } else {
        log:printInfo("Running tests on mock server");
        twilio = check new ({auth: {username: accountSid, password: authToken}}, serviceUrl = "http://localhost:9090/");
    }
}
@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true
}
function testListAccount() returns error? {
    ListAccountResponse? response = check twilio->listAccount();
    if (response is ListAccountResponse) {
        Account[]? accounts = response.accounts;
        if accounts is Account[] {
            Account account = accounts[0];
            test:assertEquals(account?.owner_account_sid, accountSid, "ListAccount Failed : SId Missmatch");
        } else {
            test:assertFail("ListAccount Failed : Account Dosen't Exists.");
        }
    } else {
        test:assertFail("ListAccount Failed : Wrong Responce Type.");
    }
}
@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testCreateAccount() returns error? {
    Account? response = check twilio->createAccount(crAccReq);
    if (response is Account) {
        test:assertEquals(response?.friendly_name, crAccReq.FriendlyName, "CreateAcoount failed : Name Missmatch");
        string? accountSid = response?.sid;
        if accountSid is string {
            accountSid = accountSid;
        } else {
            test:assertFail("CreateAccount Failed : Account SID Dosen't Exists.");
        }
    } else {
        test:assertFail("CreateAccount Failed : Account Dosen't Exists.");
    }
}
@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true
}
function testFetchAccount() returns error? {
    Account? response = check twilio->fetchAccount(accountSid);
    if (response is Account) {
        test:assertEquals(response?.owner_account_sid, accountSid, "FetchAcoount failed : SID Missmatch");
    } else {
        test:assertFail("FetchAccount Failed : Account Dosen't Exists.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true
}
function testUpdateAccount() returns error? {
    Account? response = check twilio->updateAccount(accountSid, upAccReq);
    if (response is Account) {
        test:assertEquals(response?.friendly_name, upAccReq.FriendlyName, "UpdateAcoount failed : Name Missmatch");
    } else {
        test:assertFail("UpdateAccount Failed : Account Dosen't Exists.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true
}
function testCreateAddress() returns error? {
    Address? response = check twilio->createAddress(crAddReq);
    if (response is Address) {
        test:assertEquals(response?.friendly_name, crAddReq.FriendlyName, "CreateAddress failed : Name Missmatch");
        test:assertEquals(response?.street, crAddReq.Street, "CreateAddress failed : Street Missmatch");
        test:assertEquals(response?.city, crAddReq.City, "CreateAddress failed : City Missmatch");
        test:assertEquals(response?.customer_name, crAddReq.CustomerName, "CreateAddress failed : Customer Name Missmatch");
        test:assertEquals(response?.iso_country, crAddReq.IsoCountry, "CreateAddress failed : Country Missmatch");
        test:assertEquals(response?.postal_code, crAddReq.PostalCode, "CreateAddress failed : PostalCode Missmatch");
        test:assertEquals(response?.region, crAddReq.Region, "CreateAddress failed : Region Missmatch");
        string? addressSid = response?.sid;
        if addressSid is string {
            globalAddressSid = addressSid;
        } else {
            test:assertFail("CreateAddress Failed : Address SID Dosen't Exists.");
        }
    } else {
        test:assertFail("CreateAddress Failed : Address Dosen't Exists.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testCreateAddress]
}
function testListAddress() returns error? {
    ListAddressResponse? response = check twilio->listAddress();
    if (response is ListAddressResponse) {
        Address[]? addresses = response.addresses;
        if addresses is Address[] {
            Address address = addresses[0];
            test:assertEquals(address?.account_sid, accountSid, "ListAddress Failed : SId Missmatch");
        } else {
            test:assertFail("ListAddress Failed : Account Dosen't Exists.");
        }
    } else {
        test:assertFail("ListAddress Failed : Wrong Responce Type.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testCreateAddress]
}
function testFetchAddress() returns error? {
    Address? response = check twilio->fetchAddress(globalAddressSid);
    if (response is Address) {
        test:assertEquals(response?.friendly_name, crAddReq.FriendlyName, "FetchAddress failed : Name Missmatch");
        test:assertEquals(response?.street, crAddReq.Street, "FetchAddress failed : Street Missmatch");
        test:assertEquals(response?.city, crAddReq.City, "FetchAddress failed : City Missmatch");
        test:assertEquals(response?.customer_name, crAddReq.CustomerName, "FetchAddress failed : Customer Name Missmatch");
        test:assertEquals(response?.iso_country, crAddReq.IsoCountry, "FetchAddress failed : Country Missmatch");
        test:assertEquals(response?.postal_code, crAddReq.PostalCode, "FetchAddress failed : PostalCode Missmatch");
        test:assertEquals(response?.region, crAddReq.Region, "FetchAddress failed : Region Missmatch");
    } else {
        test:assertFail("FetchAddress Failed : Account Dosen't Exists.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testFetchAddress]
}
function testUpdateAddress() returns error? {
    Address? response = check twilio->updateAddress(globalAddressSid, upAddReq);
    if (response is Address) {
        test:assertEquals(response?.friendly_name, upAddReq.FriendlyName, "UpdateAddress failed : Name Missmatch");
    } else {
        test:assertFail("UpdateAddress Failed : Address Dosen't Exists.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testUpdateAddress]
}
function testDeleteAddress() returns error? {
    http:Response? response = check twilio->deleteAddress(globalAddressSid);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 204, "Delete Address failed");
    } else {
        test:assertFail("Delete Address Failed");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true
}
function testCreateCall() returns error? {
    Call? response = check twilio->createCall(callReq);
    if (response is Call) {
        test:assertEquals(response?.to, callReq.To, "CreateCall failed : Phone Number Missmatch");
        string? sid = response?.sid;
        if sid is string {
            globalCallSid = sid;
        } else {
            test:assertFail("CreateCall Failed : Call SID Dosen't Exists.");
        }
    } else {
        test:assertFail("CreateCall Failed : Call Dosen't Exists.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testCreateCall]
}
function testListCalls() returns error? {
    ListCallResponse? response = check twilio->listCall();
    if (response is ListCallResponse) {
        Call[]? calls = response.calls;
        if calls is Call[] {
            Call call = calls[0];
            test:assertEquals(call?.account_sid, accountSid, "ListCall Failed : SId Missmatch");
        } else {
            test:assertFail("ListCall Failed : Calls Dosen't Exists.");
        }
    } else {
        test:assertFail("ListCall Failed : Wrong Responce Type.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testCreateCall]
}
function testFetchCall() returns error? {
    Call? response = check twilio->fetchCall(globalCallSid);
    if (response is Call) {
        test:assertEquals(response?.to, callReq.To, "FetchCall failed : To Missmatch");
        test:assertEquals(response?.'from, callReq.From, "FetchCall failed : From Missmatch");
    } else {
        test:assertFail("FetchCall Failed : Call Dosen't Exists.");
    }
}
@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testFetchCall,testListCalls]
}
function testDeleteCall() returns error? {
    http:Response? response = check twilio->deleteCall(globalCallSid);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 409, "Delete Call failed");
    } else {
        test:assertFail("Delete Call Failed");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true
}
function testCreateMessage() returns error? {
    Message? response = check twilio->createMessage(msgReq);
    if (response is Message) {
        test:assertEquals(response?.to, msgReq.To, "CreateMessage failed : Phone Number Missmatch");
        string? sid = response?.sid;
        if sid is string {
            globalMsgSid = sid;
        } else {
            test:assertFail("CreateMessage Failed : Call SID Dosen't Exists.");
        }
    } else {
        test:assertFail("CreateMessage Failed : Call Dosen't Exists.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testCreateMessage]
}
function testListMessages() returns error? {
    ListMessageResponse? response = check twilio->listMessage();
    if (response is ListMessageResponse) {
        Message[]? msgs = response.messages;
        if msgs is Message[] {
            Message msg = msgs[0];
            test:assertEquals(msg?.account_sid, accountSid, "ListMessage Failed : SId Missmatch");
        } else {
            test:assertFail("ListMessage Failed : Messages Dosen't Exists.");
        }
    } else {
        test:assertFail("ListMessage Failed : Wrong Responce Type.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testCreateMessage]
}
function testFetchMessage() returns error? {
    Message? response = check twilio->fetchMessage(globalMsgSid);
    if (response is Message) {
        test:assertEquals(response?.to, msgReq.To, "FetchMessage failed : To Missmatch");
        test:assertEquals(response?.'from, msgReq.From, "FetchMessage failed : From Missmatch");
    } else {
        test:assertFail("FetchMessage Failed : Message Dosen't Exists.");
    }
}
@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testFetchMessage,testListMessages]
}
function testDeleteMessage() returns error? {
    http:Response? response = check twilio->deleteMessage(globalMsgSid);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 409, "Delete Message failed");
    } else {
        test:assertFail("Delete Message Failed");
    }
}