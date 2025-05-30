// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

import ballerina/data.jsondata;
import ballerina/http;

# This is the public Twilio REST API.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.twilio.com/2010-04-01") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, http1Settings: config.http1Settings, http2Settings: config.http2Settings, timeout: config.timeout, forwarded: config.forwarded, followRedirects: config.followRedirects, poolConfig: config.poolConfig, cache: config.cache, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, cookieConfig: config.cookieConfig, responseLimits: config.responseLimits, secureSocket: config.secureSocket, proxy: config.proxy, socketConfig: config.socketConfig, validation: config.validation, laxDataBinding: config.laxDataBinding};
        self.clientEp = check new (serviceUrl, httpClientConfig);
    }

    # Retrieves a collection of Accounts belonging to the account used to make the request
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAccount(map<string|string[]> headers = {}, *ListAccountQueries queries) returns ListAccountResponse|error {
        string resourcePath = string `/Accounts.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new Twilio Subaccount from the account making the request
    #
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateAccountRequest` record should be used as a payload to create a Subaccount 
    # + return - Created 
    remote isolated function createAccount(CreateAccountRequest payload, map<string|string[]> headers = {}) returns Account|error {
        string resourcePath = string `/Accounts.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch the account specified by the provided Account Sid
    #
    # + sid - The Account Sid that uniquely identifies the account to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchAccount(string sid, map<string|string[]> headers = {}) returns Account|error {
        string resourcePath = string `/Accounts/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Modify the properties of a given Account
    #
    # + sid - The Account Sid that uniquely identifies the account to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateAccountRequest` record should be used as a payload to update an Account 
    # + return - OK 
    remote isolated function updateAccount(string sid, UpdateAccountRequest payload, map<string|string[]> headers = {}) returns Account|error {
        string resourcePath = string `/Accounts/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # List the Address resources associated with your account. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAddress(string accountSid, map<string|string[]> headers = {}, *ListAddressQueries queries) returns ListAddressResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Addresses.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new Address resource. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will be responsible for the new Address resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateAddressRequest` record should be used as a payload to create a new Address resource 
    # + return - Created 
    remote isolated function createAddress(string accountSid, CreateAddressRequest payload, map<string|string[]> headers = {}) returns Address|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Addresses.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch the Address resource specified by the provided Address Sid.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Address resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchAddress(string accountSid, string sid, map<string|string[]> headers = {}) returns Address|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Addresses/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update the Address resource specified by the provided AddressSid. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to update
    # + sid - The Twilio-provided string that uniquely identifies the Address resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateAddressRequest` record should be used as a payload to update an Address 
    # + return - OK 
    remote isolated function updateAddress(string accountSid, string sid, UpdateAddressRequest payload, map<string|string[]> headers = {}) returns Address|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Addresses/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete the Address resource specified by the provided AddressSid. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to delete
    # + sid - The Twilio-provided string that uniquely identifies the Address resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteAddress(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Addresses/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of applications representing an application within the requesting account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listApplication(string accountSid, map<string|string[]> headers = {}, *ListApplicationQueries queries) returns ListApplicationResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Applications.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new application within your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateApplicationRequest` record should be used as a payload to create a new Application resource 
    # + return - Created 
    remote isolated function createApplication(string accountSid, CreateApplicationRequest payload, map<string|string[]> headers = {}) returns Application|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Applications.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch the application specified by the provided sid
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Application resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchApplication(string accountSid, string sid, map<string|string[]> headers = {}) returns Application|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Applications/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Updates the application's properties
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resources to update
    # + sid - The Twilio-provided string that uniquely identifies the Application resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateApplicationRequest` record should be used as a payload to update an Application 
    # + return - OK 
    remote isolated function updateApplication(string accountSid, string sid, UpdateApplicationRequest payload, map<string|string[]> headers = {}) returns Application|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Applications/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete the application by the specified application sid
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the Application resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteApplication(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Applications/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Fetch an instance of an authorized-connect-app
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the AuthorizedConnectApp resource to fetch
    # + connectAppSid - The SID of the Connect App to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchAuthorizedConnectApp(string accountSid, string connectAppSid, map<string|string[]> headers = {}) returns AuthorizedConnectApp|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AuthorizedConnectApps/${getEncodedUri(connectAppSid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of authorized-connect-apps belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the AuthorizedConnectApp resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAuthorizedConnectApp(string accountSid, map<string|string[]> headers = {}, *ListAuthorizedConnectAppQueries queries) returns ListAuthorizedConnectAppResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AuthorizedConnectApps.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the available phone number Country resources
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberCountry(string accountSid, map<string|string[]> headers = {}, *ListAvailablePhoneNumberCountryQueries queries) returns ListAvailablePhoneNumberCountryResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the available phone number Country resource
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country to fetch available phone number information about
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchAvailablePhoneNumberCountry(string accountSid, string countryCode, map<string|string[]> headers = {}) returns AvailablePhoneNumberCountry|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of machine to machine available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberLocal(string accountSid, string countryCode, map<string|string[]> headers = {}, *ListAvailablePhoneNumberLocalQueries queries) returns ListAvailablePhoneNumberLocalResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}/Local.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of machine to machine available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberMachineToMachine(string accountSid, string countryCode, map<string|string[]> headers = {}, *ListAvailablePhoneNumberMachineToMachineQueries queries) returns ListAvailablePhoneNumberMachineToMachineResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}/MachineToMachine.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of mobile available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberMobile(string accountSid, string countryCode, map<string|string[]> headers = {}, *ListAvailablePhoneNumberMobileQueries queries) returns ListAvailablePhoneNumberMobileResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}/Mobile.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of national available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberNational(string accountSid, string countryCode, map<string|string[]> headers = {}, *ListAvailablePhoneNumberNationalQueries queries) returns ListAvailablePhoneNumberNationalResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}/National.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of shared cost available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberSharedCost(string accountSid, string countryCode, map<string|string[]> headers = {}, *ListAvailablePhoneNumberSharedCostQueries queries) returns ListAvailablePhoneNumberSharedCostResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}/SharedCost.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of toll free available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberTollFree(string accountSid, string countryCode, map<string|string[]> headers = {}, *ListAvailablePhoneNumberTollFreeQueries queries) returns ListAvailablePhoneNumberTollFreeResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}/TollFree.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of VoIP available phone numbers that match the given filters.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAvailablePhoneNumberVoip(string accountSid, string countryCode, map<string|string[]> headers = {}, *ListAvailablePhoneNumberVoipQueries queries) returns ListAvailablePhoneNumberVoipResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/AvailablePhoneNumbers/${getEncodedUri(countryCode)}/Voip.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch the balance for an Account based on Account Sid. Balance changes may not be reflected immediately. Child accounts do not contain balance information
    #
    # + accountSid - The unique SID identifier of the Account
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchBalance(string accountSid, map<string|string[]> headers = {}) returns Balance|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Balance.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieves a collection of calls made to and from your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listCall(string accountSid, map<string|string[]> headers = {}, *ListCallQueries queries) returns ListCallResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new outgoing call to phones, SIP-enabled endpoints or Twilio Client connections
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateCallRequest` record should be used as a payload to create a call 
    # + return - Created 
    remote isolated function createCall(string accountSid, CreateCallRequest payload, map<string|string[]> headers = {}) returns Call|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch the call specified by the provided Call SID
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to fetch
    # + sid - The SID of the Call resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchCall(string accountSid, string sid, map<string|string[]> headers = {}) returns Call|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Initiates a call redirect or terminates a call
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to update
    # + sid - The Twilio-provided string that uniquely identifies the Call resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateCallRequest` record should be used as a payload to update a call 
    # + return - OK 
    remote isolated function updateCall(string accountSid, string sid, UpdateCallRequest payload, map<string|string[]> headers = {}) returns Call|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a Call record from your account. Once the record is deleted, it will no longer appear in the API and Account Portal logs.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to delete
    # + sid - The Twilio-provided Call SID that uniquely identifies the Call resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteCall(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of all events for a call.
    #
    # + accountSid - The unique SID identifier of the Account
    # + callSid - The unique SID identifier of the Call
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listCallEvent(string accountSid, string callSid, map<string|string[]> headers = {}, *ListCallEventQueries queries) returns ListCallEventResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Events.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch a Feedback resource from a call
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + callSid - The call sid that uniquely identifies the call
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchCallFeedback(string accountSid, string callSid, map<string|string[]> headers = {}) returns CallCallFeedback|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Feedback.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a Feedback resource for a call
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + callSid - The call sid that uniquely identifies the call
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateCallFeedbackRequest` record should be used as a payload to update a call feedback 
    # + return - OK 
    remote isolated function updateCallFeedback(string accountSid, string callSid, UpdateCallFeedbackRequest payload, map<string|string[]> headers = {}) returns CallCallFeedback|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Feedback.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a FeedbackSummary resource for a call
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateCallFeedbackSummaryRequest` record should be used as a payload to create a call feedback summary 
    # + return - Created 
    remote isolated function createCallFeedbackSummary(string accountSid, CreateCallFeedbackSummaryRequest payload, map<string|string[]> headers = {}) returns CallCallFeedbackSummary|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/FeedbackSummary.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a FeedbackSummary resource from a call
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + sid - A 34 character string that uniquely identifies this resource
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchCallFeedbackSummary(string accountSid, string sid, map<string|string[]> headers = {}) returns CallCallFeedbackSummary|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/FeedbackSummary/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a FeedbackSummary resource from a call
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + sid - A 34 character string that uniquely identifies this resource
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteCallFeedbackSummary(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/FeedbackSummary/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Fetch a Notification resource from a call. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resource to fetch
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the Call Notification resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Call Notification resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchCallNotification(string accountSid, string callSid, string sid, map<string|string[]> headers = {}) returns CallCallNotificationInstance|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Notifications/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of all notifications generated for a given call.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resources to read
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the Call Notification resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listCallNotification(string accountSid, string callSid, map<string|string[]> headers = {}, *ListCallNotificationQueries queries) returns ListCallNotificationResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Notifications.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of recordings belonging to the call used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to read
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listCallRecording(string accountSid, string callSid, map<string|string[]> headers = {}, *ListCallRecordingQueries queries) returns ListCallRecordingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Recordings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a recording for the call
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) to associate the resource with
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateCallRecordingRequest` record should be used as a payload to create a call recording 
    # + return - Created 
    remote isolated function createCallRecording(string accountSid, string callSid, CreateCallRecordingRequest payload, map<string|string[]> headers = {}) returns CallCallRecording|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Recordings.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of a recording for a call
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource to fetch
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchCallRecording(string accountSid, string callSid, string sid, map<string|string[]> headers = {}) returns CallCallRecording|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Recordings/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Changes the status of the recording to paused, stopped, or in-progress. Note: Pass `Twilio.CURRENT` instead of recording sid to reference current active recording.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource to update
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource to update
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateCallRecordingRequest` record should be used as a payload to update a call recording 
    # + return - OK 
    remote isolated function updateCallRecording(string accountSid, string callSid, string sid, UpdateCallRecordingRequest payload, map<string|string[]> headers = {}) returns CallCallRecording|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Recordings/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a recording from your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to delete
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteCallRecording(string accountSid, string callSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Recordings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Fetch an instance of a conference
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference resource(s) to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Conference resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchConference(string accountSid, string sid, map<string|string[]> headers = {}) returns Conference|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Changes the status of a conference.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference resource(s) to update
    # + sid - The Twilio-provided string that uniquely identifies the Conference resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateConferenceRequest` record should be used as a payload to update a conference 
    # + return - OK 
    remote isolated function updateConference(string accountSid, string sid, UpdateConferenceRequest payload, map<string|string[]> headers = {}) returns Conference|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Retrieve a list of conferences belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference resource(s) to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listConference(string accountSid, map<string|string[]> headers = {}, *ListConferenceQueries queries) returns ListConferenceResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch an instance of a recording for a call
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resource to fetch
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Conference Recording resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchConferenceRecording(string accountSid, string conferenceSid, string sid, map<string|string[]> headers = {}) returns ConferenceConferenceRecording|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Recordings/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Changes the status of the recording to paused, stopped, or in-progress. Note: To use `Twilio.CURRENT`, pass it as recording sid.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resource to update
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to update
    # + sid - The Twilio-provided string that uniquely identifies the Conference Recording resource to update. Use `Twilio.CURRENT` to reference the current active recording
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateConferenceRecordingRequest` record should be used as a payload to update a conference recording 
    # + return - OK 
    remote isolated function updateConferenceRecording(string accountSid, string conferenceSid, string sid, UpdateConferenceRecordingRequest payload, map<string|string[]> headers = {}) returns ConferenceConferenceRecording|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Recordings/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a recording from your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resources to delete
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to delete
    # + sid - The Twilio-provided string that uniquely identifies the Conference Recording resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteConferenceRecording(string accountSid, string conferenceSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Recordings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of recordings belonging to the call used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resources to read
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listConferenceRecording(string accountSid, string conferenceSid, map<string|string[]> headers = {}, *ListConferenceRecordingQueries queries) returns ListConferenceRecordingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Recordings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch an instance of a connect-app
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the ConnectApp resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchConnectApp(string accountSid, string sid, map<string|string[]> headers = {}) returns ConnectApp|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/ConnectApps/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a connect-app with the specified parameters
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resources to update
    # + sid - The Twilio-provided string that uniquely identifies the ConnectApp resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateConnectAppRequest` record should be used as a payload to update a connect-app 
    # + return - OK 
    remote isolated function updateConnectApp(string accountSid, string sid, UpdateConnectAppRequest payload, map<string|string[]> headers = {}) returns ConnectApp|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/ConnectApps/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an instance of a connect-app
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the ConnectApp resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteConnectApp(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/ConnectApps/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of connect-apps belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listConnectApp(string accountSid, map<string|string[]> headers = {}, *ListConnectAppQueries queries) returns ListConnectAppResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/ConnectApps.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of phone numbers dependent on an Address resource belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the DependentPhoneNumber resources to read
    # + addressSid - The SID of the Address resource associated with the phone number
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listDependentPhoneNumber(string accountSid, string addressSid, map<string|string[]> headers = {}, *ListDependentPhoneNumberQueries queries) returns ListDependentPhoneNumberResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Addresses/${getEncodedUri(addressSid)}/DependentPhoneNumbers.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch an incoming-phone-number belonging to the account used to make the request.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the IncomingPhoneNumber resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchIncomingPhoneNumber(string accountSid, string sid, map<string|string[]> headers = {}) returns IncomingPhoneNumber|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update an incoming-phone-number instance.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resource to update.  For more information, see [Exchanging Numbers Between Subaccounts](https://www.twilio.com/docs/iam/api/subaccounts#exchanging-numbers)
    # + sid - The Twilio-provided string that uniquely identifies the IncomingPhoneNumber resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateIncomingPhoneNumberRequest` record should be used as a payload to update an incoming-phone-number instance 
    # + return - OK 
    remote isolated function updateIncomingPhoneNumber(string accountSid, string sid, UpdateIncomingPhoneNumberRequest payload, map<string|string[]> headers = {}) returns IncomingPhoneNumber|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a phone-numbers belonging to the account used to make the request.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the IncomingPhoneNumber resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteIncomingPhoneNumber(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of incoming-phone-numbers belonging to the account used to make the request.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listIncomingPhoneNumber(string accountSid, map<string|string[]> headers = {}, *ListIncomingPhoneNumberQueries queries) returns ListIncomingPhoneNumberResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Purchase a phone-number for the account.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateIncomingPhoneNumberRequest` record should be used as a payload to purchase a phone-number 
    # + return - Created 
    remote isolated function createIncomingPhoneNumber(string accountSid, CreateIncomingPhoneNumberRequest payload, map<string|string[]> headers = {}) returns IncomingPhoneNumber|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of an Add-on installation currently assigned to this Number.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource to fetch
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned
    # + sid - The Twilio-provided string that uniquely identifies the resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchIncomingPhoneNumberAssignedAddOn(string accountSid, string resourceSid, string sid, map<string|string[]> headers = {}) returns IncomingPhoneNumberIncomingPhoneNumberAssignedAddOn|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(resourceSid)}/AssignedAddOns/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Remove the assignment of an Add-on installation from the Number specified.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to delete
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned
    # + sid - The Twilio-provided string that uniquely identifies the resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteIncomingPhoneNumberAssignedAddOn(string accountSid, string resourceSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(resourceSid)}/AssignedAddOns/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of Add-on installations currently assigned to this Number.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listIncomingPhoneNumberAssignedAddOn(string accountSid, string resourceSid, map<string|string[]> headers = {}, *ListIncomingPhoneNumberAssignedAddOnQueries queries) returns ListIncomingPhoneNumberAssignedAddOnResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(resourceSid)}/AssignedAddOns.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Assign an Add-on installation to the Number specified.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + resourceSid - The SID of the Phone Number to assign the Add-on
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateIncomingPhoneNumberAssignedAddOnRequest` record should be used as a payload to assign an add-on installation to a number 
    # + return - Created 
    remote isolated function createIncomingPhoneNumberAssignedAddOn(string accountSid, string resourceSid, CreateIncomingPhoneNumberAssignedAddOnRequest payload, map<string|string[]> headers = {}) returns IncomingPhoneNumberIncomingPhoneNumberAssignedAddOn|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(resourceSid)}/AssignedAddOns.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of an Extension for the Assigned Add-on.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource to fetch
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned
    # + assignedAddOnSid - The SID that uniquely identifies the assigned Add-on installation
    # + sid - The Twilio-provided string that uniquely identifies the resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchIncomingPhoneNumberAssignedAddOnExtension(string accountSid, string resourceSid, string assignedAddOnSid, string sid, map<string|string[]> headers = {}) returns IncomingPhoneNumberIncomingPhoneNumberAssignedAddOnIncomingPhoneNumberAssignedAddOnExtension|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(resourceSid)}/AssignedAddOns/${getEncodedUri(assignedAddOnSid)}/Extensions/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of Extensions for the Assigned Add-on.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned
    # + assignedAddOnSid - The SID that uniquely identifies the assigned Add-on installation
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listIncomingPhoneNumberAssignedAddOnExtension(string accountSid, string resourceSid, string assignedAddOnSid, map<string|string[]> headers = {}, *ListIncomingPhoneNumberAssignedAddOnExtensionQueries queries) returns ListIncomingPhoneNumberAssignedAddOnExtensionResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/${getEncodedUri(resourceSid)}/AssignedAddOns/${getEncodedUri(assignedAddOnSid)}/Extensions.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of local phone numbers belonging to the account.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listIncomingPhoneNumberLocal(string accountSid, map<string|string[]> headers = {}, *ListIncomingPhoneNumberLocalQueries queries) returns ListIncomingPhoneNumberLocalResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/Local.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new IncomingPhoneNumber resource. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateIncomingPhoneNumberLocalRequest` record should be used as a payload to create an IncomingPhoneNumber resource 
    # + return - Created 
    remote isolated function createIncomingPhoneNumberLocal(string accountSid, CreateIncomingPhoneNumberLocalRequest payload, map<string|string[]> headers = {}) returns IncomingPhoneNumberIncomingPhoneNumberLocal|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/Local.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Retrieve a list of mobile phone numbers belonging to the account.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listIncomingPhoneNumberMobile(string accountSid, map<string|string[]> headers = {}, *ListIncomingPhoneNumberMobileQueries queries) returns ListIncomingPhoneNumberMobileResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/Mobile.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new IncomingPhoneNumber resource. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateIncomingPhoneNumberMobileRequest` record should be used as a payload to create an IncomingPhoneNumber resource 
    # + return - Created 
    remote isolated function createIncomingPhoneNumberMobile(string accountSid, CreateIncomingPhoneNumberMobileRequest payload, map<string|string[]> headers = {}) returns IncomingPhoneNumberIncomingPhoneNumberMobile|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/Mobile.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Retrieve a list of toll free phone numbers belonging to the account.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listIncomingPhoneNumberTollFree(string accountSid, map<string|string[]> headers = {}, *ListIncomingPhoneNumberTollFreeQueries queries) returns ListIncomingPhoneNumberTollFreeResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/TollFree.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new Toll Free IncomingPhoneNumber resource. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateIncomingPhoneNumberTollFreeRequest` record should be used as a payload to create an IncomingPhoneNumber resource 
    # + return - Created 
    remote isolated function createIncomingPhoneNumberTollFree(string accountSid, CreateIncomingPhoneNumberTollFreeRequest payload, map<string|string[]> headers = {}) returns IncomingPhoneNumberIncomingPhoneNumberTollFree|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/IncomingPhoneNumbers/TollFree.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a Key.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Key resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchKey(string accountSid, string sid, map<string|string[]> headers = {}) returns Key|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Keys/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a Key.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resources to update
    # + sid - The Twilio-provided string that uniquely identifies the Key resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateKeyRequest` record should be used as a payload to update a Key resource 
    # + return - OK 
    remote isolated function updateKey(string accountSid, string sid, UpdateKeyRequest payload, map<string|string[]> headers = {}) returns Key|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Keys/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a Key.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the Key resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteKey(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Keys/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Returns a list of Key resources.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listKey(string accountSid, map<string|string[]> headers = {}, *ListKeyQueries queries) returns ListKeyResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Keys.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new Key request. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will be responsible for the new Key resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateNewKeyRequest` record should be used as a payload to create a Key resource 
    # + return - Created 
    remote isolated function createNewKey(string accountSid, CreateNewKeyRequest payload, map<string|string[]> headers = {}) returns NewKey|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Keys.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a single Media resource associated with a specific Message resource
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Media resource
    # + messageSid - The SID of the Message resource that is associated with the Media resource
    # + sid - The Twilio-provided string that uniquely identifies the Media resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchMedia(string accountSid, string messageSid, string sid, map<string|string[]> headers = {}) returns MessageMedia|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages/${getEncodedUri(messageSid)}/Media/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete the Media resource.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is associated with the Media resource
    # + messageSid - The SID of the Message resource that is associated with the Media resource
    # + sid - The unique identifier of the to-be-deleted Media resource
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteMedia(string accountSid, string messageSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages/${getEncodedUri(messageSid)}/Media/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Read a list of Media resources associated with a specific Message resource
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is associated with the Media resources
    # + messageSid - The SID of the Message resource that is associated with the Media resources
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listMedia(string accountSid, string messageSid, map<string|string[]> headers = {}, *ListMediaQueries queries) returns ListMediaResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages/${getEncodedUri(messageSid)}/Media.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch a specific member from the queue
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Member resource(s) to fetch
    # + queueSid - The SID of the Queue in which to find the members to fetch
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource(s) to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchMember(string accountSid, string queueSid, string callSid, map<string|string[]> headers = {}) returns QueueMember|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues/${getEncodedUri(queueSid)}/Members/${getEncodedUri(callSid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Dequeue a member from a queue and have the member's call begin executing the TwiML document at that URL
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Member resource(s) to update
    # + queueSid - The SID of the Queue in which to find the members to update
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource(s) to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateMemberRequest` record should be used as a payload to update a Member resource 
    # + return - OK 
    remote isolated function updateMember(string accountSid, string queueSid, string callSid, UpdateMemberRequest payload, map<string|string[]> headers = {}) returns QueueMember|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues/${getEncodedUri(queueSid)}/Members/${getEncodedUri(callSid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Retrieve the members of the queue
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Member resource(s) to read
    # + queueSid - The SID of the Queue in which to find the members
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listMember(string accountSid, string queueSid, map<string|string[]> headers = {}, *ListMemberQueries queries) returns ListMemberResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues/${getEncodedUri(queueSid)}/Members.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of Message resources associated with a Twilio Account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resources
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listMessage(string accountSid, map<string|string[]> headers = {}, *ListMessageQueries queries) returns ListMessageResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Send a message
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) creating the Message resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateMessageRequest` record should be used as a payload to create a message 
    # + return - Created 
    remote isolated function createMessage(string accountSid, CreateMessageRequest payload, map<string|string[]> headers = {}) returns Message|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a specific Message
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource
    # + sid - The SID of the Message resource to be fetched
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchMessage(string accountSid, string sid, map<string|string[]> headers = {}) returns Message|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a Message resource (used to redact Message `body` text and to cancel not-yet-sent messages)
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Message resources to update
    # + sid - The SID of the Message resource to be updated
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateMessageRequest` record should be used as a payload to update a Message resource 
    # + return - OK 
    remote isolated function updateMessage(string accountSid, string sid, UpdateMessageRequest payload, map<string|string[]> headers = {}) returns Message|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Deletes a Message resource from your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource
    # + sid - The SID of the Message resource you wish to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteMessage(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Create Message Feedback to confirm a tracked user action was performed by the recipient of the associated Message
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource for which to create MessageFeedback
    # + messageSid - The SID of the Message resource for which to create MessageFeedback
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateMessageFeedbackRequest` record should be used as a payload to create a MessageFeedback resource 
    # + return - Created 
    remote isolated function createMessageFeedback(string accountSid, string messageSid, CreateMessageFeedbackRequest payload, map<string|string[]> headers = {}) returns MessageMessageFeedback|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Messages/${getEncodedUri(messageSid)}/Feedback.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns a list of [Signing Key](https://www.twilio.com/docs/iam/api/signingkey-resource) resources
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSigningKey(string accountSid, map<string|string[]> headers = {}, *ListSigningKeyQueries queries) returns ListSigningKeyResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SigningKeys.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new Signing Key for the account making the request.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will be responsible for the new Key resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateNewSigningKeyRequest` record should be used as a payload to create a Signing Key resource 
    # + return - Created 
    remote isolated function createNewSigningKey(string accountSid, CreateNewSigningKeyRequest payload, map<string|string[]> headers = {}) returns NewSigningKey|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SigningKeys.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a notification belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Notification resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Notification resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchNotification(string accountSid, string sid, map<string|string[]> headers = {}) returns NotificationInstance|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Notifications/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of notifications belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Notification resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listNotification(string accountSid, map<string|string[]> headers = {}, *ListNotificationQueries queries) returns ListNotificationResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Notifications.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch an outgoing-caller-id belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the OutgoingCallerId resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchOutgoingCallerId(string accountSid, string sid, map<string|string[]> headers = {}) returns OutgoingCallerId|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/OutgoingCallerIds/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Updates the caller-id
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resources to update
    # + sid - The Twilio-provided string that uniquely identifies the OutgoingCallerId resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateOutgoingCallerIdRequest` record should be used as a payload to update a OutgoingCallerId resource 
    # + return - OK 
    remote isolated function updateOutgoingCallerId(string accountSid, string sid, UpdateOutgoingCallerIdRequest payload, map<string|string[]> headers = {}) returns OutgoingCallerId|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/OutgoingCallerIds/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete the caller-id specified from the account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the OutgoingCallerId resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteOutgoingCallerId(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/OutgoingCallerIds/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of outgoing-caller-ids belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listOutgoingCallerId(string accountSid, map<string|string[]> headers = {}, *ListOutgoingCallerIdQueries queries) returns ListOutgoingCallerIdResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/OutgoingCallerIds.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a Validation Request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for the new caller ID resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateValidationRequest` record should be used as a payload to create a Validation request resource 
    # + return - Created 
    remote isolated function createValidationRequest(string accountSid, CreateValidationRequest payload, map<string|string[]> headers = {}) returns ValidationRequest|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/OutgoingCallerIds.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of a participant
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resource to fetch
    # + conferenceSid - The SID of the conference with the participant to fetch
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID or label of the participant to fetch. Non URL safe characters in a label must be percent encoded, for example, a space character is represented as %20
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchParticipant(string accountSid, string conferenceSid, string callSid, map<string|string[]> headers = {}) returns ConferenceParticipant|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Participants/${getEncodedUri(callSid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update the properties of the participant
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resources to update
    # + conferenceSid - The SID of the conference with the participant to update
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID or label of the participant to update. Non URL safe characters in a label must be percent encoded, for example, a space character is represented as %20
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateParticipantRequest` record should be used as a payload to update a Participant resource 
    # + return - OK 
    remote isolated function updateParticipant(string accountSid, string conferenceSid, string callSid, UpdateParticipantRequest payload, map<string|string[]> headers = {}) returns ConferenceParticipant|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Participants/${getEncodedUri(callSid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Kick a participant from a given conference
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resources to delete
    # + conferenceSid - The SID of the conference with the participants to delete
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID or label of the participant to delete. Non URL safe characters in a label must be percent encoded, for example, a space character is represented as %20
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteParticipant(string accountSid, string conferenceSid, string callSid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Participants/${getEncodedUri(callSid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of participants belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resources to read
    # + conferenceSid - The SID of the conference with the participants to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listParticipant(string accountSid, string conferenceSid, map<string|string[]> headers = {}, *ListParticipantQueries queries) returns ListParticipantResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Participants.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a Participant.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + conferenceSid - The SID of the participant's conference
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateParticipantRequest` record should be used as a payload to create a Participant resource 
    # + return - Created 
    remote isolated function createParticipant(string accountSid, string conferenceSid, CreateParticipantRequest payload, map<string|string[]> headers = {}) returns ConferenceParticipant|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Conferences/${getEncodedUri(conferenceSid)}/Participants.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # create an instance of payments. This will start a new payments session
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + callSid - The SID of the call that will create the resource. Call leg associated with this sid is expected to provide payment information thru DTMF
    # + headers - Headers to be sent with the request 
    # + payload - The `CreatePaymentsRequest` record should be used as a payload to create a Payments resource 
    # + return - Created 
    remote isolated function createPayments(string accountSid, string callSid, CreatePaymentsRequest payload, map<string|string[]> headers = {}) returns CallPayments|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Payments.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # update an instance of payments with different phases of payment flows.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will update the resource
    # + callSid - The SID of the call that will update the resource. This should be the same call sid that was used to create payments resource
    # + sid - The SID of Payments session that needs to be updated
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdatePaymentsRequest` record should be used as a payload to update a Payments resource 
    # + return - Accepted 
    remote isolated function updatePayments(string accountSid, string callSid, string sid, UpdatePaymentsRequest payload, map<string|string[]> headers = {}) returns CallPayments|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Payments/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of a queue identified by the QueueSid
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Queue resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchQueue(string accountSid, string sid, map<string|string[]> headers = {}) returns Queue|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update the queue with the new parameters
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to update
    # + sid - The Twilio-provided string that uniquely identifies the Queue resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateQueueRequest` record should be used as a payload to update a Queue resource 
    # + return - OK 
    remote isolated function updateQueue(string accountSid, string sid, UpdateQueueRequest payload, map<string|string[]> headers = {}) returns Queue|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Remove an empty queue
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to delete
    # + sid - The Twilio-provided string that uniquely identifies the Queue resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteQueue(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of queues belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listQueue(string accountSid, map<string|string[]> headers = {}, *ListQueueQueries queries) returns ListQueueResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a queue
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateQueueRequest` record should be used as a payload to create a Queue resource 
    # + return - Created 
    remote isolated function createQueue(string accountSid, CreateQueueRequest payload, map<string|string[]> headers = {}) returns Queue|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Queues.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of a recording
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to fetch
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function fetchRecording(string accountSid, string sid, map<string|string[]> headers = {}, *FetchRecordingQueries queries) returns Recording|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(sid)}.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a recording from your account
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteRecording(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of recordings belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listRecording(string accountSid, map<string|string[]> headers = {}, *ListRecordingQueries queries) returns ListRecordingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch an instance of an AddOnResult
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult resource to fetch
    # + referenceSid - The SID of the recording to which the result to fetch belongs
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchRecordingAddOnResult(string accountSid, string referenceSid, string sid, map<string|string[]> headers = {}) returns RecordingRecordingAddOnResult|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(referenceSid)}/AddOnResults/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a result and purge all associated Payloads
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult resources to delete
    # + referenceSid - The SID of the recording to which the result to delete belongs
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteRecordingAddOnResult(string accountSid, string referenceSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(referenceSid)}/AddOnResults/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of results belonging to the recording
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult resources to read
    # + referenceSid - The SID of the recording to which the result to read belongs
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listRecordingAddOnResult(string accountSid, string referenceSid, map<string|string[]> headers = {}, *ListRecordingAddOnResultQueries queries) returns ListRecordingAddOnResultResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(referenceSid)}/AddOnResults.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch an instance of a result payload
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resource to fetch
    # + referenceSid - The SID of the recording to which the AddOnResult resource that contains the payload to fetch belongs
    # + addOnResultSid - The SID of the AddOnResult to which the payload to fetch belongs
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult Payload resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchRecordingAddOnResultPayload(string accountSid, string referenceSid, string addOnResultSid, string sid, map<string|string[]> headers = {}) returns RecordingRecordingAddOnResultRecordingAddOnResultPayload|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(referenceSid)}/AddOnResults/${getEncodedUri(addOnResultSid)}/Payloads/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a payload from the result along with all associated Data
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resources to delete
    # + referenceSid - The SID of the recording to which the AddOnResult resource that contains the payloads to delete belongs
    # + addOnResultSid - The SID of the AddOnResult to which the payloads to delete belongs
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult Payload resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteRecordingAddOnResultPayload(string accountSid, string referenceSid, string addOnResultSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(referenceSid)}/AddOnResults/${getEncodedUri(addOnResultSid)}/Payloads/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of payloads belonging to the AddOnResult
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resources to read
    # + referenceSid - The SID of the recording to which the AddOnResult resource that contains the payloads to read belongs
    # + addOnResultSid - The SID of the AddOnResult to which the payloads to read belongs
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listRecordingAddOnResultPayload(string accountSid, string referenceSid, string addOnResultSid, map<string|string[]> headers = {}, *ListRecordingAddOnResultPayloadQueries queries) returns ListRecordingAddOnResultPayloadResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(referenceSid)}/AddOnResults/${getEncodedUri(addOnResultSid)}/Payloads.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch a recording transcription. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resource to fetch
    # + recordingSid - The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcription to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchRecordingTranscription(string accountSid, string recordingSid, string sid, map<string|string[]> headers = {}) returns RecordingRecordingTranscription|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(recordingSid)}/Transcriptions/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a transcription from your account. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to delete
    # + recordingSid - The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcription to delete
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteRecordingTranscription(string accountSid, string recordingSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(recordingSid)}/Transcriptions/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of transcriptions belonging to the recording. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to read
    # + recordingSid - The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcriptions to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listRecordingTranscription(string accountSid, string recordingSid, map<string|string[]> headers = {}, *ListRecordingTranscriptionQueries queries) returns ListRecordingTranscriptionResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Recordings/${getEncodedUri(recordingSid)}/Transcriptions.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch an instance of a short code
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to fetch
    # + sid - The Twilio-provided string that uniquely identifies the ShortCode resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchShortCode(string accountSid, string sid, map<string|string[]> headers = {}) returns ShortCode|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SMS/ShortCodes/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a short code with the following parameters
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to update
    # + sid - The Twilio-provided string that uniquely identifies the ShortCode resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateShortCodeRequest` record should be used as a payload to update a ShortCode resource 
    # + return - OK 
    remote isolated function updateShortCode(string accountSid, string sid, UpdateShortCodeRequest payload, map<string|string[]> headers = {}) returns ShortCode|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SMS/ShortCodes/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Retrieve a list of short-codes belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listShortCode(string accountSid, map<string|string[]> headers = {}, *ListShortCodeQueries queries) returns ListShortCodeResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SMS/ShortCodes.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch a SigningKey. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SigningKey resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the SigningKey resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSigningKey(string accountSid, string sid, map<string|string[]> headers = {}) returns SigningKey|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SigningKeys/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a SigningKey. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SigningKey resource to update
    # + sid - The Twilio-provided string that uniquely identifies the SigningKey resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateSigningKeyRequest` record should be used as a payload to update a SigningKey resource 
    # + return - OK 
    remote isolated function updateSigningKey(string accountSid, string sid, UpdateSigningKeyRequest payload, map<string|string[]> headers = {}) returns SigningKey|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SigningKeys/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a SigningKey. 
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SigningKey resource to delete
    # + sid - The Twilio-provided string that uniquely identifies the SigningKey resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSigningKey(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SigningKeys/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of credential list mappings belonging to the domain used in the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to read
    # + domainSid - The SID of the SIP domain that contains the resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipAuthCallsCredentialListMapping(string accountSid, string domainSid, map<string|string[]> headers = {}, *ListSipAuthCallsCredentialListMappingQueries queries) returns ListSipAuthCallsCredentialListMappingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/CredentialListMappings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new credential list mapping resource
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + domainSid - The SID of the SIP domain that will contain the new resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipAuthCallsCredentialListMappingRequest` record should be used as a payload to create a `SipAuthCallsCredentialListMapping` resource 
    # + return - Created 
    remote isolated function createSipAuthCallsCredentialListMapping(string accountSid, string domainSid, CreateSipAuthCallsCredentialListMappingRequest payload, map<string|string[]> headers = {}) returns SipSipDomainSipAuthSipAuthCallsSipAuthCallsCredentialListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/CredentialListMappings.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a specific instance of a credential list mapping
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resource to fetch
    # + domainSid - The SID of the SIP domain that contains the resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipAuthCallsCredentialListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns SipSipDomainSipAuthSipAuthCallsSipAuthCallsCredentialListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/CredentialListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a credential list mapping from the requested domain
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to delete
    # + domainSid - The SID of the SIP domain that contains the resource to delete
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipAuthCallsCredentialListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/CredentialListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of IP Access Control List mappings belonging to the domain used in the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IpAccessControlListMapping resources to read
    # + domainSid - The SID of the SIP domain that contains the resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipAuthCallsIpAccessControlListMapping(string accountSid, string domainSid, map<string|string[]> headers = {}, *ListSipAuthCallsIpAccessControlListMappingQueries queries) returns ListSipAuthCallsIpAccessControlListMappingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/IpAccessControlListMappings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new IP Access Control List mapping
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + domainSid - The SID of the SIP domain that will contain the new resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipAuthCallsIpAccessControlListMappingRequest` record should be used as a payload to create a SipAuthCallsIpAccessControlListMapping resource 
    # + return - Created 
    remote isolated function createSipAuthCallsIpAccessControlListMapping(string accountSid, string domainSid, CreateSipAuthCallsIpAccessControlListMappingRequest payload, map<string|string[]> headers = {}) returns SipSipDomainSipAuthSipAuthCallsSipAuthCallsIpAccessControlListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/IpAccessControlListMappings.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a specific instance of an IP Access Control List mapping
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IpAccessControlListMapping resource to fetch
    # + domainSid - The SID of the SIP domain that contains the resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the IpAccessControlListMapping resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipAuthCallsIpAccessControlListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns SipSipDomainSipAuthSipAuthCallsSipAuthCallsIpAccessControlListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/IpAccessControlListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an IP Access Control List mapping from the requested domain
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IpAccessControlListMapping resources to delete
    # + domainSid - The SID of the SIP domain that contains the resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the IpAccessControlListMapping resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipAuthCallsIpAccessControlListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Calls/IpAccessControlListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of credential list mappings belonging to the domain used in the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to read
    # + domainSid - The SID of the SIP domain that contains the resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipAuthRegistrationsCredentialListMapping(string accountSid, string domainSid, map<string|string[]> headers = {}, *ListSipAuthRegistrationsCredentialListMappingQueries queries) returns ListSipAuthRegistrationsCredentialListMappingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Registrations/CredentialListMappings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new credential list mapping resource
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + domainSid - The SID of the SIP domain that will contain the new resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipAuthRegistrationsCredentialListMappingRequest` record should be used as a payload to create a CredentialListMapping resource 
    # + return - Created 
    remote isolated function createSipAuthRegistrationsCredentialListMapping(string accountSid, string domainSid, CreateSipAuthRegistrationsCredentialListMappingRequest payload, map<string|string[]> headers = {}) returns SipSipDomainSipAuthSipAuthRegistrationsSipAuthRegistrationsCredentialListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Registrations/CredentialListMappings.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a specific instance of a credential list mapping
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resource to fetch
    # + domainSid - The SID of the SIP domain that contains the resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipAuthRegistrationsCredentialListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns SipSipDomainSipAuthSipAuthRegistrationsSipAuthRegistrationsCredentialListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Registrations/CredentialListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a credential list mapping from the requested domain
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to delete
    # + domainSid - The SID of the SIP domain that contains the resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipAuthRegistrationsCredentialListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/Auth/Registrations/CredentialListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of credentials.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + credentialListSid - The unique id that identifies the credential list that contains the desired credentials
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipCredential(string accountSid, string credentialListSid, map<string|string[]> headers = {}, *ListSipCredentialQueries queries) returns ListSipCredentialResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(credentialListSid)}/Credentials.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new credential resource.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + credentialListSid - The unique id that identifies the credential list to include the created credential
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipCredentialRequest` record should be used as a payload to create a Credential resource 
    # + return - Created 
    remote isolated function createSipCredential(string accountSid, string credentialListSid, CreateSipCredentialRequest payload, map<string|string[]> headers = {}) returns SipSipCredentialListSipCredential|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(credentialListSid)}/Credentials.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a single credential.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + credentialListSid - The unique id that identifies the credential list that contains the desired credential
    # + sid - The unique id that identifies the resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipCredential(string accountSid, string credentialListSid, string sid, map<string|string[]> headers = {}) returns SipSipCredentialListSipCredential|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(credentialListSid)}/Credentials/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a credential resource.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + credentialListSid - The unique id that identifies the credential list that includes this credential
    # + sid - The unique id that identifies the resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateSipCredentialRequest` record should be used as a payload to update a Credential resource 
    # + return - OK 
    remote isolated function updateSipCredential(string accountSid, string credentialListSid, string sid, UpdateSipCredentialRequest payload, map<string|string[]> headers = {}) returns SipSipCredentialListSipCredential|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(credentialListSid)}/Credentials/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a credential resource.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + credentialListSid - The unique id that identifies the credential list that contains the desired credentials
    # + sid - The unique id that identifies the resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipCredential(string accountSid, string credentialListSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(credentialListSid)}/Credentials/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get All Credential Lists
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipCredentialList(string accountSid, map<string|string[]> headers = {}, *ListSipCredentialListQueries queries) returns ListSipCredentialListResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a Credential List
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipCredentialListRequest` record should be used as a payload to create a CredentialList resource 
    # + return - Created 
    remote isolated function createSipCredentialList(string accountSid, CreateSipCredentialListRequest payload, map<string|string[]> headers = {}) returns SipSipCredentialList|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get a Credential List
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + sid - The credential list Sid that uniquely identifies this resource
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipCredentialList(string accountSid, string sid, map<string|string[]> headers = {}) returns SipSipCredentialList|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update a Credential List
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + sid - The credential list Sid that uniquely identifies this resource
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateSipCredentialListRequest` record should be used as a payload to update a CredentialList resource 
    # + return - OK 
    remote isolated function updateSipCredentialList(string accountSid, string sid, UpdateSipCredentialListRequest payload, map<string|string[]> headers = {}) returns SipSipCredentialList|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a Credential List
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + sid - The credential list Sid that uniquely identifies this resource
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipCredentialList(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/CredentialLists/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Read multiple CredentialListMapping resources from an account.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain that includes the resource to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipCredentialListMapping(string accountSid, string domainSid, map<string|string[]> headers = {}, *ListSipCredentialListMappingQueries queries) returns ListSipCredentialListMappingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/CredentialListMappings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a CredentialListMapping resource for an account.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain for which the CredentialList resource will be mapped
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipCredentialListMappingRequest` record should be used as a payload to create a CredentialListMapping resource 
    # + return - Created 
    remote isolated function createSipCredentialListMapping(string accountSid, string domainSid, CreateSipCredentialListMappingRequest payload, map<string|string[]> headers = {}) returns SipSipDomainSipCredentialListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/CredentialListMappings.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a single CredentialListMapping resource from an account.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain that includes the resource to fetch
    # + sid - A 34 character string that uniquely identifies the resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipCredentialListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns SipSipDomainSipCredentialListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/CredentialListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a CredentialListMapping resource from an account.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain that includes the resource to delete
    # + sid - A 34 character string that uniquely identifies the resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipCredentialListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/CredentialListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of domains belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipDomain(string accountSid, map<string|string[]> headers = {}, *ListSipDomainQueries queries) returns ListSipDomainResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new Domain
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipDomainRequest` record should be used as a payload to create a Domain resource 
    # + return - Created 
    remote isolated function createSipDomain(string accountSid, CreateSipDomainRequest payload, map<string|string[]> headers = {}) returns SipSipDomain|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of a Domain
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the SipDomain resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipDomain(string accountSid, string sid, map<string|string[]> headers = {}) returns SipSipDomain|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update the attributes of a domain
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resource to update
    # + sid - The Twilio-provided string that uniquely identifies the SipDomain resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateSipDomainRequest` record should be used as a payload to update a Domain resource 
    # + return - OK 
    remote isolated function updateSipDomain(string accountSid, string sid, UpdateSipDomainRequest payload, map<string|string[]> headers = {}) returns SipSipDomain|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an instance of a Domain
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the SipDomain resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipDomain(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of IpAccessControlLists that belong to the account used to make the request
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipIpAccessControlList(string accountSid, map<string|string[]> headers = {}, *ListSipIpAccessControlListQueries queries) returns ListSipIpAccessControlListResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new IpAccessControlList resource
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipIpAccessControlListRequest` record should be used as a payload to create a IpAccessControlList resource 
    # + return - Created 
    remote isolated function createSipIpAccessControlList(string accountSid, CreateSipIpAccessControlListRequest payload, map<string|string[]> headers = {}) returns SipSipIpAccessControlList|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch a specific instance of an IpAccessControlList
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + sid - A 34 character string that uniquely identifies the resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipIpAccessControlList(string accountSid, string sid, map<string|string[]> headers = {}) returns SipSipIpAccessControlList|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Rename an IpAccessControlList
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + sid - A 34 character string that uniquely identifies the resource to udpate
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateSipIpAccessControlListRequest` record should be used as a payload to update a IpAccessControlList resource 
    # + return - OK 
    remote isolated function updateSipIpAccessControlList(string accountSid, string sid, UpdateSipIpAccessControlListRequest payload, map<string|string[]> headers = {}) returns SipSipIpAccessControlList|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an IpAccessControlList from the requested account
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + sid - A 34 character string that uniquely identifies the resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipIpAccessControlList(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Fetch an IpAccessControlListMapping resource.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP domain
    # + sid - A 34 character string that uniquely identifies the resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipIpAccessControlListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns SipSipDomainSipIpAccessControlListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/IpAccessControlListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete an IpAccessControlListMapping resource.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP domain
    # + sid - A 34 character string that uniquely identifies the resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipIpAccessControlListMapping(string accountSid, string domainSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/IpAccessControlListMappings/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of IpAccessControlListMapping resources.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP domain
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipIpAccessControlListMapping(string accountSid, string domainSid, map<string|string[]> headers = {}, *ListSipIpAccessControlListMappingQueries queries) returns ListSipIpAccessControlListMappingResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/IpAccessControlListMappings.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new IpAccessControlListMapping resource.
    #
    # + accountSid - The unique id of the Account that is responsible for this resource
    # + domainSid - A 34 character string that uniquely identifies the SIP domain
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipIpAccessControlListMappingRequest` record should be used as a payload to create a IpAccessControlListMapping resource 
    # + return - Created 
    remote isolated function createSipIpAccessControlListMapping(string accountSid, string domainSid, CreateSipIpAccessControlListMappingRequest payload, map<string|string[]> headers = {}) returns SipSipDomainSipIpAccessControlListMapping|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/Domains/${getEncodedUri(domainSid)}/IpAccessControlListMappings.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Read multiple IpAddress resources.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listSipIpAddress(string accountSid, string ipAccessControlListSid, map<string|string[]> headers = {}, *ListSipIpAddressQueries queries) returns ListSipIpAddressResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(ipAccessControlListSid)}/IpAddresses.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new IpAddress resource.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + ipAccessControlListSid - The IpAccessControlList Sid with which to associate the created IpAddress resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSipIpAddressRequest` record should be used as a payload to create a IpAddress resource 
    # + return - Created 
    remote isolated function createSipIpAddress(string accountSid, string ipAccessControlListSid, CreateSipIpAddressRequest payload, map<string|string[]> headers = {}) returns SipSipIpAccessControlListSipIpAddress|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(ipAccessControlListSid)}/IpAddresses.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Read one IpAddress resource.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to fetch
    # + sid - A 34 character string that uniquely identifies the IpAddress resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchSipIpAddress(string accountSid, string ipAccessControlListSid, string sid, map<string|string[]> headers = {}) returns SipSipIpAccessControlListSipIpAddress|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(ipAccessControlListSid)}/IpAddresses/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update an IpAddress resource.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to update
    # + sid - A 34 character string that identifies the IpAddress resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateSipIpAddressRequest` record should be used as a payload to update a IpAddress resource 
    # + return - OK 
    remote isolated function updateSipIpAddress(string accountSid, string ipAccessControlListSid, string sid, UpdateSipIpAddressRequest payload, map<string|string[]> headers = {}) returns SipSipIpAccessControlListSipIpAddress|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(ipAccessControlListSid)}/IpAddresses/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an IpAddress resource.
    #
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to delete
    # + sid - A 34 character string that uniquely identifies the resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteSipIpAddress(string accountSid, string ipAccessControlListSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/SIP/IpAccessControlLists/${getEncodedUri(ipAccessControlListSid)}/IpAddresses/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Create a Siprec
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Siprec resource
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Siprec resource is associated with
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateSiprecRequest` record should be used as a payload to create a Siprec resource 
    # + return - Created 
    remote isolated function createSiprec(string accountSid, string callSid, CreateSiprecRequest payload, map<string|string[]> headers = {}) returns CallSiprec|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Siprec.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Stop a Siprec using either the SID of the Siprec resource or the `name` used when creating the resource
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Siprec resource
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Siprec resource is associated with
    # + sid - The SID of the Siprec resource, or the `name` used when creating the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateSiprecRequest` record should be used as a payload to update a Siprec resource 
    # + return - OK 
    remote isolated function updateSiprec(string accountSid, string callSid, string sid, UpdateSiprecRequest payload, map<string|string[]> headers = {}) returns CallSiprec|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Siprec/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a Stream
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Stream resource
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Stream resource is associated with
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateStreamRequest` record should be used as a payload to create a Stream resource 
    # + return - Created 
    remote isolated function createStream(string accountSid, string callSid, CreateStreamRequest payload, map<string|string[]> headers = {}) returns CallStream|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Streams.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Stop a Stream using either the SID of the Stream resource or the `name` used when creating the resource
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Stream resource
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Stream resource is associated with
    # + sid - The SID of the Stream resource, or the `name` used when creating the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateStreamRequest` record should be used as a payload to update a Stream resource 
    # + return - OK 
    remote isolated function updateStream(string accountSid, string callSid, string sid, UpdateStreamRequest payload, map<string|string[]> headers = {}) returns CallStream|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/Streams/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a new token for ICE servers
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateTokenRequest` record should be used as a payload to create a Token resource 
    # + return - Created 
    remote isolated function createToken(string accountSid, CreateTokenRequest payload, map<string|string[]> headers = {}) returns Token|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Tokens.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Fetch an instance of a Transcription
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchTranscription(string accountSid, string sid, map<string|string[]> headers = {}) returns Transcription|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Transcriptions/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Delete a transcription from the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteTranscription(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Transcriptions/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of transcriptions belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listTranscription(string accountSid, map<string|string[]> headers = {}, *ListTranscriptionQueries queries) returns ListTranscriptionResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Transcriptions.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of usage-records belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecord(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordQueries queries) returns ListUsageRecordResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve a list of usage-records belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordAllTime(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordAllTimeQueries queries) returns ListUsageRecordAllTimeResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/AllTime.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List daily usage records.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordDaily(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordDailyQueries queries) returns ListUsageRecordDailyResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/Daily.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List usage records for last month.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordLastMonth(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordLastMonthQueries queries) returns ListUsageRecordLastMonthResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/LastMonth.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List monthly usage records.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordMonthly(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordMonthlyQueries queries) returns ListUsageRecordMonthlyResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/Monthly.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List usage records for this month.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordThisMonth(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordThisMonthQueries queries) returns ListUsageRecordThisMonthResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/ThisMonth.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List usage records for today.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordToday(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordTodayQueries queries) returns ListUsageRecordTodayResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/Today.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List yearly usage records.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordYearly(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordYearlyQueries queries) returns ListUsageRecordYearlyResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/Yearly.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # List usage records for yesterday.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageRecordYesterday(string accountSid, map<string|string[]> headers = {}, *ListUsageRecordYesterdayQueries queries) returns ListUsageRecordYesterdayResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Records/Yesterday.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Fetch and instance of a usage-trigger
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resource to fetch
    # + sid - The Twilio-provided string that uniquely identifies the UsageTrigger resource to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchUsageTrigger(string accountSid, string sid, map<string|string[]> headers = {}) returns UsageUsageTrigger|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Triggers/${getEncodedUri(sid)}.json`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Update an instance of a usage trigger
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resources to update
    # + sid - The Twilio-provided string that uniquely identifies the UsageTrigger resource to update
    # + headers - Headers to be sent with the request 
    # + payload - The `UpdateUsageTriggerRequest` record should be used as a payload to update a UsageTrigger 
    # + return - OK 
    remote isolated function updateUsageTrigger(string accountSid, string sid, UpdateUsageTriggerRequest payload, map<string|string[]> headers = {}) returns UsageUsageTrigger|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Triggers/${getEncodedUri(sid)}.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete an instance of a usage trigger
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resources to delete
    # + sid - The Twilio-provided string that uniquely identifies the UsageTrigger resource to delete
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteUsageTrigger(string accountSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Triggers/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of usage-triggers belonging to the account used to make the request
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resources to read
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listUsageTrigger(string accountSid, map<string|string[]> headers = {}, *ListUsageTriggerQueries queries) returns ListUsageTriggerResponse|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Triggers.json`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new UsageTrigger
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateUsageTriggerRequest` record should be used as a payload to create a UsageTrigger 
    # + return - Created 
    remote isolated function createUsageTrigger(string accountSid, CreateUsageTriggerRequest payload, map<string|string[]> headers = {}) returns UsageUsageTrigger|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Usage/Triggers.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a new User Defined Message for the given Call SID.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created User Defined Message
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Message is associated with
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateUserDefinedMessageRequest` record should be used as a payload to create a User Defined Message 
    # + return - Created 
    remote isolated function createUserDefinedMessage(string accountSid, string callSid, CreateUserDefinedMessageRequest payload, map<string|string[]> headers = {}) returns CallUserDefinedMessage|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/UserDefinedMessages.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Subscribe to User Defined Messages for a given Call SID.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that subscribed to the User Defined Messages
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Messages subscription is associated with. This refers to the Call SID that is producing the user defined messages
    # + headers - Headers to be sent with the request 
    # + payload - The `CreateUserDefinedMessageSubscriptionRequest` record should be used as a payload to create a UserDefinedMessageSubscription 
    # + return - Created 
    remote isolated function createUserDefinedMessageSubscription(string accountSid, string callSid, CreateUserDefinedMessageSubscriptionRequest payload, map<string|string[]> headers = {}) returns CallUserDefinedMessageSubscription|error {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/UserDefinedMessageSubscriptions.json`;
        http:Request request = new;
        string encodedRequestBody = createFormURLEncodedRequestBody(check jsondata:toJson(payload).ensureType());
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete a specific User Defined Message Subscription.
    #
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that subscribed to the User Defined Messages
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Message Subscription is associated with. This refers to the Call SID that is producing the User Defined Messages
    # + sid - The SID that uniquely identifies this User Defined Message Subscription
    # + headers - Headers to be sent with the request 
    # + return - The resource was deleted successfully 
    remote isolated function deleteUserDefinedMessageSubscription(string accountSid, string callSid, string sid, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/Accounts/${getEncodedUri(accountSid)}/Calls/${getEncodedUri(callSid)}/UserDefinedMessageSubscriptions/${getEncodedUri(sid)}.json`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }
}
