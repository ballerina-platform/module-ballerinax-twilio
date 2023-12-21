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

import ballerina/http;
import ballerina/os;
import ballerina/log;


configurable boolean isTestOnLiveServer = os:getEnv("IS_TEST_ON_LIVE_SERVER") == "true";

listener http:Listener listner = new (9090, config = {host: "localhost"});

http:Service mockService = service object {
    # Retrieves a collection of Accounts belonging to the account used to make the request
    #
    # + FriendlyName - Only return the Account resources with friendly names that exactly match this name. 
    # + Status - Only return Account resources with the given status. Can be `closed`, `suspended` or `active`. 
    # + PageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000. 
    # + Page - The page index. This value is simply for client state. 
    # + PageToken - The page token. This is provided by the API. 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts\.json(string? FriendlyName, Account_enum_status? Status, int? PageSize, int? Page, string? PageToken) returns ListAccountResponse {
        Account account =
        {
            auth_token: "AU12345678901234567890123456789012",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            friendly_name: "ballerina_test",
            owner_account_sid: "AC12345678901234567890123456789012",
            sid: "AC12345678901234567890123456789012",
            status: "active"
        };
        Account[] accounts = [account];
        ListAccountResponse listAccountResponse = {
            end: 1,
            accounts: accounts,
            first_page_uri: "/2010-04-01/Accounts.json?PageSize=1&Page=0",
            next_page_uri: "/2010-04-01/Accounts.json?PageSize=1&Page=1",
            page: 0,
            page_size: 1,
            previous_page_uri: "",
            'start: 0,
            uri: "/2010-04-01/Accounts.json?PageSize=1&Page=0"
        };
        return listAccountResponse;
    }
    # Create a new Twilio Subaccount from the account making the request
    #
    # + return - Created 
    resource function post '2010\-04\-01/Accounts\.json() returns Account {
        Account account =
        {
            auth_token: "AU12345678901234567890123456789012",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            friendly_name: "ballerina_test",
            owner_account_sid: "AC12345678901234567890123456789012",
            sid: "AC12345678901234567890123456789012",
            status: "active"
        };
        return account;
    }
    # Fetch the account specified by the provided Account Sid
    #
    # + sidJson - The Account Sid that uniquely identifies the account to fetch 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts/[string sidJson]() returns Account|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        Account account =
        {
            auth_token: "AU12345678901234567890123456789012",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            friendly_name: "ballerina_test",
            owner_account_sid: "AC12345678901234567890123456789012",
            sid: "AC12345678901234567890123456789012",
            status: "active"
        };
        return account;
    }
    # Modify the properties of a given Account
    #
    # + sidJson - The Account Sid that uniquely identifies the account to update 
    # + return - OK 
    resource function post '2010\-04\-01/Accounts/[string sidJson]() returns OkAccount|error {
        return {
            body: {
                auth_token: "AU12345678901234567890123456789012",
                date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
                date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
                friendly_name: "bellerina_test_master",
                owner_account_sid: "AC12345678901234567890123456789012",
                sid: "AC12345678901234567890123456789012",
                status: "active"
            }
        };
    }
    # List the Address resources associated with your account. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to read. 
    # + CustomerName - The `customer_name` of the Address resources to read. 
    # + FriendlyName - The string that identifies the Address resources to read. 
    # + IsoCountry - The ISO country code of the Address resources to read. 
    # + PageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000. 
    # + Page - The page index. This value is simply for client state. 
    # + PageToken - The page token. This is provided by the API. 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts/[string accountSid]/Addresses\.json(string? CustomerName, string? FriendlyName, string? IsoCountry, int? PageSize, int? Page, string? PageToken) returns ListAddressResponse {
        Address address =
        {
            friendly_name: "ballerina_test",
            city: "city_of_ballerina",
            street: "street_of_ballerina",
            customer_name: "ballerina_tester",
            iso_country: "LK",
            postal_code: "00000",
            region: "region_of_ballerina",
            account_sid: "AC12345678901234567890123456789012",
            sid: "AD12345678901234567890123456789012"
        };
        Address[] addresses = [address];
        ListAddressResponse listAddressResponse = {
            addresses: addresses,
            end: 1,
            first_page_uri: "/2010-04-01/Accounts/[string accountSid]/Addresses.json?PageSize=1&Page=0",
            next_page_uri: "/2010-04-01/Accounts/[string accountSid]/Addresses.json?PageSize=1&Page=1",
            page: 0,
            page_size: 1,
            previous_page_uri: "",
            'start: 0,
            uri: "/2010-04-01/Accounts/[string accountSid]/Addresses.json?PageSize=1&Page=0"
        };
        return listAddressResponse;
    }
    # Create a new Address resource. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will be responsible for the new Address resource.
    # + return - Created 
    resource function post '2010\-04\-01/Accounts/[string accountSid]/Addresses\.json() returns Address {
        Address address =
        {
            friendly_name: "ballerina_test",
            city: "city_of_ballerina",
            street: "street_of_ballerina",
            customer_name: "ballerina_tester",
            iso_country: "LK",
            postal_code: "00000",
            region: "region_of_ballerina",
            sid: "AD12345678901234567890123456789012"
        };
        return address;
    }
    # Fetch the Address resource specified by the provided Address Sid.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to fetch. 
    # + sidJson - The Twilio-provided string that uniquely identifies the Address resource to fetch. 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts/[string accountSid]/Addresses/[string sidJson]() returns Address|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        Address address =
        {
            friendly_name: "ballerina_test",
            city: "city_of_ballerina",
            street: "street_of_ballerina",
            customer_name: "ballerina_tester",
            iso_country: "LK",
            postal_code: "00000",
            region: "region_of_ballerina",
            sid: "AD12345678901234567890123456789012"
        };
        return address;
    }
    # Update the Address resource specified by the provided AddressSid. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to update. 
    # + sidJson - The Twilio-provided string that uniquely identifies the Address resource to update. 
    # + return - OK 
    resource function post '2010\-04\-01/Accounts/[string accountSid]/Addresses/[string sidJson]() returns OkAddress|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        Address address =
        {
            friendly_name: "ballerina_test_updated",
            city: "city_of_ballerina",
            street: "street_of_ballerina",
            customer_name: "ballerina_tester",
            iso_country: "LK",
            postal_code: "00000",
            region: "region_of_ballerina",
            sid: "AD12345678901234567890123456789012"
        };
        return {
            body: address
        };
    }
    # Delete the Address resource specified by the provided AddressSid. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to delete. 
    # + sidJson - The Twilio-provided string that uniquely identifies the Address resource to delete. 
    # + return - The resource was deleted successfully. 
    resource function delete '2010\-04\-01/Accounts/[string accountSid]/Addresses/[string sidJson]() returns http:NoContent|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        return {
            headers: {}
        };
    }
    # Retrieves a collection of calls made to and from your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to read. 
    # + To - Only show calls made to this phone number, SIP address, Client identifier or SIM SID. 
    # + From - Only include calls from this phone number, SIP address, Client identifier or SIM SID. 
    # + ParentCallSid - Only include calls spawned by calls with this SID. 
    # + Status - The status of the calls to include. Can be: `queued`, `ringing`, `in-progress`, `canceled`, `completed`, `failed`, `busy`, or `no-answer`. 
    # + StartTime - Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date. 
    # + startedOnOrBefore - Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date. 
    # + startedOnOrAfter - Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date. 
    # + EndTime - Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date. 
    # + endedOnOrBefore - Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date. 
    # + endedOnOrAfter - Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date. 
    # + PageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000. 
    # + Page - The page index. This value is simply for client state. 
    # + PageToken - The page token. This is provided by the API. 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts/[string accountSid]/Calls\.json(string? To, string? From, string? ParentCallSid, Call_enum_status? Status, string? StartTime, string? startedOnOrBefore, string? startedOnOrAfter, string? EndTime, string? endedOnOrBefore, string? endedOnOrAfter, int? PageSize, int? Page, string? PageToken) returns ListCallResponse {
        Call call =
        {
            account_sid: "AC12345678901234567890123456789012",
            answered_by: "answered_by_of_ballerina",
            api_version: "2010-04-01",
            caller_name: "caller_name_of_ballerina",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            direction: "inbound",
            duration: "0",
            end_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            forwarded_from: "forwarded_from_of_ballerina",
            'from: "+098765432101",
            from_formatted: "from_formatted_of_ballerina",
            group_sid: "group_sid_of_ballerina",
            parent_call_sid: "parent_call_sid_of_ballerina",
            phone_number_sid: "phone_number_sid_of_ballerina",
            price: "1",
            price_unit: "price_unit_of_ballerina",
            sid: "sid_of_ballerina",
            start_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            status: "queued",
            to: "+011234567890",
            to_formatted: "to_formatted_of_ballerina",
            uri: "/2010-04-01/Accounts/[string accountSid]/Calls/[string sid].json"
        };
        Call[] calls = [call];
        ListCallResponse listCallResponse = {
            calls: calls,
            end: 1,
            first_page_uri: "/2010-04-01/Accounts/[string accountSid]/Calls.json?PageSize=1&Page=0",
            next_page_uri: "/2010-04-01/Accounts/[string accountSid]/Calls.json?PageSize=1&Page=1",
            page: 0,
            page_size: 1,
            previous_page_uri: "",
            'start: 0,
            uri: "/2010-04-01/Accounts/[string accountSid]/Calls.json?PageSize=1&Page=0"
        };
        return listCallResponse;
    }
    # Create a new outgoing call to phones, SIP-enabled endpoints or Twilio Client connections
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource. 
    # + return - Created 
    resource function post '2010\-04\-01/Accounts/[string accountSid]/Calls\.json() returns Call {
        Call call =
        {
            account_sid: "AC12345678901234567890123456789012",
            answered_by: "answered_by_of_ballerina",
            api_version: "2010-04-01",
            caller_name: "caller_name_of_ballerina",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            direction: "inbound",
            duration: "0",
            end_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            forwarded_from: "forwarded_from_of_ballerina",
            'from: "+098765432101",
            from_formatted: "from_formatted_of_ballerina",
            group_sid: "group_sid_of_ballerina",
            parent_call_sid: "parent_call_sid_of_ballerina",
            phone_number_sid: "phone_number_sid_of_ballerina",
            price: "price_of_ballerina",
            price_unit: "price_unit_of_ballerina",
            sid: "CALL12345678901234567890123456789012",
            start_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            status: "queued",
            to: "+011234567890",
            to_formatted: "to_formatted_of_ballerina",
            uri: "/2010-04-01/Accounts/[string accountSid]/Calls/[string sid].json"
        };
        return call;
    }
    # Fetch the call specified by the provided Call SID
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to fetch. 
    # + sidJson - The SID of the Call resource to fetch. 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts/[string accountSid]/Calls/[string sidJson]() returns Call|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        string sid = sidJson.substring(0, sidJson.length() - 4);
        Call call =
        {
            account_sid: sid,
            answered_by: "answered_by_of_ballerina",
            api_version: "2010-04-01",
            caller_name: "caller_name_of_ballerina",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            direction: "inbound",
            duration: "0",
            end_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            forwarded_from: "forwarded_from_of_ballerina",
            'from: "+098765432101",
            from_formatted: "from_formatted_of_ballerina",
            group_sid: "group_sid_of_ballerina",
            parent_call_sid: "parent_call_sid_of_ballerina",
            phone_number_sid: "phone_number_sid_of_ballerina",
            price: "price_of_ballerina",
            price_unit: "price_unit_of_ballerina",
            sid: sid,
            start_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            status: "queued",
            to: "+011234567890",
            to_formatted: "to_formatted_of_ballerina",
            uri: "/2010-04-01/Accounts/[string accountSid]/Calls/[string sid].json"
        };
        return call;
    }
    # Initiates a call redirect or terminates a call
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to update. 
    # + sidJson - The Twilio-provided string that uniquely identifies the Call resource to update 
    # + payload - The `UpdateCallRequest` record should be used as a payload to update a call 
    # + return - OK 
    resource function post '2010\-04\-01/Accounts/[string accountSid]/Calls/[string sidJson](@http:Payload map<string> payload) returns OkCall|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        string sid = sidJson.substring(0, sidJson.length() - 4);
        Call call =
        {
            account_sid: sid,
            answered_by: "answered_by_of_ballerina",
            api_version: "2010-04-01",
            caller_name: "caller_name_of_ballerina",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            direction: "inbound",
            duration: "0",
            end_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            forwarded_from: "forwarded_from_of_ballerina",
            'from: "+098765432101",
            from_formatted: "from_formatted_of_ballerina",
            group_sid: "group_sid_of_ballerina",
            parent_call_sid: "parent_call_sid_of_ballerina",
            phone_number_sid: "phone_number_sid_of_ballerina",
            price: "price_of_ballerina",
            price_unit: "price_unit_of_ballerina",
            sid: sid,
            start_time: "Mon, 16 Aug 2010 23:18:00 +0000",
            status: "queued",
            to: "+011234567890",
            to_formatted: "to_formatted_of_ballerina",
            uri: "/2010-04-01/Accounts/[string accountSid]/Calls/[string sid].json"
        };
        return {
            body: call
        };
    }
    # Delete a Call record from your account. Once the record is deleted, it will no longer appear in the API and Account Portal logs.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to delete. 
    # + sidJson - The Twilio-provided Call SID that uniquely identifies the Call resource to delete 
    # + return - The resource was deleted successfully. 
    resource function delete '2010\-04\-01/Accounts/[string accountSid]/Calls/[string sidJson]() returns http:Conflict|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        return {
            headers: {}
        };
    }
    # Retrieve a list of Message resources associated with a Twilio Account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resources. 
    # + To - Filter by recipient. For example: Set this `to` parameter to `+15558881111` to retrieve a list of Message resources with `to` properties of `+15558881111` 
    # + From - Filter by sender. For example: Set this `from` parameter to `+15552229999` to retrieve a list of Message resources with `from` properties of `+15552229999` 
    # + DateSent - Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date). 
    # + dateSentOnOrBefore - Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date). 
    # + dateSentOnOrAfter - Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date). 
    # + PageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000. 
    # + Page - The page index. This value is simply for client state. 
    # + PageToken - The page token. This is provided by the API. 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts/[string accountSid]/Messages\.json(string? To, string? From, string? DateSent, string? dateSentOnOrBefore, string? dateSentOnOrAfter, int? PageSize, int? Page, string? PageToken) returns ListMessageResponse {
        Message message =
        {
            account_sid: "AC12345678901234567890123456789012",
            api_version: "2010-04-01",
            body: "body_of_ballerina",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_sent: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            direction: "inbound",
            error_code: 0,
            error_message: "error_message_of_ballerina",
            'from: "+098765432101",
            num_media: "0",
            num_segments: "0",
            price: "price_of_ballerina",
            price_unit: "price_unit_of_ballerina",
            sid: "sid_of_ballerina",
            status: "queued",
            to: "+011234567890",
            uri: "/2010-04-01/Accounts/[string accountSid]/Messages/[string sid].json"
        };
        Message[] messages = [message];
        ListMessageResponse listMessageResponse = {
            messages: messages,
            end: 1,
            first_page_uri: "/2010-04-01/Accounts/[string accountSid]/Messages.json?PageSize=1&Page=0",
            next_page_uri: "/2010-04-01/Accounts/[string accountSid]/Messages.json?PageSize=1&Page=1",
            page: 0,
            page_size: 1,
            previous_page_uri: "",
            'start: 0,
            uri: "/2010-04-01/Accounts/[string accountSid]/Messages.json?PageSize=1&Page=0"
        };
        return listMessageResponse;
    };
    # Send a message
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) creating the Message resource. 
    # + return - Created 
    resource function post '2010\-04\-01/Accounts/[string accountSid]/Messages\.json() returns Message {
        Message message =
        {
            account_sid: "AC12345678901234567890123456789012",
            api_version: "2010-04-01",
            body: "body_of_ballerina",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_sent: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            direction: "inbound",
            error_code: 0,
            error_message: "error_message_of_ballerina",
            'from: "+098765432101",
            num_media: "0",
            num_segments: "0",
            price: "price_of_ballerina",
            price_unit: "price_unit_of_ballerina",
            sid: "sid_of_ballerina",
            status: "queued",
            to: "+011234567890",
            uri: "/2010-04-01/Accounts/[string accountSid]/Messages/[string sid].json"
        };
        return message;
    }
    # Fetch a specific Message
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource 
    # + sidJson - The SID of the Message resource to be fetched 
    # + return - OK 
    resource function get '2010\-04\-01/Accounts/[string accountSid]/Messages/[string sidJson]() returns Message|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        string sid = sidJson.substring(0, sidJson.length() - 4);
        Message message =
        {
            account_sid: "AC12345678901234567890123456789012",
            api_version: "2010-04-01",
            body: "body_of_ballerina",
            date_created: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_sent: "Mon, 16 Aug 2010 23:18:00 +0000",
            date_updated: "Mon, 16 Aug 2010 23:18:00 +0000",
            direction: "inbound",
            error_code: 0,
            error_message: "error_message_of_ballerina",
            'from: "+098765432101",
            num_media: "0",
            num_segments: "0",
            price: "price_of_ballerina",
            price_unit: "price_unit_of_ballerina",
            sid: sid,
            status: "queued",
            to: "+011234567890",
            uri: "/2010-04-01/Accounts/[string accountSid]/Messages/[string sid].json"
        };
        return message;
    }
    # Deletes a Message resource from your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource 
    # + sidJson - The SID of the Message resource you wish to delete 
    # + return - The resource was deleted successfully. 
    resource function delete '2010\-04\-01/Accounts/[string accountSid]/Messages/[string sidJson]() returns http:Conflict|error {
        if !sidJson.endsWith(".json") {
            return error("bad URL");
        }
        return {
            headers: {}
        };
    }
};


function init() returns error? {
    if isTestOnLiveServer {
        log:printInfo("Skiping mock server initialization as the test is running on live server");
        return;
    }
    log:printInfo("Initiating mock server");
    check listner.attach(mockService, "/");
    check listner.'start();
}