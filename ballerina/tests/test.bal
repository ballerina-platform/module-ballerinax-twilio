// Copyright (c) 2023, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/os;
import ballerina/test;

configurable string accountSid = os:getEnv("ACCOUNT_SID");
configurable string authToken = os:getEnv("AUTH_TOKEN");
configurable string toPhoneNumber = os:getEnv("TO_PHONE");
configurable string fromPhoneNumber = os:getEnv("TWILIO_PHONE");

ConnectionConfig config = {auth: {username: accountSid, password: authToken}};
Client twilio = check new Client(config);

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

@test:Config {
    groups: ["twilio_server"],
    enable: true
}
function testListAccount() returns error? {
    ListAccountResponse? responce = check twilio->listAccount();
    if (responce is ListAccountResponse) {
        Account[]? accounts = responce.accounts;
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
    groups: ["twilio_server"],
    enable: true
}
function testFetchAccount() returns error? {
    Account? responce = check twilio->fetchAccount(accountSid);
    if (responce is Account) {
        test:assertEquals(responce?.owner_account_sid, accountSid, "FetchAcoount failed : SID Missmatch");
    } else {
        test:assertFail("FetchAccount Failed : Account Dosen't Exists.");
    }
}

@test:Config {
    groups: ["twilio_server"],
    enable: true
}
function testUpdateAccount() returns error? {
    Account? responce = check twilio->updateAccount(accountSid, upAccReq);
    if (responce is Account) {
        test:assertEquals(responce?.friendly_name, upAccReq.FriendlyName, "UpdateAcoount failed : Name Missmatch");
    } else {
        test:assertFail("UpdateAccount Failed : Account Dosen't Exists.");
    }
}

@test:Config {
    groups: ["twilio_server"],
    enable: true
}
function testCreateAddress() returns error? {
    Address? responce = check twilio->createAddress(crAddReq);
    if (responce is Address) {
        test:assertEquals(responce?.friendly_name, crAddReq.FriendlyName, "CreateAddress failed : Name Missmatch");
        test:assertEquals(responce?.street, crAddReq.Street, "CreateAddress failed : Street Missmatch");
        test:assertEquals(responce?.city, crAddReq.City, "CreateAddress failed : City Missmatch");
        test:assertEquals(responce?.customer_name, crAddReq.CustomerName, "CreateAddress failed : Customer Name Missmatch");
        test:assertEquals(responce?.iso_country, crAddReq.IsoCountry, "CreateAddress failed : Country Missmatch");
        test:assertEquals(responce?.postal_code, crAddReq.PostalCode, "CreateAddress failed : PostalCode Missmatch");
        test:assertEquals(responce?.region, crAddReq.Region, "CreateAddress failed : Region Missmatch");
        string? addressSid = responce?.sid;
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
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testCreateAddress]
}
function testListAddress() returns error? {
    ListAddressResponse? responce = check twilio->listAddress();
    if (responce is ListAddressResponse) {
        Address[]? addresses = responce.addresses;
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
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testCreateAddress]
}
function testFetchAddress() returns error? {
    Address? responce = check twilio->fetchAddress(globalAddressSid);
    if (responce is Address) {
        test:assertEquals(responce?.friendly_name, crAddReq.FriendlyName, "FetchAddress failed : Name Missmatch");
        test:assertEquals(responce?.street, crAddReq.Street, "FetchAddress failed : Street Missmatch");
        test:assertEquals(responce?.city, crAddReq.City, "FetchAddress failed : City Missmatch");
        test:assertEquals(responce?.customer_name, crAddReq.CustomerName, "FetchAddress failed : Customer Name Missmatch");
        test:assertEquals(responce?.iso_country, crAddReq.IsoCountry, "FetchAddress failed : Country Missmatch");
        test:assertEquals(responce?.postal_code, crAddReq.PostalCode, "FetchAddress failed : PostalCode Missmatch");
        test:assertEquals(responce?.region, crAddReq.Region, "FetchAddress failed : Region Missmatch");
    } else {
        test:assertFail("FetchAddress Failed : Account Dosen't Exists.");
    }
}

@test:Config {
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testFetchAddress]
}
function testUpdateAddress() returns error? {
    Address? responce = check twilio->updateAddress(globalAddressSid, upAddReq);
    if (responce is Address) {
        test:assertEquals(responce?.friendly_name, upAddReq.FriendlyName, "UpdateAddress failed : Name Missmatch");
    } else {
        test:assertFail("UpdateAddress Failed : Address Dosen't Exists.");
    }
}

@test:Config {
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testUpdateAddress]
}
function testDeleteAddress() returns error? {
    http:Response? responce = check twilio->deleteAddress(globalAddressSid);
    if (responce is http:Response) {
        test:assertEquals(responce.statusCode, 204, "Delete Address failed");
    } else {
        test:assertFail("Delete Address Failed");
    }
}

@test:Config {
    groups: ["twilio_server"],
    enable: true
}
function testCreateCall() returns error? {
    Call? responce = check twilio->createCall(callReq);
    if (responce is Call) {
        test:assertEquals(responce?.to, callReq.To, "CreateCall failed : Phone Number Missmatch");
        string? sid = responce?.sid;
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
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testCreateCall]
}
function testListCalls() returns error? {
    ListCallResponse? responce = check twilio->listCall();
    if (responce is ListCallResponse) {
        Call[]? calls = responce.calls;
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
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testCreateCall]
}
function testFetchCall() returns error? {
    Call? responce = check twilio->fetchCall(globalCallSid);
    if (responce is Call) {
        test:assertEquals(responce?.to, callReq.To, "FetchCall failed : To Missmatch");
        test:assertEquals(responce?.'from, callReq.From, "FetchCall failed : From Missmatch");
    } else {
        test:assertFail("FetchCall Failed : Call Dosen't Exists.");
    }
}
@test:Config {
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testFetchCall,testListCalls]
}
function testDeleteCall() returns error? {
    http:Response? responce = check twilio->deleteCall(globalCallSid);
    if (responce is http:Response) {
        test:assertEquals(responce.statusCode, 409, "Delete Call failed");
    } else {
        test:assertFail("Delete Call Failed");
    }
}

@test:Config {
    groups: ["twilio_server"],
    enable: true
}
function testCreateMessage() returns error? {
    Message? responce = check twilio->createMessage(msgReq);
    if (responce is Message) {
        test:assertEquals(responce?.to, msgReq.To, "CreateMessage failed : Phone Number Missmatch");
        string? sid = responce?.sid;
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
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testCreateMessage]
}
function testListMessages() returns error? {
    ListMessageResponse? responce = check twilio->listMessage();
    if (responce is ListMessageResponse) {
        Message[]? msgs = responce.messages;
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
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testCreateMessage]
}
function testFetchMessage() returns error? {
    Message? responce = check twilio->fetchMessage(globalMsgSid);
    if (responce is Message) {
        test:assertEquals(responce?.to, msgReq.To, "FetchMessage failed : To Missmatch");
        test:assertEquals(responce?.'from, msgReq.From, "FetchMessage failed : From Missmatch");
    } else {
        test:assertFail("FetchMessage Failed : Message Dosen't Exists.");
    }
}
@test:Config {
    groups: ["twilio_server"],
    enable: true,
    dependsOn: [testFetchMessage,testListMessages]
}
function testDeleteMessage() returns error? {
    http:Response? responce = check twilio->deleteMessage(globalMsgSid);
    if (responce is http:Response) {
        test:assertEquals(responce.statusCode, 409, "Delete Message failed");
    } else {
        test:assertFail("Delete Message Failed");
    }
}