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
import ballerina/test;

string mockAccountSid = "AC12345678901234567890123456789012";
string mockAuthToken = "AU12345678901234567890123456789012";
string mockToPhoneNumber = "+011234567890";
string mockFromPhoneNumber = "+098765432101";

Client twilioClientForMockServer = test:mock(Client);

@test:BeforeGroups {
    value: ["mock_tests"]
}
function initializeClientsForMockServer() returns error? {
    log:printInfo("Initializing Twilio Client for Mock Server");
    twilioClientForMockServer = check new (
    {
        auth: {
                username: mockAccountSid,
                password: mockAuthToken
        }
    },
    serviceUrl = "http://localhost:9090/"
    );
}
@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedListAccount() returns error? {
    ListAccountResponse? response = check twilioClientForMockServer->listAccount();
    if (response is ListAccountResponse) {
        Account[]? accounts = response.accounts;
        if accounts is Account[] {
            Account account = accounts[0];
            test:assertEquals(account?.owner_account_sid, mockAccountSid, "ListAccount Failed : SId Missmatch");
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
function testMockedFetchAccount() returns error? {
    Account? response = check twilioClientForMockServer->fetchAccount(mockAccountSid);
    if (response is Account) {
        test:assertEquals(response?.owner_account_sid, mockAccountSid, "FetchAcoount failed : SID Missmatch");
    } else {
        test:assertFail("FetchAccount Failed : Account Dosen't Exists.");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedUpdateAccount() returns error? {
    Account? response = check twilioClientForMockServer->updateAccount(mockAccountSid, upAccReq);
    if (response is Account) {
        test:assertEquals(response?.friendly_name, upAccReq.FriendlyName, "UpdateAcoount failed : Name Missmatch");
    } else {
        test:assertFail("UpdateAccount Failed : Account Dosen't Exists.");
    }
}
@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedCreateAddress() returns error? {
    Address? response = check twilioClientForMockServer->createAddress(crAddReq);
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
    groups: ["mock_tests"],
    enable: true
}
function testMockedListAddress() returns error? {
    ListAddressResponse? response = check twilioClientForMockServer->listAddress();
    if (response is ListAddressResponse) {
        Address[]? addresses = response.addresses;
        if addresses is Address[] {
            Address address = addresses[0];
            test:assertEquals(address?.account_sid, mockAccountSid, "ListAddress Failed : SId Missmatch");
        } else {
            test:assertFail("ListAddress Failed : Account Dosen't Exists.");
        }
    } else {
        test:assertFail("ListAddress Failed : Wrong Responce Type.");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedFetchAddress() returns error? {
    Address? response = check twilioClientForMockServer->fetchAddress(globalAddressSid);
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
    groups: ["mock_tests"],
    enable: true
}
function testMockedUpdateAddress() returns error? {
    Address? response = check twilioClientForMockServer->updateAddress(globalAddressSid, upAddReq);
    if (response is Address) {
        test:assertEquals(response?.friendly_name, upAddReq.FriendlyName, "UpdateAddress failed : Name Missmatch");
    } else {
        test:assertFail("UpdateAddress Failed : Address Dosen't Exists.");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedDeleteAddress() returns error? {
    http:Response? response = check twilioClientForMockServer->deleteAddress(globalAddressSid);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 204, "Delete Address failed");
    } else {
        test:assertFail("Delete Address Failed");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedCreateCall() returns error? {
    Call? response = check twilioClientForMockServer->createCall(callReq);
    if (response is Call) {
        test:assertEquals(response?.to, mockToPhoneNumber, "CreateCall failed : Phone Number Missmatch");
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
    groups: ["mock_tests"],
    enable: true
}
function testMockedListCalls() returns error? {
    ListCallResponse? response = check twilioClientForMockServer->listCall();
    if (response is ListCallResponse) {
        Call[]? calls = response.calls;
        if calls is Call[] {
            Call call = calls[0];
            test:assertEquals(call?.account_sid, mockAccountSid, "ListCall Failed : SId Missmatch");
        } else {
            test:assertFail("ListCall Failed : Calls Dosen't Exists.");
        }
    } else {
        test:assertFail("ListCall Failed : Wrong Responce Type.");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedFetchCall() returns error? {
    Call? response = check twilioClientForMockServer->fetchCall(globalCallSid);
    if (response is Call) {
        test:assertEquals(response?.to, mockToPhoneNumber, "FetchCall failed : To Missmatch");
        test:assertEquals(response?.'from, mockFromPhoneNumber, "FetchCall failed : From Missmatch");
    } else {
        test:assertFail("FetchCall Failed : Call Dosen't Exists.");
    }
}
@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedDeleteCall() returns error? {
    http:Response? response = check twilioClientForMockServer->deleteCall(globalCallSid);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 204, "Delete Call failed");
    } else {
        test:assertFail("Delete Call Failed");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedCreateMessage() returns error? {
    Message? response = check twilioClientForMockServer->createMessage(msgReq);
    if (response is Message) {
        test:assertEquals(response?.to, mockToPhoneNumber, "CreateMessage failed : Phone Number Missmatch");
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
    groups: ["mock_tests"],
    enable: true
}
function testMockedListMessages() returns error? {
    ListMessageResponse? response = check twilioClientForMockServer->listMessage();
    if (response is ListMessageResponse) {
        Message[]? msgs = response.messages;
        if msgs is Message[] {
            Message msg = msgs[0];
            test:assertEquals(msg?.account_sid, mockAccountSid, "ListMessage Failed : SId Missmatch");
        } else {
            test:assertFail("ListMessage Failed : Messages Dosen't Exists.");
        }
    } else {
        test:assertFail("ListMessage Failed : Wrong Responce Type.");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedFetchMessage() returns error? {
    Message? response = check twilioClientForMockServer->fetchMessage(globalMsgSid);
    if (response is Message) {
        test:assertEquals(response?.to, mockToPhoneNumber, "FetchMessage failed : To Missmatch");
        test:assertEquals(response?.'from,mockFromPhoneNumber, "FetchMessage failed : From Missmatch");
    } else {
        test:assertFail("FetchMessage Failed : Message Dosen't Exists.");
    }
}
@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testMockedDeleteMessage() returns error? {
    http:Response? response = check twilioClientForMockServer->deleteMessage(globalMsgSid);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 204, "Delete Message failed");
    } else {
        test:assertFail("Delete Message Failed");
    }
}
