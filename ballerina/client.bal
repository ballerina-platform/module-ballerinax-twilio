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
import twilio.oas;

# This is the public Twilio REST API.
public isolated client class Client {
    final oas:Client generatedClient;
    final string accountSid;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.twilio.com") returns error? {
        self.accountSid = config.auth.username;
        self.generatedClient = check new (config, serviceUrl);
    }
    # Retrieves a collection of Accounts belonging to the account used to make the request
    #
    # + friendlyName - Only return the Account resources with friendly names that exactly match this name.
    # + status - Only return Account resources with the given status. Can be `closed`, `suspended` or `active`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + return - OK 
    remote isolated function listAccount(string? friendlyName = (), Account_enum_status? status = (), int? pageSize = (), int? page = (), string? pageToken = ()) returns ListAccountResponse|error {
        return self.generatedClient->listAccount(friendlyName, status, pageSize, page, pageToken);
    }
    # Create a new Twilio Subaccount from the account making the request
    #
    # + payload - You must provide a `CreateAccountRequest` record, with the `FriendlyName` property set to the name of the account you want to create.
    # + return - Created 
    remote isolated function createAccount(CreateAccountRequest payload) returns Account|error {
        return self.generatedClient->createAccount(payload);
    }
    # Fetch the account specified by the provided Account Sid
    #
    # + sid - The Account Sid that uniquely identifies the account to fetch
    # + return - OK 
    remote isolated function fetchAccount(string sid) returns Account|error {
        return self.generatedClient->fetchAccount(sid);
    }
    # Modify the properties of a given Account
    # + payload - You must provide a `UpdateAccountRequest` record as a payload to update an Account.
    # + sid - The Account Sid that uniquely identifies the account to update
    # + return - OK 
    remote isolated function updateAccount(string sid, UpdateAccountRequest payload) returns Account|error {
        return self.generatedClient->updateAccount(sid, payload);
    }
    # List Address
    #
    # + customerName - The `customer_name` of the Address resources to read.
    # + friendlyName - The string that identifies the Address resources to read.
    # + isoCountry - The ISO country code of the Address resources to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to read.
    # + return - OK 
    remote isolated function listAddress(string? customerName = (), string? friendlyName = (), string? isoCountry = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAddressResponse|error {
        return self.generatedClient->listAddress(accountSid ?: self.accountSid, customerName, friendlyName, isoCountry, pageSize, page, pageToken);
    }
    # Create Address
    #
    # + payload - You must provide a `CreateAddressRequest` record as a payload to create a new Address resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will be responsible for the new Address resource.
    # + return - Created 
    remote isolated function createAddress(CreateAddressRequest payload, string? accountSid = ()) returns Address|error {
        return self.generatedClient->createAddress(accountSid ?: self.accountSid, payload);
    }
    # Fetch Address
    #
    # + sid - The Twilio-provided string that uniquely identifies the Address resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to fetch.
    # + return - OK 
    remote isolated function fetchAddress(string sid, string? accountSid = ()) returns Address|error {
        return self.generatedClient->fetchAddress(accountSid ?: self.accountSid, sid);
    }
    # Update Address
    #
    # + sid - The Twilio-provided string that uniquely identifies the Address resource to update.
    # + payload - You must provide a `UpdateAddressRequest` record as a payload to update an Address resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to update.
    # + return - OK 
    remote isolated function updateAddress(string sid, UpdateAddressRequest payload, string? accountSid = ()) returns Address|error {
        return self.generatedClient->updateAddress(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete Address
    #
    # + sid - The Twilio-provided string that uniquely identifies the Address resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteAddress(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteAddress(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of applications representing an application within the requesting account
    #
    # + friendlyName - The string that identifies the Application resources to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resources to read.
    # + return - OK 
    remote isolated function listApplication(string? friendlyName = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListApplicationResponse|error {
        return self.generatedClient->listApplication(accountSid ?: self.accountSid, friendlyName, pageSize, page, pageToken);
    }
    # Create a new application within your account
    #
    # + payload - You must provide a `CreateApplicationRequest` record as a payload to create a new Application resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createApplication(CreateApplicationRequest payload, string? accountSid = ()) returns Application|error {
        return self.generatedClient->createApplication(accountSid ?: self.accountSid, payload);
    }
    # Fetch the application specified by the provided sid
    #
    # + sid - The Twilio-provided string that uniquely identifies the Application resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resource to fetch.
    # + return - OK 
    remote isolated function fetchApplication(string sid, string? accountSid = ()) returns Application|error {
        return self.generatedClient->fetchApplication(accountSid ?: self.accountSid, sid);
    }
    # Updates the application's properties
    #
    # + sid - The Twilio-provided string that uniquely identifies the Application resource to update.
    # + payload - You must provide a `UpdateApplicationRequest` record as a payload to update an Application resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resources to update.
    # + return - OK 
    remote isolated function updateApplication(string sid, UpdateApplicationRequest payload, string? accountSid = ()) returns Application|error {
        return self.generatedClient->updateApplication(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete the application by the specified application sid
    #
    # + sid - The Twilio-provided string that uniquely identifies the Application resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteApplication(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteApplication(accountSid ?: self.accountSid, sid);
    }
    # Fetch an instance of an authorized-connect-app
    #
    # + connectAppSid - The SID of the Connect App to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the AuthorizedConnectApp resource to fetch.
    # + return - OK 
    remote isolated function fetchAuthorizedConnectApp(string connectAppSid, string? accountSid = ()) returns Authorized_connect_app|error {
        return self.generatedClient->fetchAuthorizedConnectApp(accountSid ?: self.accountSid, connectAppSid);
    }
    # Retrieve a list of authorized-connect-apps belonging to the account used to make the request
    #
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the AuthorizedConnectApp resources to read.
    # + return - OK 
    remote isolated function listAuthorizedConnectApp(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAuthorizedConnectAppResponse|error {
        return self.generatedClient->listAuthorizedConnectApp(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # List contries that have available for phone numbers
    # 
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the available phone numbers Country resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberCountry(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberCountryResponse|error {
        return self.generatedClient->listAvailablePhoneNumberCountry(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Fetch an available phone number by country code
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country to fetch available phone numbers information about.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the available phone numbers Country resource.
    # + return - OK 
    remote isolated function fetchAvailablePhoneNumberCountry(string countryCode, string? accountSid = ()) returns Available_phone_number_country|error {
        return self.generatedClient->fetchAvailablePhoneNumberCountry(accountSid ?: self.accountSid, countryCode);
    }
    # List available phone numbers (local)
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers.
    # + areaCode - The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada.
    # + contains - The pattern on which to match phone numbers. Valid characters are `*`, `0-9`, `a-z`, and `A-Z`. The `*` character matches any single digit. For examples, see [Example 2](https://www.twilio.com/docs/phone-numbers/api/availablephonenumberlocal-resource?code-sample=code-find-phone-numbers-by-number-pattern) and [Example 3](https://www.twilio.com/docs/phone-numbers/api/availablephonenumberlocal-resource?code-sample=code-find-phone-numbers-by-character-pattern). If specified, this value must have at least two characters.
    # + smsEnabled - Whether the phone numbers can receive text messages. Can be: `true` or `false`.
    # + mmsEnabled - Whether the phone numbers can receive MMS messages. Can be: `true` or `false`.
    # + voiceEnabled - Whether the phone numbers can receive calls. Can be: `true` or `false`.
    # + excludeAllAddressRequired - Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeLocalAddressRequired - Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeForeignAddressRequired - Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + beta - Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + nearNumber - Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada.
    # + nearLatLong - Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada.
    # + distance - The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada.
    # + inPostalCode - Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada.
    # + inRegion - Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada.
    # + inRateCenter - Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada.
    # + inLata - Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada.
    # + inLocality - Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number.
    # + faxEnabled - Whether the phone numbers can receive faxes. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberLocal(string countryCode, int? areaCode = (), string? contains = (), boolean? smsEnabled = (), boolean? mmsEnabled = (), boolean? voiceEnabled = (), boolean? excludeAllAddressRequired = (), boolean? excludeLocalAddressRequired = (), boolean? excludeForeignAddressRequired = (), boolean? beta = (), string? nearNumber = (), string? nearLatLong = (), int? distance = (), string? inPostalCode = (), string? inRegion = (), string? inRateCenter = (), string? inLata = (), string? inLocality = (), boolean? faxEnabled = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberLocalResponse|error {
        return self.generatedClient->listAvailablePhoneNumberLocal(accountSid ?: self.accountSid, countryCode, areaCode, contains, smsEnabled, mmsEnabled, voiceEnabled, excludeAllAddressRequired, excludeLocalAddressRequired, excludeForeignAddressRequired, beta, nearNumber, nearLatLong, distance, inPostalCode, inRegion, inRateCenter, inLata, inLocality, faxEnabled, pageSize, page, pageToken);
    }
    # List available phone numbers (MachineToMachine)
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers.
    # + areaCode - The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada.
    # + contains - The pattern on which to match phone numbers. Valid characters are `*`, `0-9`, `a-z`, and `A-Z`. The `*` character matches any single digit. For examples, see [Example 2](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-2) and [Example 3](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-3). If specified, this value must have at least two characters.
    # + smsEnabled - Whether the phone numbers can receive text messages. Can be: `true` or `false`.
    # + mmsEnabled - Whether the phone numbers can receive MMS messages. Can be: `true` or `false`.
    # + voiceEnabled - Whether the phone numbers can receive calls. Can be: `true` or `false`.
    # + excludeAllAddressRequired - Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeLocalAddressRequired - Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeForeignAddressRequired - Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + beta - Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + nearNumber - Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada.
    # + nearLatLong - Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada.
    # + distance - The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada.
    # + inPostalCode - Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada.
    # + inRegion - Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada.
    # + inRateCenter - Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada.
    # + inLata - Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada.
    # + inLocality - Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number.
    # + faxEnabled - Whether the phone numbers can receive faxes. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberMachineToMachine(string countryCode, int? areaCode = (), string? contains = (), boolean? smsEnabled = (), boolean? mmsEnabled = (), boolean? voiceEnabled = (), boolean? excludeAllAddressRequired = (), boolean? excludeLocalAddressRequired = (), boolean? excludeForeignAddressRequired = (), boolean? beta = (), string? nearNumber = (), string? nearLatLong = (), int? distance = (), string? inPostalCode = (), string? inRegion = (), string? inRateCenter = (), string? inLata = (), string? inLocality = (), boolean? faxEnabled = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberMachineToMachineResponse|error {
        return self.generatedClient->listAvailablePhoneNumberMachineToMachine(accountSid ?: self.accountSid, countryCode, areaCode, contains, smsEnabled, mmsEnabled, voiceEnabled, excludeAllAddressRequired, excludeLocalAddressRequired, excludeForeignAddressRequired, beta, nearNumber, nearLatLong, distance, inPostalCode, inRegion, inRateCenter, inLata, inLocality, faxEnabled, pageSize, page, pageToken);
    }
    # List available phone numbers (Mobile)
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers.
    # + areaCode - The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada.
    # + contains - The pattern on which to match phone numbers. Valid characters are `*`, `0-9`, `a-z`, and `A-Z`. The `*` character matches any single digit. For examples, see [Example 2](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-2) and [Example 3](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-3). If specified, this value must have at least two characters.
    # + smsEnabled - Whether the phone numbers can receive text messages. Can be: `true` or `false`.
    # + mmsEnabled - Whether the phone numbers can receive MMS messages. Can be: `true` or `false`.
    # + voiceEnabled - Whether the phone numbers can receive calls. Can be: `true` or `false`.
    # + excludeAllAddressRequired - Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeLocalAddressRequired - Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeForeignAddressRequired - Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + beta - Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + nearNumber - Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada.
    # + nearLatLong - Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada.
    # + distance - The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada.
    # + inPostalCode - Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada.
    # + inRegion - Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada.
    # + inRateCenter - Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada.
    # + inLata - Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada.
    # + inLocality - Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number.
    # + faxEnabled - Whether the phone numbers can receive faxes. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberMobile(string countryCode, int? areaCode = (), string? contains = (), boolean? smsEnabled = (), boolean? mmsEnabled = (), boolean? voiceEnabled = (), boolean? excludeAllAddressRequired = (), boolean? excludeLocalAddressRequired = (), boolean? excludeForeignAddressRequired = (), boolean? beta = (), string? nearNumber = (), string? nearLatLong = (), int? distance = (), string? inPostalCode = (), string? inRegion = (), string? inRateCenter = (), string? inLata = (), string? inLocality = (), boolean? faxEnabled = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberMobileResponse|error {
        return self.generatedClient->listAvailablePhoneNumberMobile(accountSid ?: self.accountSid, countryCode, areaCode, contains, smsEnabled, mmsEnabled, voiceEnabled, excludeAllAddressRequired, excludeLocalAddressRequired, excludeForeignAddressRequired, beta, nearNumber, nearLatLong, distance, inPostalCode, inRegion, inRateCenter, inLata, inLocality, faxEnabled, pageSize, page, pageToken);
    }
    # List available phone numbers (National)
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers.
    # + areaCode - The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada.
    # + contains - The pattern on which to match phone numbers. Valid characters are `*`, `0-9`, `a-z`, and `A-Z`. The `*` character matches any single digit. For examples, see [Example 2](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-2) and [Example 3](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-3). If specified, this value must have at least two characters.
    # + smsEnabled - Whether the phone numbers can receive text messages. Can be: `true` or `false`.
    # + mmsEnabled - Whether the phone numbers can receive MMS messages. Can be: `true` or `false`.
    # + voiceEnabled - Whether the phone numbers can receive calls. Can be: `true` or `false`.
    # + excludeAllAddressRequired - Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeLocalAddressRequired - Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeForeignAddressRequired - Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + beta - Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + nearNumber - Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada.
    # + nearLatLong - Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada.
    # + distance - The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada.
    # + inPostalCode - Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada.
    # + inRegion - Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada.
    # + inRateCenter - Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada.
    # + inLata - Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada.
    # + inLocality - Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number.
    # + faxEnabled - Whether the phone numbers can receive faxes. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberNational(string countryCode, int? areaCode = (), string? contains = (), boolean? smsEnabled = (), boolean? mmsEnabled = (), boolean? voiceEnabled = (), boolean? excludeAllAddressRequired = (), boolean? excludeLocalAddressRequired = (), boolean? excludeForeignAddressRequired = (), boolean? beta = (), string? nearNumber = (), string? nearLatLong = (), int? distance = (), string? inPostalCode = (), string? inRegion = (), string? inRateCenter = (), string? inLata = (), string? inLocality = (), boolean? faxEnabled = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberNationalResponse|error {
        return self.generatedClient->listAvailablePhoneNumberNational(accountSid ?: self.accountSid, countryCode, areaCode, contains, smsEnabled, mmsEnabled, voiceEnabled, excludeAllAddressRequired, excludeLocalAddressRequired, excludeForeignAddressRequired, beta, nearNumber, nearLatLong, distance, inPostalCode, inRegion, inRateCenter, inLata, inLocality, faxEnabled, pageSize, page, pageToken);
    }
    # List available phone numbers (SharedCost)
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers.
    # + areaCode - The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada.
    # + contains - The pattern on which to match phone numbers. Valid characters are `*`, `0-9`, `a-z`, and `A-Z`. The `*` character matches any single digit. For examples, see [Example 2](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-2) and [Example 3](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-3). If specified, this value must have at least two characters.
    # + smsEnabled - Whether the phone numbers can receive text messages. Can be: `true` or `false`.
    # + mmsEnabled - Whether the phone numbers can receive MMS messages. Can be: `true` or `false`.
    # + voiceEnabled - Whether the phone numbers can receive calls. Can be: `true` or `false`.
    # + excludeAllAddressRequired - Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeLocalAddressRequired - Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeForeignAddressRequired - Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + beta - Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + nearNumber - Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada.
    # + nearLatLong - Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada.
    # + distance - The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada.
    # + inPostalCode - Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada.
    # + inRegion - Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada.
    # + inRateCenter - Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada.
    # + inLata - Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada.
    # + inLocality - Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number.
    # + faxEnabled - Whether the phone numbers can receive faxes. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberSharedCost(string countryCode, int? areaCode = (), string? contains = (), boolean? smsEnabled = (), boolean? mmsEnabled = (), boolean? voiceEnabled = (), boolean? excludeAllAddressRequired = (), boolean? excludeLocalAddressRequired = (), boolean? excludeForeignAddressRequired = (), boolean? beta = (), string? nearNumber = (), string? nearLatLong = (), int? distance = (), string? inPostalCode = (), string? inRegion = (), string? inRateCenter = (), string? inLata = (), string? inLocality = (), boolean? faxEnabled = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberSharedCostResponse|error {
        return self.generatedClient->listAvailablePhoneNumberSharedCost(accountSid ?: self.accountSid, countryCode, areaCode, contains, smsEnabled, mmsEnabled, voiceEnabled, excludeAllAddressRequired, excludeLocalAddressRequired, excludeForeignAddressRequired, beta, nearNumber, nearLatLong, distance, inPostalCode, inRegion, inRateCenter, inLata, inLocality, faxEnabled, pageSize, page, pageToken);
    }
    # List available phone numbers (TollFree)
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers.
    # + areaCode - The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada.
    # + contains - The pattern on which to match phone numbers. Valid characters are `*`, `0-9`, `a-z`, and `A-Z`. The `*` character matches any single digit. For examples, see [Example 2](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-2) and [Example 3](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-3). If specified, this value must have at least two characters.
    # + smsEnabled - Whether the phone numbers can receive text messages. Can be: `true` or `false`.
    # + mmsEnabled - Whether the phone numbers can receive MMS messages. Can be: `true` or `false`.
    # + voiceEnabled - Whether the phone numbers can receive calls. Can be: `true` or `false`.
    # + excludeAllAddressRequired - Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeLocalAddressRequired - Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeForeignAddressRequired - Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + beta - Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + nearNumber - Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada.
    # + nearLatLong - Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada.
    # + distance - The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada.
    # + inPostalCode - Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada.
    # + inRegion - Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada.
    # + inRateCenter - Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada.
    # + inLata - Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada.
    # + inLocality - Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number.
    # + faxEnabled - Whether the phone numbers can receive faxes. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberTollFree(string countryCode, int? areaCode = (), string? contains = (), boolean? smsEnabled = (), boolean? mmsEnabled = (), boolean? voiceEnabled = (), boolean? excludeAllAddressRequired = (), boolean? excludeLocalAddressRequired = (), boolean? excludeForeignAddressRequired = (), boolean? beta = (), string? nearNumber = (), string? nearLatLong = (), int? distance = (), string? inPostalCode = (), string? inRegion = (), string? inRateCenter = (), string? inLata = (), string? inLocality = (), boolean? faxEnabled = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberTollFreeResponse|error {
        return self.generatedClient->listAvailablePhoneNumberTollFree(accountSid ?: self.accountSid, countryCode, areaCode, contains, smsEnabled, mmsEnabled, voiceEnabled, excludeAllAddressRequired, excludeLocalAddressRequired, excludeForeignAddressRequired, beta, nearNumber, nearLatLong, distance, inPostalCode, inRegion, inRateCenter, inLata, inLocality, faxEnabled, pageSize, page, pageToken);
    }
    # List available phone numbers (Voip)
    # 
    # + countryCode - The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country from which to read phone numbers.
    # + areaCode - The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada.
    # + contains - The pattern on which to match phone numbers. Valid characters are `*`, `0-9`, `a-z`, and `A-Z`. The `*` character matches any single digit. For examples, see [Example 2](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-2) and [Example 3](https://www.twilio.com/docs/phone-numbers/api/availablephonenumber-resource#local-get-basic-example-3). If specified, this value must have at least two characters.
    # + smsEnabled - Whether the phone numbers can receive text messages. Can be: `true` or `false`.
    # + mmsEnabled - Whether the phone numbers can receive MMS messages. Can be: `true` or `false`.
    # + voiceEnabled - Whether the phone numbers can receive calls. Can be: `true` or `false`.
    # + excludeAllAddressRequired - Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeLocalAddressRequired - Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + excludeForeignAddressRequired - Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`.
    # + beta - Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + nearNumber - Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada.
    # + nearLatLong - Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada.
    # + distance - The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada.
    # + inPostalCode - Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada.
    # + inRegion - Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada.
    # + inRateCenter - Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada.
    # + inLata - Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada.
    # + inLocality - Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number.
    # + faxEnabled - Whether the phone numbers can receive faxes. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) requesting the AvailablePhoneNumber resources.
    # + return - OK 
    remote isolated function listAvailablePhoneNumberVoip(string countryCode, int? areaCode = (), string? contains = (), boolean? smsEnabled = (), boolean? mmsEnabled = (), boolean? voiceEnabled = (), boolean? excludeAllAddressRequired = (), boolean? excludeLocalAddressRequired = (), boolean? excludeForeignAddressRequired = (), boolean? beta = (), string? nearNumber = (), string? nearLatLong = (), int? distance = (), string? inPostalCode = (), string? inRegion = (), string? inRateCenter = (), string? inLata = (), string? inLocality = (), boolean? faxEnabled = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListAvailablePhoneNumberVoipResponse|error {
        return self.generatedClient->listAvailablePhoneNumberVoip(accountSid ?: self.accountSid, countryCode, areaCode, contains, smsEnabled, mmsEnabled, voiceEnabled, excludeAllAddressRequired, excludeLocalAddressRequired, excludeForeignAddressRequired, beta, nearNumber, nearLatLong, distance, inPostalCode, inRegion, inRateCenter, inLata, inLocality, faxEnabled, pageSize, page, pageToken);
    }
    # Fetch the balance for an Account based on Account Sid. Balance changes may not be reflected immediately. Child accounts do not contain balance information
    #
    # + accountSid - The unique SID identifier of the Account.
    # + return - OK 
    remote isolated function fetchBalance(string? accountSid = ()) returns Balance|error {
        return self.generatedClient->fetchBalance(accountSid ?: self.accountSid);
    }
    # Retrieves a collection of calls made to and from your account
    #
    # + to - Only show calls made to this phone number, SIP address, Client identifier or SIM SID.
    # + 'from - Only include calls from this phone number, SIP address, Client identifier or SIM SID.
    # + parentCallSid - Only include calls spawned by calls with this SID.
    # + status - The status of the calls to include. Can be: `queued`, `ringing`, `in-progress`, `canceled`, `completed`, `failed`, `busy`, or `no-answer`.
    # + startTime - Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date.
    # + startedOnOrBefore - Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date.
    # + startedOnOrAfter - Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date.
    # + endTime - Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date.
    # + endedOnOrBefore - Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date.
    # + endedOnOrAfter - Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to read.
    # + return - OK 
    remote isolated function listCall(string? to = (), string? 'from = (), string? parentCallSid = (), Call_enum_status? status = (), string? startTime = (), string? startedOnOrBefore = (), string? startedOnOrAfter = (), string? endTime = (), string? endedOnOrBefore = (), string? endedOnOrAfter = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListCallResponse|error {
        return self.generatedClient->listCall(accountSid ?: self.accountSid, to, 'from, parentCallSid, status, startTime, startedOnOrBefore, startedOnOrAfter, endTime, endedOnOrBefore, endedOnOrAfter, pageSize, page, pageToken);
    }
    # Create a new outgoing call to phones, SIP-enabled endpoints or Twilio Client connections
    #
    # + payload - You must provide a `CrateCallRequest` record as a payload to create a call.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createCall(CreateCallRequest payload, string? accountSid = ()) returns Call|error {
        return self.generatedClient->createCall(accountSid ?: self.accountSid, payload);
    }
    # Fetch the call specified by the provided Call SID
    #
    # + sid - The SID of the Call resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to fetch.
    # + return - OK 
    remote isolated function fetchCall(string sid, string? accountSid = ()) returns Call|error {
        return self.generatedClient->fetchCall(accountSid ?: self.accountSid, sid);
    }
    # Initiates a call redirect or terminates a call
    #
    # + sid - The Twilio-provided string that uniquely identifies the Call resource to update
    # + payload - You must provide a `UpdateCallRequest` record as a payload to update a call.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to update.
    # + return - OK 
    remote isolated function updateCall(string sid, UpdateCallRequest payload, string? accountSid = ()) returns Call|error {
        return self.generatedClient->updateCall(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete a Call record from your account. Once the record is deleted, it will no longer appear in the API and Account Portal logs.
    #
    # + sid - The Twilio-provided Call SID that uniquely identifies the Call resource to delete
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call resource(s) to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteCall(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteCall(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of all events for a call.
    #
    # + callSid - The unique SID identifier of the Call.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The unique SID identifier of the Account.
    # + return - OK 
    remote isolated function listCallEvent(string callSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListCallEventResponse|error {
        return self.generatedClient->listCallEvent(accountSid ?: self.accountSid, callSid, pageSize, page, pageToken);
    }
    # Fetch a Feedback resource from a call
    #
    # + callSid - The call sid that uniquely identifies the call
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function fetchCallFeedback(string callSid, string? accountSid = ()) returns CallCall_feedback|error {
        return self.generatedClient->fetchCallFeedback(accountSid ?: self.accountSid, callSid);
    }
    # Update a Feedback resource for a call
    #    
    # + callSid - The call sid that uniquely identifies the call
    # + payload - You must provide a `UpdateCallFeedbackRequest` record as a payload to update a feedback.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function updateCallFeedback(string callSid, UpdateCallFeedbackRequest payload, string? accountSid = ()) returns CallCall_feedback|error {
        return self.generatedClient->updateCallFeedback(accountSid ?: self.accountSid, callSid, payload);
    }
    # Create a FeedbackSummary resource for a call
    #
    # + payload - You must provide a `CreateCallFeedbackSummaryRequest` record as a payload to create a feedback summary.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - Created 
    remote isolated function createCallFeedbackSummary(CreateCallFeedbackSummaryRequest payload, string? accountSid = ()) returns CallCall_feedback_summary|error {
        return self.generatedClient->createCallFeedbackSummary(accountSid ?: self.accountSid, payload);
    }
    # Fetch a FeedbackSummary resource from a call
    #
    # + sid - A 34 character string that uniquely identifies this resource.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function fetchCallFeedbackSummary(string sid, string? accountSid = ()) returns CallCall_feedback_summary|error {
        return self.generatedClient->fetchCallFeedbackSummary(accountSid ?: self.accountSid, sid);
    }
    # Delete a FeedbackSummary resource from a call
    #
    # + sid - A 34 character string that uniquely identifies this resource.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteCallFeedbackSummary(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteCallFeedbackSummary(accountSid ?: self.accountSid, sid);
    }
    # Fetch call notifications for a call
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the Call Notification resource to fetch.
    # + sid - The Twilio-provided string that uniquely identifies the Call Notification resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resource to fetch.
    # + return - OK 
    remote isolated function fetchCallNotification(string callSid, string sid, string? accountSid = ()) returns CallCall_notificationInstance|error {
        return self.generatedClient->fetchCallNotification(accountSid ?: self.accountSid, callSid, sid);
    }
    # List Call Notification associated with a Call
    # 
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the Call Notification resources to read.
    # + log - Only read notifications of the specified log level. Can be:  `0` to read only ERROR notifications or `1` to read only WARNING notifications. By default, all notifications are read.
    # + messageDate - Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    # + loggedAtOrBefore - Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    # + loggedAtOrAfter - Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resources to read.
    # + return - OK 
    remote isolated function listCallNotification(string callSid, int? log = (), string? messageDate = (), string? loggedAtOrBefore = (), string? loggedAtOrAfter = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListCallNotificationResponse|error {
        return self.generatedClient->listCallNotification(accountSid ?: self.accountSid, callSid, log, messageDate, loggedAtOrBefore, loggedAtOrAfter, pageSize, page, pageToken);
    }
    # Retrieve a list of recordings belonging to the call used to make the request
    #
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resources to read.
    # + dateCreated - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date.
    # + dateCreatedOnOrBefore - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date.
    # + dateCreatedOnOrAfter - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to read.
    # + return - OK 
    remote isolated function listCallRecording(string callSid, string? dateCreated = (), string? dateCreatedOnOrBefore = (), string? dateCreatedOnOrAfter = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListCallRecordingResponse|error {
        return self.generatedClient->listCallRecording(accountSid ?: self.accountSid, callSid, dateCreated, dateCreatedOnOrBefore, dateCreatedOnOrAfter, pageSize, page, pageToken);
    }
    # Create a recording for the call
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) to associate the resource with.
    # + payload - You must provide a `CreateCallRecordingRequest` record as a payload to create a recording.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createCallRecording(string callSid, CreateCallRecordingRequest payload, string? accountSid = ()) returns CallCall_recording|error {
        return self.generatedClient->createCallRecording(accountSid ?: self.accountSid, callSid, payload);
    }
    # Fetch an instance of a recording for a call
    #
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource to fetch.
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource to fetch.
    # + return - OK 
    remote isolated function fetchCallRecording(string callSid, string sid, string? accountSid = ()) returns CallCall_recording|error {
        return self.generatedClient->fetchCallRecording(accountSid ?: self.accountSid, callSid, sid);
    }
    # Changes the status of the recording to paused, stopped, or in-progress. Note: Pass `Twilio.CURRENT` instead of recording sid to reference current active recording.
    #
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource to update.
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to update.
    # + payload - You must provide a `UpdateCallRecordingRequest` record as a payload to update a recording.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource to update.
    # + return - OK 
    remote isolated function updateCallRecording(string callSid, string sid, UpdateCallRecordingRequest payload, string? accountSid = ()) returns CallCall_recording|error {
        return self.generatedClient->updateCallRecording(accountSid ?: self.accountSid, callSid, sid, payload);
    }
    # Delete a recording from your account
    #
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resources to delete.
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteCallRecording(string callSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteCallRecording(accountSid ?: self.accountSid, callSid, sid);
    }
    # Fetch an instance of a conference
    #
    # + sid - The Twilio-provided string that uniquely identifies the Conference resource to fetch
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference resource(s) to fetch.
    # + return - OK 
    remote isolated function fetchConference(string sid, string? accountSid = ()) returns Conference|error {
        return self.generatedClient->fetchConference(accountSid ?: self.accountSid, sid);
    }
    # Update a conference
    #
    # + sid - The Twilio-provided string that uniquely identifies the Conference resource to update
    # + payload - You must provide a `UpdateConferenceRequest` record as a payload to update a conference.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference resource(s) to update.
    # + return - OK 
    remote isolated function updateConference(string sid, UpdateConferenceRequest payload, string? accountSid = ()) returns Conference|error {
        return self.generatedClient->updateConference(accountSid ?: self.accountSid, sid, payload);
    }
    # Retrieve a list of conferences belonging to the account used to make the request
    #
    # + dateCreated - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. To read conferences that started on or before midnight on a date, use `<=YYYY-MM-DD`, and to specify  conferences that started on or after midnight on a date, use `>=YYYY-MM-DD`.
    # + dateCreatedOnOrBefore - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. To read conferences that started on or before midnight on a date, use `<=YYYY-MM-DD`, and to specify  conferences that started on or after midnight on a date, use `>=YYYY-MM-DD`.
    # + dateCreatedOnOrAfter - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. To read conferences that started on or before midnight on a date, use `<=YYYY-MM-DD`, and to specify  conferences that started on or after midnight on a date, use `>=YYYY-MM-DD`.
    # + dateUpdated - The `date_updated` value, specified as `YYYY-MM-DD`, of the resources to read. To read conferences that were last updated on or before midnight on a date, use `<=YYYY-MM-DD`, and to specify conferences that were last updated on or after midnight on a given date, use  `>=YYYY-MM-DD`.
    # + dateUpdatedOnOrBefore - The `date_updated` value, specified as `YYYY-MM-DD`, of the resources to read. To read conferences that were last updated on or before midnight on a date, use `<=YYYY-MM-DD`, and to specify conferences that were last updated on or after midnight on a given date, use  `>=YYYY-MM-DD`.
    # + dateUpdatedOnOrAfter - The `date_updated` value, specified as `YYYY-MM-DD`, of the resources to read. To read conferences that were last updated on or before midnight on a date, use `<=YYYY-MM-DD`, and to specify conferences that were last updated on or after midnight on a given date, use  `>=YYYY-MM-DD`.
    # + friendlyName - The string that identifies the Conference resources to read.
    # + status - The status of the resources to read. Can be: `init`, `in-progress`, or `completed`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference resource(s) to read.
    # + return - OK 
    remote isolated function listConference(string? dateCreated = (), string? dateCreatedOnOrBefore = (), string? dateCreatedOnOrAfter = (), string? dateUpdated = (), string? dateUpdatedOnOrBefore = (), string? dateUpdatedOnOrAfter = (), string? friendlyName = (), Conference_enum_status? status = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListConferenceResponse|error {
        return self.generatedClient->listConference(accountSid ?: self.accountSid, dateCreated, dateCreatedOnOrBefore, dateCreatedOnOrAfter, dateUpdated, dateUpdatedOnOrBefore, dateUpdatedOnOrAfter, friendlyName, status, pageSize, page, pageToken);
    }
    # Fetch an instance of a recording for a call
    #
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to fetch.
    # + sid - The Twilio-provided string that uniquely identifies the Conference Recording resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resource to fetch.
    # + return - OK 
    remote isolated function fetchConferenceRecording(string conferenceSid, string sid, string? accountSid = ()) returns ConferenceConference_recording|error {
        return self.generatedClient->fetchConferenceRecording(accountSid ?: self.accountSid, conferenceSid, sid);
    }
    # Changes the status of the recording to paused, stopped, or in-progress. Note: To use `Twilio.CURRENT`, pass it as recording sid.
    #
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to update.
    # + sid - The Twilio-provided string that uniquely identifies the Conference Recording resource to update. Use `Twilio.CURRENT` to reference the current active recording.
    # + payload - You must provide a `UpdateConferenceRecordingRequest` record as a payload to update a recording.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resource to update.
    # + return - OK 
    remote isolated function updateConferenceRecording(string conferenceSid, string sid, UpdateConferenceRecordingRequest payload, string? accountSid = ()) returns ConferenceConference_recording|error {
        return self.generatedClient->updateConferenceRecording(accountSid ?: self.accountSid, conferenceSid, sid, payload);
    }
    # Delete a recording from your account
    #
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to delete.
    # + sid - The Twilio-provided string that uniquely identifies the Conference Recording resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteConferenceRecording(string conferenceSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteConferenceRecording(accountSid ?: self.accountSid, conferenceSid, sid);
    }
    # Retrieve a list of recordings belonging to the call used to make the request
    #
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to read.
    # + dateCreated - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date.
    # + dateCreatedOnOrBefore - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date.
    # + dateCreatedOnOrAfter - The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resources to read.
    # + return - OK 
    remote isolated function listConferenceRecording(string conferenceSid, string? dateCreated = (), string? dateCreatedOnOrBefore = (), string? dateCreatedOnOrAfter = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListConferenceRecordingResponse|error {
        return self.generatedClient->listConferenceRecording(accountSid ?: self.accountSid, conferenceSid, dateCreated, dateCreatedOnOrBefore, dateCreatedOnOrAfter, pageSize, page, pageToken);
    }
    # Fetch an instance of a connect-app
    #
    # + sid - The Twilio-provided string that uniquely identifies the ConnectApp resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resource to fetch.
    # + return - OK 
    remote isolated function fetchConnectApp(string sid, string? accountSid = ()) returns Connect_app|error {
        return self.generatedClient->fetchConnectApp(accountSid ?: self.accountSid, sid);
    }
    # Update a connect-app with the specified parameters
    #
    # + sid - The Twilio-provided string that uniquely identifies the ConnectApp resource to update.
    # + payload - You must provide a `UpdateConnectAppRequest` record as a payload to update a connect-app.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resources to update.
    # + return - OK 
    remote isolated function updateConnectApp(string sid, UpdateConnectAppRequest payload, string? accountSid = ()) returns Connect_app|error {
        return self.generatedClient->updateConnectApp(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete an instance of a connect-app
    #
    # + sid - The Twilio-provided string that uniquely identifies the ConnectApp resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resource to fetch.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteConnectApp(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteConnectApp(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of connect-apps belonging to the account used to make the request
    #
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resources to read.
    # + return - OK 
    remote isolated function listConnectApp(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListConnectAppResponse|error {
        return self.generatedClient->listConnectApp(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # List dependent phone numbers for an address
    # 
    # + addressSid - The SID of the Address resource associated with the phone number.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the DependentPhoneNumber resources to read.
    # + return - OK 
    remote isolated function listDependentPhoneNumber(string addressSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListDependentPhoneNumberResponse|error {
        return self.generatedClient->listDependentPhoneNumber(accountSid ?: self.accountSid, addressSid, pageSize, page, pageToken);
    }
    # Fetch an incoming-phone-number belonging to the account used to make the request.
    #
    # + sid - The Twilio-provided string that uniquely identifies the IncomingPhoneNumber resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resource to fetch.
    # + return - OK 
    remote isolated function fetchIncomingPhoneNumber(string sid, string? accountSid = ()) returns Incoming_phone_number|error {
        return self.generatedClient->fetchIncomingPhoneNumber(accountSid ?: self.accountSid, sid);
    }
    # Update an incoming-phone-number instance.
    #
    # + sid - The Twilio-provided string that uniquely identifies the IncomingPhoneNumber resource to update.
    # + payload - You must provide a `UpdateIncomingPhoneNumberRequest` record as a payload to update a phone number.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resource to update.  For more information, see [Exchanging Numbers Between Subaccounts](https://www.twilio.com/docs/iam/api/subaccounts#exchanging-numbers).
    # + return - OK 
    remote isolated function updateIncomingPhoneNumber(string sid, UpdateIncomingPhoneNumberRequest payload, string? accountSid = ()) returns Incoming_phone_number|error {
        return self.generatedClient->updateIncomingPhoneNumber(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete a phone-numbers belonging to the account used to make the request.
    #
    # + sid - The Twilio-provided string that uniquely identifies the IncomingPhoneNumber resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteIncomingPhoneNumber(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteIncomingPhoneNumber(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of incoming-phone-numbers belonging to the account used to make the request.
    #
    # + beta - Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + friendlyName - A string that identifies the IncomingPhoneNumber resources to read.
    # + phoneNumber - The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit.
    # + origin - Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resources to read.
    # + return - OK 
    remote isolated function listIncomingPhoneNumber(boolean? beta = (), string? friendlyName = (), string? phoneNumber = (), string? origin = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListIncomingPhoneNumberResponse|error {
        return self.generatedClient->listIncomingPhoneNumber(accountSid ?: self.accountSid, beta, friendlyName, phoneNumber, origin, pageSize, page, pageToken);
    }
    # Purchase a phone-number for the account.
    #
    # + payload - You must provide a `CreateIncomingPhoneNumberRequest` record as a payload to purchase a phone number.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createIncomingPhoneNumber(CreateIncomingPhoneNumberRequest payload, string? accountSid = ()) returns Incoming_phone_number|error {
        return self.generatedClient->createIncomingPhoneNumber(accountSid ?: self.accountSid, payload);
    }
    # Fetch an instance of an Add-on installation currently assigned to this Number.
    #
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned.
    # + sid - The Twilio-provided string that uniquely identifies the resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource to fetch.
    # + return - OK 
    remote isolated function fetchIncomingPhoneNumberAssignedAddOn(string resourceSid, string sid, string? accountSid = ()) returns Incoming_phone_numberIncoming_phone_number_assigned_add_on|error {
        return self.generatedClient->fetchIncomingPhoneNumberAssignedAddOn(accountSid ?: self.accountSid, resourceSid, sid);
    }
    # Remove the assignment of an Add-on installation from the Number specified.
    #
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned.
    # + sid - The Twilio-provided string that uniquely identifies the resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteIncomingPhoneNumberAssignedAddOn(string resourceSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteIncomingPhoneNumberAssignedAddOn(accountSid ?: self.accountSid, resourceSid, sid);
    }
    # Retrieve a list of Add-on installations currently assigned to this Number.
    #
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read.
    # + return - OK 
    remote isolated function listIncomingPhoneNumberAssignedAddOn(string resourceSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListIncomingPhoneNumberAssignedAddOnResponse|error {
        return self.generatedClient->listIncomingPhoneNumberAssignedAddOn(accountSid ?: self.accountSid, resourceSid, pageSize, page, pageToken);
    }
    # Assign an Add-on installation to the Number specified.
    #
    # + resourceSid - The SID of the Phone Number to assign the Add-on.
    # + payload - You must provide a `CreateIncomingPhoneNumberAssignedAddOnRequest` as a payload to crete an incoming phone number assigned add-on.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createIncomingPhoneNumberAssignedAddOn(string resourceSid, CreateIncomingPhoneNumberAssignedAddOnRequest payload, string? accountSid = ()) returns Incoming_phone_numberIncoming_phone_number_assigned_add_on|error {
        return self.generatedClient->createIncomingPhoneNumberAssignedAddOn(accountSid ?: self.accountSid, resourceSid, payload);
    }
    # Fetch an instance of an Extension for the Assigned Add-on.
    #
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned.
    # + assignedAddOnSid - The SID that uniquely identifies the assigned Add-on installation.
    # + sid - The Twilio-provided string that uniquely identifies the resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource to fetch.
    # + return - OK 
    remote isolated function fetchIncomingPhoneNumberAssignedAddOnExtension(string resourceSid, string assignedAddOnSid, string sid, string? accountSid = ()) returns Incoming_phone_numberIncoming_phone_number_assigned_add_onIncoming_phone_number_assigned_add_on_extension|error {
        return self.generatedClient->fetchIncomingPhoneNumberAssignedAddOnExtension(accountSid ?: self.accountSid, resourceSid, assignedAddOnSid, sid);
    }
    # Retrieve a list of Extensions for the Assigned Add-on.
    #
    # + resourceSid - The SID of the Phone Number to which the Add-on is assigned.
    # + assignedAddOnSid - The SID that uniquely identifies the assigned Add-on installation.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read.
    # + return - OK 
    remote isolated function listIncomingPhoneNumberAssignedAddOnExtension(string resourceSid, string assignedAddOnSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListIncomingPhoneNumberAssignedAddOnExtensionResponse|error {
        return self.generatedClient->listIncomingPhoneNumberAssignedAddOnExtension(accountSid ?: self.accountSid, resourceSid, assignedAddOnSid, pageSize, page, pageToken);
    }
    # List incoming-phone-numbers local for an address
    # 
    # + beta - Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + friendlyName - A string that identifies the resources to read.
    # + phoneNumber - The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit.
    # + origin - Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read.
    # + return - OK 
    remote isolated function listIncomingPhoneNumberLocal(boolean? beta = (), string? friendlyName = (), string? phoneNumber = (), string? origin = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListIncomingPhoneNumberLocalResponse|error {
        return self.generatedClient->listIncomingPhoneNumberLocal(accountSid ?: self.accountSid, beta, friendlyName, phoneNumber, origin, pageSize, page, pageToken);
    }
    # Create a phone-number for the account.
    # 
    # + payload - You must provide a `CreateIncomingPhoneNumberLocalRequest` record as a payload to purchase a phone number.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createIncomingPhoneNumberLocal(CreateIncomingPhoneNumberLocalRequest payload, string? accountSid = ()) returns Incoming_phone_numberIncoming_phone_number_local|error {
        return self.generatedClient->createIncomingPhoneNumberLocal(accountSid ?: self.accountSid, payload);
    }
    # List incoming-phone-numbers mobile for an address
    # 
    # + beta - Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + friendlyName - A string that identifies the resources to read.
    # + phoneNumber - The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit.
    # + origin - Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read.
    # + return - OK 
    remote isolated function listIncomingPhoneNumberMobile(boolean? beta = (), string? friendlyName = (), string? phoneNumber = (), string? origin = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListIncomingPhoneNumberMobileResponse|error {
        return self.generatedClient->listIncomingPhoneNumberMobile(accountSid ?: self.accountSid, beta, friendlyName, phoneNumber, origin, pageSize, page, pageToken);
    }
    # Create a phone-number for the account.
    # 
    # + payload - You must provide a `CreateIncomingPhoneNumberMobileRequest` record as a payload to purchase a phone number.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createIncomingPhoneNumberMobile(CreateIncomingPhoneNumberMobileRequest payload, string? accountSid = ()) returns Incoming_phone_numberIncoming_phone_number_mobile|error {
        return self.generatedClient->createIncomingPhoneNumberMobile(accountSid ?: self.accountSid, payload);
    }
    # List incoming-phone-numbers troll-free for an address
    # 
    # + beta - Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`.
    # + friendlyName - A string that identifies the resources to read.
    # + phoneNumber - The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit.
    # + origin - Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read.
    # + return - OK 
    remote isolated function listIncomingPhoneNumberTollFree(boolean? beta = (), string? friendlyName = (), string? phoneNumber = (), string? origin = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListIncomingPhoneNumberTollFreeResponse|error {
        return self.generatedClient->listIncomingPhoneNumberTollFree(accountSid ?: self.accountSid, beta, friendlyName, phoneNumber, origin, pageSize, page, pageToken);
    }
    # Create a phone-number for the account.
    # 
    # + payload - You must provide a `CreateIncomingPhoneNumberTollFreeRequest` record as a payload to purchase a phone number.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createIncomingPhoneNumberTollFree(CreateIncomingPhoneNumberTollFreeRequest payload, string? accountSid = ()) returns Incoming_phone_numberIncoming_phone_number_toll_free|error {
        return self.generatedClient->createIncomingPhoneNumberTollFree(accountSid ?: self.accountSid, payload);
    }
    # Fetch key resource
    # 
    # + sid - The Twilio-provided string that uniquely identifies the Key resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resource to fetch.
    # + return - OK 
    remote isolated function fetchKey(string sid, string? accountSid = ()) returns Key|error {
        return self.generatedClient->fetchKey(accountSid ?: self.accountSid, sid);
    }
    # Update a Key with the specified parameters
    # 
    # + sid - The Twilio-provided string that uniquely identifies the Key resource to update.
    # + payload - You must provide a `UpdateKeyRequest` record as a payload to update a key.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resources to update.
    # + return - OK 
    remote isolated function updateKey(string sid, UpdateKeyRequest payload, string? accountSid = ()) returns Key|error {
        return self.generatedClient->updateKey(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete a Key resource
    # 
    # + sid - The Twilio-provided string that uniquely identifies the Key resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteKey(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteKey(accountSid ?: self.accountSid, sid);
    }
    # List of Keys resources.
    # 
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Key resources to read.
    # + return - OK 
    remote isolated function listKey(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListKeyResponse|error {
        return self.generatedClient->listKey(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Create a Key for the account.
    # 
    # + payload - You must provide a `CreateKeyRequest` record as a payload to create a key.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will be responsible for the new Key resource.
    # + return - Created 
    remote isolated function createNewKey(CreateNewKeyRequest payload, string? accountSid = ()) returns New_key|error {
        return self.generatedClient->createNewKey(accountSid ?: self.accountSid, payload);
    }
    # Fetch a single Media resource associated with a specific Message resource
    #
    # + messageSid - The SID of the Message resource that is associated with the Media resource.
    # + sid - The Twilio-provided string that uniquely identifies the Media resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Media resource.
    # + return - OK 
    remote isolated function fetchMedia(string messageSid, string sid, string? accountSid = ()) returns MessageMedia|error {
        return self.generatedClient->fetchMedia(accountSid ?: self.accountSid, messageSid, sid);
    }
    # Delete the Media resource.
    #
    # + messageSid - The SID of the Message resource that is associated with the Media resource.
    # + sid - The unique identifier of the to-be-deleted Media resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is associated with the Media resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteMedia(string messageSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteMedia(accountSid ?: self.accountSid, messageSid, sid);
    }
    # Read a list of Media resources associated with a specific Message resource
    #
    # + messageSid - The SID of the Message resource that is associated with the Media resources.
    # + dateCreated - Only include Media resources that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read Media that were created on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read Media that were created on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read Media that were created on or after midnight of this date.
    # + dateCreatedOnOrBefore - Only include Media resources that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read Media that were created on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read Media that were created on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read Media that were created on or after midnight of this date.
    # + dateCreatedOnOrAfter - Only include Media resources that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read Media that were created on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read Media that were created on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read Media that were created on or after midnight of this date.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is associated with the Media resources.
    # + return - OK 
    remote isolated function listMedia(string messageSid, string? dateCreated = (), string? dateCreatedOnOrBefore = (), string? dateCreatedOnOrAfter = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListMediaResponse|error {
        return self.generatedClient->listMedia(accountSid ?: self.accountSid, messageSid, dateCreated, dateCreatedOnOrBefore, dateCreatedOnOrAfter, pageSize, page, pageToken);
    }
    # Fetch a specific member from the queue
    #
    # + queueSid - The SID of the Queue in which to find the members to fetch.
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource(s) to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Member resource(s) to fetch.
    # + return - OK 
    remote isolated function fetchMember(string queueSid, string callSid, string? accountSid = ()) returns QueueMember|error {
        return self.generatedClient->fetchMember(accountSid ?: self.accountSid, queueSid, callSid);
    }
    # Dequeue a member from a queue and have the member's call begin executing the TwiML document at that URL
    #
    # + queueSid - The SID of the Queue in which to find the members to update.
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resource(s) to update.
    # + payload - You must provide a `UpdateMemberRequest` record as a payload to update a member.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Member resource(s) to update.
    # + return - OK 
    remote isolated function updateMember(string queueSid, string callSid, UpdateMemberRequest payload, string? accountSid = ()) returns QueueMember|error {
        return self.generatedClient->updateMember(accountSid ?: self.accountSid, queueSid, callSid, payload);
    }
    # Retrieve the members of the queue
    #
    # + queueSid - The SID of the Queue in which to find the members
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Member resource(s) to read.
    # + return - OK 
    remote isolated function listMember(string queueSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListMemberResponse|error {
        return self.generatedClient->listMember(accountSid ?: self.accountSid, queueSid, pageSize, page, pageToken);
    }
    # Retrieve a list of Message resources associated with a Twilio Account
    #
    # + to - Filter by recipient. For example: Set this `to` parameter to `+15558881111` to retrieve a list of Message resources with `to` properties of `+15558881111`
    # + 'from - Filter by sender. For example: Set this `from` parameter to `+15552229999` to retrieve a list of Message resources with `from` properties of `+15552229999`
    # + dateSent - Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date).
    # + dateSentOnOrBefore - Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date).
    # + dateSentOnOrAfter - Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date).
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resources.
    # + return - OK 
    remote isolated function listMessage(string? to = (), string? 'from = (), string? dateSent = (), string? dateSentOnOrBefore = (), string? dateSentOnOrAfter = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListMessageResponse|error {
        return self.generatedClient->listMessage(accountSid ?: self.accountSid, to, 'from, dateSent, dateSentOnOrBefore, dateSentOnOrAfter, pageSize, page, pageToken);
    }
    # Send a message
    #
    # + payload - You must provide a `CreateMessageRequest` record as a payload to send a message.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) creating the Message resource.
    # + return - Created 
    remote isolated function createMessage(CreateMessageRequest payload, string? accountSid = ()) returns Message|error {
        return self.generatedClient->createMessage(accountSid ?: self.accountSid, payload);
    }
    # Fetch a specific Message
    #
    # + sid - The SID of the Message resource to be fetched
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource
    # + return - OK 
    remote isolated function fetchMessage(string sid, string? accountSid = ()) returns Message|error {
        return self.generatedClient->fetchMessage(accountSid ?: self.accountSid, sid);
    }
    # Update a Message resource (used to redact Message `body` text and to cancel not-yet-sent messages)
    #
    # + sid - The SID of the Message resource to be updated.
    # + payload - You must provide a `UpdateMessageRequest` record as a payload to update a message.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Message resources to update.
    # + return - OK 
    remote isolated function updateMessage(string sid, UpdateMessageRequest payload, string? accountSid = ()) returns Message|error {
        return self.generatedClient->updateMessage(accountSid ?: self.accountSid, sid, payload);
    }
    # Deletes a Message resource from your account
    #
    # + sid - The SID of the Message resource you wish to delete
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource
    # + return - The resource was deleted successfully. 
    remote isolated function deleteMessage(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteMessage(accountSid ?: self.accountSid, sid);
    }
    # Create Message Feedback to confirm a tracked user action was performed by the recipient of the associated Message
    #
    # + messageSid - The SID of the Message resource for which to create MessageFeedback.
    # + payload - You must provide a `CreateMessageFeedbackRequest` record as a payload to create MessageFeedback.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource for which to create MessageFeedback.
    # + return - Created 
    remote isolated function createMessageFeedback(string messageSid, CreateMessageFeedbackRequest payload, string? accountSid = ()) returns MessageMessage_feedback|error {
        return self.generatedClient->createMessageFeedback(accountSid ?: self.accountSid, messageSid, payload);
    }
    # Fetch a specific MessageFeedback
    # 
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource for which to create MessageFeedback.
    # + return - OK 
    remote isolated function listSigningKey(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSigningKeyResponse|error {
        return self.generatedClient->listSigningKey(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Create a new Signing Key for the account making the request.
    #
    # + payload - You must provide a `CreateNewSigningKeyRequest` record as a payload to create a signing key.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will be responsible for the new Key resource.
    # + return - Created 
    remote isolated function createNewSigningKey(CreateNewSigningKeyRequest payload, string? accountSid = ()) returns New_signing_key|error {
        return self.generatedClient->createNewSigningKey(accountSid ?: self.accountSid, payload);
    }
    # Fetch a notification belonging to the account used to make the request
    #
    # + sid - The Twilio-provided string that uniquely identifies the Notification resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Notification resource to fetch.
    # + return - OK 
    remote isolated function fetchNotification(string sid, string? accountSid = ()) returns NotificationInstance|error {
        return self.generatedClient->fetchNotification(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of notifications belonging to the account used to make the request
    #
    # + log - Only read notifications of the specified log level. Can be:  `0` to read only ERROR notifications or `1` to read only WARNING notifications. By default, all notifications are read.
    # + messageDate - Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    # + loggedAtOrBefore - Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    # + loggedAtOrAfter - Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Notification resources to read.
    # + return - OK 
    remote isolated function listNotification(int? log = (), string? messageDate = (), string? loggedAtOrBefore = (), string? loggedAtOrAfter = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListNotificationResponse|error {
        return self.generatedClient->listNotification(accountSid ?: self.accountSid, log, messageDate, loggedAtOrBefore, loggedAtOrAfter, pageSize, page, pageToken);
    }
    # Fetch an outgoing-caller-id belonging to the account used to make the request
    #
    # + sid - The Twilio-provided string that uniquely identifies the OutgoingCallerId resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resource to fetch.
    # + return - OK 
    remote isolated function fetchOutgoingCallerId(string sid, string? accountSid = ()) returns Outgoing_caller_id|error {
        return self.generatedClient->fetchOutgoingCallerId(accountSid ?: self.accountSid, sid);
    }
    # Updates the caller-id
    #
    # + sid - The Twilio-provided string that uniquely identifies the OutgoingCallerId resource to update.
    # + payload - You must provide a `UpdateOutgoingCallerIdRequest` record as a payload to update an outgoing caller id.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resources to update.
    # + return - OK 
    remote isolated function updateOutgoingCallerId(string sid, UpdateOutgoingCallerIdRequest payload, string? accountSid = ()) returns Outgoing_caller_id|error {
        return self.generatedClient->updateOutgoingCallerId(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete the caller-id specified from the account
    #
    # + sid - The Twilio-provided string that uniquely identifies the OutgoingCallerId resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteOutgoingCallerId(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteOutgoingCallerId(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of outgoing-caller-ids belonging to the account used to make the request
    #
    # + phoneNumber - The phone number of the OutgoingCallerId resources to read.
    # + friendlyName - The string that identifies the OutgoingCallerId resources to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resources to read.
    # + return - OK 
    remote isolated function listOutgoingCallerId(string? phoneNumber = (), string? friendlyName = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListOutgoingCallerIdResponse|error {
        return self.generatedClient->listOutgoingCallerId(accountSid ?: self.accountSid, phoneNumber, friendlyName, pageSize, page, pageToken);
    }
    # Create a new outgoing-caller-id for the account.
    # 
    # + payload - You must provide a `CreateOutgoingCallerIdRequest` record as a payload to create an outgoing caller id.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for the new caller ID resource.
    # + return - Created 
    remote isolated function createValidationRequest(CreateValidationRequest payload, string? accountSid = ()) returns Validation_request|error {
        return self.generatedClient->createValidationRequest(accountSid ?: self.accountSid, payload);
    }
    # Fetch an instance of a participant
    #
    # + conferenceSid - The SID of the conference with the participant to fetch.
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID or label of the participant to fetch. Non URL safe characters in a label must be percent encoded, for example, a space character is represented as %20.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resource to fetch.
    # + return - OK 
    remote isolated function fetchParticipant(string conferenceSid, string callSid, string? accountSid = ()) returns ConferenceParticipant|error {
        return self.generatedClient->fetchParticipant(accountSid ?: self.accountSid, conferenceSid, callSid);
    }
    # Update the properties of the participant
    #
    # + conferenceSid - The SID of the conference with the participant to update.
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID or label of the participant to update. Non URL safe characters in a label must be percent encoded, for example, a space character is represented as %20.
    # + payload - You must provide a `UpdateParticipantRequest` record as a payload to update a participant. 
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resources to update.
    # + return - OK 
    remote isolated function updateParticipant(string conferenceSid, string callSid, UpdateParticipantRequest payload, string? accountSid = ()) returns ConferenceParticipant|error {
        return self.generatedClient->updateParticipant(accountSid ?: self.accountSid, conferenceSid, callSid, payload);
    }
    # Kick a participant from a given conference
    #
    # + conferenceSid - The SID of the conference with the participants to delete.
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID or label of the participant to delete. Non URL safe characters in a label must be percent encoded, for example, a space character is represented as %20.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteParticipant(string conferenceSid, string callSid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteParticipant(accountSid ?: self.accountSid, conferenceSid, callSid);
    }
    # Retrieve a list of participants belonging to the account used to make the request
    #
    # + conferenceSid - The SID of the conference with the participants to read.
    # + muted - Whether to return only participants that are muted. Can be: `true` or `false`.
    # + hold - Whether to return only participants that are on hold. Can be: `true` or `false`.
    # + coaching - Whether to return only participants who are coaching another call. Can be: `true` or `false`.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resources to read.
    # + return - OK 
    remote isolated function listParticipant(string conferenceSid, boolean? muted = (), boolean? hold = (), boolean? coaching = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListParticipantResponse|error {
        return self.generatedClient->listParticipant(accountSid ?: self.accountSid, conferenceSid, muted, hold, coaching, pageSize, page, pageToken);
    }
    # Create a participant in a conference
    # 
    # + conferenceSid - The SID of the participant's conference.
    # + payload - You must provide a `CreateParticipantRequest` record as a payload to create a participant.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createParticipant(string conferenceSid, CreateParticipantRequest payload, string? accountSid = ()) returns ConferenceParticipant|error {
        return self.generatedClient->createParticipant(accountSid ?: self.accountSid, conferenceSid, payload);
    }
    # create an instance of payments. This will start a new payments session
    #
    # + callSid - The SID of the call that will create the resource. Call leg associated with this sid is expected to provide payment information thru DTMF.
    # + payload - You must provide a `CreatePaymentsRequest` record as a payload to create a payments resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createPayments(string callSid, CreatePaymentsRequest payload, string? accountSid = ()) returns CallPayments|error {
        return self.generatedClient->createPayments(accountSid ?: self.accountSid, callSid, payload);
    }
    # update an instance of payments with different phases of payment flows.
    #
    # + callSid - The SID of the call that will update the resource. This should be the same call sid that was used to create payments resource.
    # + sid - The SID of Payments session that needs to be updated.
    # + payload - You must provide a `UpdatePaymentsRequest` record as a payload to update a payments resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will update the resource.
    # + return - Accepted 
    remote isolated function updatePayments(string callSid, string sid, UpdatePaymentsRequest payload, string? accountSid = ()) returns CallPayments|error {
        return self.generatedClient->updatePayments(accountSid ?: self.accountSid, callSid, sid, payload);
    }
    # Fetch an instance of a queue identified by the QueueSid
    #
    # + sid - The Twilio-provided string that uniquely identifies the Queue resource to fetch
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to fetch.
    # + return - OK 
    remote isolated function fetchQueue(string sid, string? accountSid = ()) returns Queue|error {
        return self.generatedClient->fetchQueue(accountSid ?: self.accountSid, sid);
    }
    # Update the queue with the new parameters
    #
    # + sid - The Twilio-provided string that uniquely identifies the Queue resource to update
    # + payload - You must provide a `UpdateQueueRequest` record as a payload to update a queue.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to update.
    # + return - OK 
    remote isolated function updateQueue(string sid, UpdateQueueRequest payload, string? accountSid = ()) returns Queue|error {
        return self.generatedClient->updateQueue(accountSid ?: self.accountSid, sid, payload);
    }
    # Remove an empty queue
    #
    # + sid - The Twilio-provided string that uniquely identifies the Queue resource to delete
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteQueue(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteQueue(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of queues belonging to the account used to make the request
    #
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resources to read.
    # + return - OK 
    remote isolated function listQueue(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListQueueResponse|error {
        return self.generatedClient->listQueue(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Create a queue
    #
    # + payload - You must provide a `CreateQueueRequest` record as a payload to create a queue.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createQueue(CreateQueueRequest payload, string? accountSid = ()) returns Queue|error {
        return self.generatedClient->createQueue(accountSid ?: self.accountSid, payload);
    }
    # Fetch an instance of a recording
    #
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to fetch.
    # + includeSoftDeleted - A boolean parameter indicating whether to retrieve soft deleted recordings or not. Recordings metadata are kept after deletion for a retention period of 40 days.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource to fetch.
    # + return - OK 
    remote isolated function fetchRecording(string sid, boolean? includeSoftDeleted = (), string? accountSid = ()) returns Recording|error {
        return self.generatedClient->fetchRecording(accountSid ?: self.accountSid, sid, includeSoftDeleted);
    }
    # Delete a recording from your account
    #
    # + sid - The Twilio-provided string that uniquely identifies the Recording resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteRecording(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteRecording(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of recordings belonging to the account used to make the request
    #
    # + dateCreated - Only include recordings that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read recordings that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read recordings that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read recordings that were created on or after midnight of this date.
    # + dateCreatedOnOrBefore - Only include recordings that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read recordings that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read recordings that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read recordings that were created on or after midnight of this date.
    # + dateCreatedOnOrAfter - Only include recordings that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read recordings that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read recordings that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read recordings that were created on or after midnight of this date.
    # + callSid - The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resources to read.
    # + conferenceSid - The Conference SID that identifies the conference associated with the recording to read.
    # + includeSoftDeleted - A boolean parameter indicating whether to retrieve soft deleted recordings or not. Recordings metadata are kept after deletion for a retention period of 40 days.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resources to read.
    # + return - OK 
    remote isolated function listRecording(string? dateCreated = (), string? dateCreatedOnOrBefore = (), string? dateCreatedOnOrAfter = (), string? callSid = (), string? conferenceSid = (), boolean? includeSoftDeleted = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListRecordingResponse|error {
        return self.generatedClient->listRecording(accountSid ?: self.accountSid, dateCreated, dateCreatedOnOrBefore, dateCreatedOnOrAfter, callSid, conferenceSid, includeSoftDeleted, pageSize, page, pageToken);
    }
    # Fetch an instance of an AddOnResult
    #
    # + referenceSid - The SID of the recording to which the result to fetch belongs.
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult resource to fetch.
    # + return - OK 
    remote isolated function fetchRecordingAddOnResult(string referenceSid, string sid, string? accountSid = ()) returns RecordingRecording_add_on_result|error {
        return self.generatedClient->fetchRecordingAddOnResult(accountSid ?: self.accountSid, referenceSid, sid);
    }
    # Delete a result and purge all associated Payloads
    #
    # + referenceSid - The SID of the recording to which the result to delete belongs.
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteRecordingAddOnResult(string referenceSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteRecordingAddOnResult(accountSid ?: self.accountSid, referenceSid, sid);
    }
    # Retrieve a list of results belonging to the recording
    #
    # + referenceSid - The SID of the recording to which the result to read belongs.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult resources to read.
    # + return - OK 
    remote isolated function listRecordingAddOnResult(string referenceSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListRecordingAddOnResultResponse|error {
        return self.generatedClient->listRecordingAddOnResult(accountSid ?: self.accountSid, referenceSid, pageSize, page, pageToken);
    }
    # Fetch an instance of a result payload
    #
    # + referenceSid - The SID of the recording to which the AddOnResult resource that contains the payload to fetch belongs.
    # + addOnResultSid - The SID of the AddOnResult to which the payload to fetch belongs.
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult Payload resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resource to fetch.
    # + return - OK 
    remote isolated function fetchRecordingAddOnResultPayload(string referenceSid, string addOnResultSid, string sid, string? accountSid = ()) returns RecordingRecording_add_on_resultRecording_add_on_result_payload|error {
        return self.generatedClient->fetchRecordingAddOnResultPayload(accountSid ?: self.accountSid, referenceSid, addOnResultSid, sid);
    }
    # Delete a payload from the result along with all associated Data
    #
    # + referenceSid - The SID of the recording to which the AddOnResult resource that contains the payloads to delete belongs.
    # + addOnResultSid - The SID of the AddOnResult to which the payloads to delete belongs.
    # + sid - The Twilio-provided string that uniquely identifies the Recording AddOnResult Payload resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteRecordingAddOnResultPayload(string referenceSid, string addOnResultSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteRecordingAddOnResultPayload(accountSid ?: self.accountSid, referenceSid, addOnResultSid, sid);
    }
    # Retrieve a list of payloads belonging to the AddOnResult
    #
    # + referenceSid - The SID of the recording to which the AddOnResult resource that contains the payloads to read belongs.
    # + addOnResultSid - The SID of the AddOnResult to which the payloads to read belongs.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resources to read.
    # + return - OK 
    remote isolated function listRecordingAddOnResultPayload(string referenceSid, string addOnResultSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListRecordingAddOnResultPayloadResponse|error {
        return self.generatedClient->listRecordingAddOnResultPayload(accountSid ?: self.accountSid, referenceSid, addOnResultSid, pageSize, page, pageToken);
    }
    # Fetch an instance of a recording transcription
    # 
    # + recordingSid - The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcription to fetch.
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resource to fetch.
    # + return - OK 
    remote isolated function fetchRecordingTranscription(string recordingSid, string sid, string? accountSid = ()) returns RecordingRecording_transcription|error {
        return self.generatedClient->fetchRecordingTranscription(accountSid ?: self.accountSid, recordingSid, sid);
    }
    # Delete a transcription from your account
    # 
    # + recordingSid - The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcription to delete.
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteRecordingTranscription(string recordingSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteRecordingTranscription(accountSid ?: self.accountSid, recordingSid, sid);
    }
    # Retrieve a list of transcriptions belonging to the recording
    # 
    # + recordingSid - The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcriptions to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to read.
    # + return - OK 
    remote isolated function listRecordingTranscription(string recordingSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListRecordingTranscriptionResponse|error {
        return self.generatedClient->listRecordingTranscription(accountSid ?: self.accountSid, recordingSid, pageSize, page, pageToken);
    }
    # Fetch an instance of a short code
    #
    # + sid - The Twilio-provided string that uniquely identifies the ShortCode resource to fetch
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to fetch.
    # + return - OK 
    remote isolated function fetchShortCode(string sid, string? accountSid = ()) returns Short_code|error {
        return self.generatedClient->fetchShortCode(accountSid ?: self.accountSid, sid);
    }
    # Update a short code with the following parameters
    #
    # + sid - The Twilio-provided string that uniquely identifies the ShortCode resource to update.
    # + payload - You must provide a `UpdateShortCodeRequest` record as a payload to update a short code.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to update.
    # + return - OK 
    remote isolated function updateShortCode(string sid, UpdateShortCodeRequest payload, string? accountSid = ()) returns Short_code|error {
        return self.generatedClient->updateShortCode(accountSid ?: self.accountSid, sid, payload);
    }
    # Retrieve a list of short-codes belonging to the account used to make the request
    #
    # + friendlyName - The string that identifies the ShortCode resources to read.
    # + shortCode - Only show the ShortCode resources that match this pattern. You can specify partial numbers and use '*' as a wildcard for any digit.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to read.
    # + return - OK 
    remote isolated function listShortCode(string? friendlyName = (), string? shortCode = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListShortCodeResponse|error {
        return self.generatedClient->listShortCode(accountSid ?: self.accountSid, friendlyName, shortCode, pageSize, page, pageToken);
    }
    # Create a short code
    # 
    # + sid - The Twilio-provided string that uniquely identifies the ShortCode resource to update.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to update.
    # + return - OK 
    remote isolated function fetchSigningKey(string sid, string? accountSid = ()) returns Signing_key|error {
        return self.generatedClient->fetchSigningKey(accountSid ?: self.accountSid, sid);
    }
    # Update a signing key with the following parameters
    # 
    # + sid - The Twilio-provided string that uniquely identifies the SigningKey resource to update.
    # + payload - You must provide a `UpdateSigningKeyRequest` record as a payload to update a signing key.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SigningKey resource(s) to update.
    # + return - OK 
    remote isolated function updateSigningKey(string sid, UpdateSigningKeyRequest payload, string? accountSid = ()) returns Signing_key|error {
        return self.generatedClient->updateSigningKey(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete a signing key from the account
    # 
    # + sid - The Twilio-provided string that uniquely identifies the SigningKey resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SigningKey resource(s) to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSigningKey(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSigningKey(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of credential list mappings belonging to the domain used in the request
    #
    # + domainSid - The SID of the SIP domain that contains the resources to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to read.
    # + return - OK 
    remote isolated function listSipAuthCallsCredentialListMapping(string domainSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipAuthCallsCredentialListMappingResponse|error {
        return self.generatedClient->listSipAuthCallsCredentialListMapping(accountSid ?: self.accountSid, domainSid, pageSize, page, pageToken);
    }
    # Create a new credential list mapping resource
    #
    # + domainSid - The SID of the SIP domain that will contain the new resource.
    # + payload - You must provide a `CreateSipAuthCallsCredentialListMappingRequest` record as a payload to create a credential list mapping.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createSipAuthCallsCredentialListMapping(string domainSid, CreateSipAuthCallsCredentialListMappingRequest payload, string? accountSid = ()) returns SipSip_domainSip_authSip_auth_callsSip_auth_calls_credential_list_mapping|error {
        return self.generatedClient->createSipAuthCallsCredentialListMapping(accountSid ?: self.accountSid, domainSid, payload);
    }
    # Fetch a specific instance of a credential list mapping
    #
    # + domainSid - The SID of the SIP domain that contains the resource to fetch.
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resource to fetch.
    # + return - OK 
    remote isolated function fetchSipAuthCallsCredentialListMapping(string domainSid, string sid, string? accountSid = ()) returns SipSip_domainSip_authSip_auth_callsSip_auth_calls_credential_list_mapping|error {
        return self.generatedClient->fetchSipAuthCallsCredentialListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Delete a credential list mapping from the requested domain
    #
    # + domainSid - The SID of the SIP domain that contains the resource to delete.
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipAuthCallsCredentialListMapping(string domainSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipAuthCallsCredentialListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Retrieve a list of IP Access Control List mappings belonging to the domain used in the request
    #
    # + domainSid - The SID of the SIP domain that contains the resources to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IpAccessControlListMapping resources to read.
    # + return - OK 
    remote isolated function listSipAuthCallsIpAccessControlListMapping(string domainSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipAuthCallsIpAccessControlListMappingResponse|error {
        return self.generatedClient->listSipAuthCallsIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, pageSize, page, pageToken);
    }
    # Create a new IP Access Control List mapping
    #
    # + domainSid - The SID of the SIP domain that will contain the new resource.
    # + payload - You must provide a `CreateSipAuthCallsIpAccessControlListMappingRequest` record as a payload to create a IP Access Control List mapping.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createSipAuthCallsIpAccessControlListMapping(string domainSid, CreateSipAuthCallsIpAccessControlListMappingRequest payload, string? accountSid = ()) returns SipSip_domainSip_authSip_auth_callsSip_auth_calls_ip_access_control_list_mapping|error {
        return self.generatedClient->createSipAuthCallsIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, payload);
    }
    # Fetch a specific instance of an IP Access Control List mapping
    #
    # + domainSid - The SID of the SIP domain that contains the resource to fetch.
    # + sid - The Twilio-provided string that uniquely identifies the IpAccessControlListMapping resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IpAccessControlListMapping resource to fetch.
    # + return - OK 
    remote isolated function fetchSipAuthCallsIpAccessControlListMapping(string domainSid, string sid, string? accountSid = ()) returns SipSip_domainSip_authSip_auth_callsSip_auth_calls_ip_access_control_list_mapping|error {
        return self.generatedClient->fetchSipAuthCallsIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Delete an IP Access Control List mapping from the requested domain
    #
    # + domainSid - The SID of the SIP domain that contains the resources to delete.
    # + sid - The Twilio-provided string that uniquely identifies the IpAccessControlListMapping resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IpAccessControlListMapping resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipAuthCallsIpAccessControlListMapping(string domainSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipAuthCallsIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Retrieve a list of credential list mappings belonging to the domain used in the request
    #
    # + domainSid - The SID of the SIP domain that contains the resources to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to read.
    # + return - OK 
    remote isolated function listSipAuthRegistrationsCredentialListMapping(string domainSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipAuthRegistrationsCredentialListMappingResponse|error {
        return self.generatedClient->listSipAuthRegistrationsCredentialListMapping(accountSid ?: self.accountSid, domainSid, pageSize, page, pageToken);
    }
    # Create a new credential list mapping resource
    #
    # + domainSid - The SID of the SIP domain that will contain the new resource.
    # + payload - You must provide a `CreateSipAuthRegistrationsCredentialListMappingRequest` record as a payload to create a credential list mapping.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createSipAuthRegistrationsCredentialListMapping(string domainSid, CreateSipAuthRegistrationsCredentialListMappingRequest payload, string? accountSid = ()) returns SipSip_domainSip_authSip_auth_registrationsSip_auth_registrations_credential_list_mapping|error {
        return self.generatedClient->createSipAuthRegistrationsCredentialListMapping(accountSid ?: self.accountSid, domainSid, payload);
    }
    # Fetch a specific instance of a credential list mapping
    #
    # + domainSid - The SID of the SIP domain that contains the resource to fetch.
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resource to fetch.
    # + return - OK 
    remote isolated function fetchSipAuthRegistrationsCredentialListMapping(string domainSid, string sid, string? accountSid = ()) returns SipSip_domainSip_authSip_auth_registrationsSip_auth_registrations_credential_list_mapping|error {
        return self.generatedClient->fetchSipAuthRegistrationsCredentialListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Delete a credential list mapping from the requested domain
    #
    # + domainSid - The SID of the SIP domain that contains the resources to delete.
    # + sid - The Twilio-provided string that uniquely identifies the CredentialListMapping resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipAuthRegistrationsCredentialListMapping(string domainSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipAuthRegistrationsCredentialListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Retrieve a list of credentials.
    #
    # + credentialListSid - The unique id that identifies the credential list that contains the desired credentials.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function listSipCredential(string credentialListSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipCredentialResponse|error {
        return self.generatedClient->listSipCredential(accountSid ?: self.accountSid, credentialListSid, pageSize, page, pageToken);
    }
    # Create a new credential resource.
    #
    # + credentialListSid - The unique id that identifies the credential list to include the created credential.
    # + payload - You must provide a `CreateSipCredentialRequest` record as a payload to create a credential.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - Created 
    remote isolated function createSipCredential(string credentialListSid, CreateSipCredentialRequest payload, string? accountSid = ()) returns SipSip_credential_listSip_credential|error {
        return self.generatedClient->createSipCredential(accountSid ?: self.accountSid, credentialListSid, payload);
    }
    # Fetch a single credential.
    #
    # + credentialListSid - The unique id that identifies the credential list that contains the desired credential.
    # + sid - The unique id that identifies the resource to fetch.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function fetchSipCredential(string credentialListSid, string sid, string? accountSid = ()) returns SipSip_credential_listSip_credential|error {
        return self.generatedClient->fetchSipCredential(accountSid ?: self.accountSid, credentialListSid, sid);
    }
    # Update a credential resource.
    #
    # + credentialListSid - The unique id that identifies the credential list that includes this credential.
    # + sid - The unique id that identifies the resource to update.
    # + payload - You must provide a `UpdateSipCredentialRequest` record as a payload to update a credential.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function updateSipCredential(string credentialListSid, string sid, UpdateSipCredentialRequest payload, string? accountSid = ()) returns SipSip_credential_listSip_credential|error {
        return self.generatedClient->updateSipCredential(accountSid ?: self.accountSid, credentialListSid, sid, payload);
    }
    # Delete a credential resource.
    #
    # + credentialListSid - The unique id that identifies the credential list that contains the desired credentials.
    # + sid - The unique id that identifies the resource to delete.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipCredential(string credentialListSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipCredential(accountSid ?: self.accountSid, credentialListSid, sid);
    }
    # Get All Credential Lists
    #
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function listSipCredentialList(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipCredentialListResponse|error {
        return self.generatedClient->listSipCredentialList(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Create a Credential List
    #
    # + payload - You must provide a `CreateSipCredentialListRequest` record as a payload to create a credential list.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - Created 
    remote isolated function createSipCredentialList(CreateSipCredentialListRequest payload, string? accountSid = ()) returns SipSip_credential_list|error {
        return self.generatedClient->createSipCredentialList(accountSid ?: self.accountSid, payload);
    }
    # Get a Credential List
    #
    # + sid - The credential list Sid that uniquely identifies this resource.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function fetchSipCredentialList(string sid, string? accountSid = ()) returns SipSip_credential_list|error {
        return self.generatedClient->fetchSipCredentialList(accountSid ?: self.accountSid, sid);
    }
    # Update a Credential List
    #
    # + sid - The credential list Sid that uniquely identifies this resource.
    # + payload - You must provide a `UpdateSipCredentialListRequest` record as a payload to update a credential list.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function updateSipCredentialList(string sid, UpdateSipCredentialListRequest payload, string? accountSid = ()) returns SipSip_credential_list|error {
        return self.generatedClient->updateSipCredentialList(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete a Credential List
    #
    # + sid - The credential list Sid that uniquely identifies this resource.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipCredentialList(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipCredentialList(accountSid ?: self.accountSid, sid);
    }
    # Read multiple CredentialListMapping resources from an account.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain that includes the resource to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function listSipCredentialListMapping(string domainSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipCredentialListMappingResponse|error {
        return self.generatedClient->listSipCredentialListMapping(accountSid ?: self.accountSid, domainSid, pageSize, page, pageToken);
    }
    # Create a CredentialListMapping resource for an account.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain for which the CredentialList resource will be mapped.
    # + payload - You must provide a `CreateSipCredentialListMappingRequest` record as a payload to create a CredentialListMapping resource.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - Created 
    remote isolated function createSipCredentialListMapping(string domainSid, CreateSipCredentialListMappingRequest payload, string? accountSid = ()) returns SipSip_domainSip_credential_list_mapping|error {
        return self.generatedClient->createSipCredentialListMapping(accountSid ?: self.accountSid, domainSid, payload);
    }
    # Fetch a single CredentialListMapping resource from an account.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain that includes the resource to fetch.
    # + sid - A 34 character string that uniquely identifies the resource to fetch.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function fetchSipCredentialListMapping(string domainSid, string sid, string? accountSid = ()) returns SipSip_domainSip_credential_list_mapping|error {
        return self.generatedClient->fetchSipCredentialListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Delete a CredentialListMapping resource from an account.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP Domain that includes the resource to delete.
    # + sid - A 34 character string that uniquely identifies the resource to delete.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipCredentialListMapping(string domainSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipCredentialListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Retrieve a list of domains belonging to the account used to make the request
    #
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resources to read.
    # + return - OK 
    remote isolated function listSipDomain(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipDomainResponse|error {
        return self.generatedClient->listSipDomain(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Create a new Domain
    #
    # + payload - You must provide a `CreateSipDomainRequest` record as a payload to create a domain.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createSipDomain(CreateSipDomainRequest payload, string? accountSid = ()) returns SipSip_domain|error {
        return self.generatedClient->createSipDomain(accountSid ?: self.accountSid, payload);
    }
    # Fetch an instance of a Domain
    #
    # + sid - The Twilio-provided string that uniquely identifies the SipDomain resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resource to fetch.
    # + return - OK 
    remote isolated function fetchSipDomain(string sid, string? accountSid = ()) returns SipSip_domain|error {
        return self.generatedClient->fetchSipDomain(accountSid ?: self.accountSid, sid);
    }
    # Update the attributes of a domain
    #
    # + sid - The Twilio-provided string that uniquely identifies the SipDomain resource to update.
    # + payload - You must provide a `UpdateSipDomainRequest` record as a payload to update a domain.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resource to update.
    # + return - OK 
    remote isolated function updateSipDomain(string sid, UpdateSipDomainRequest payload, string? accountSid = ()) returns SipSip_domain|error {
        return self.generatedClient->updateSipDomain(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete an instance of a Domain
    #
    # + sid - The Twilio-provided string that uniquely identifies the SipDomain resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipDomain(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipDomain(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of IpAccessControlLists that belong to the account used to make the request
    #
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function listSipIpAccessControlList(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipIpAccessControlListResponse|error {
        return self.generatedClient->listSipIpAccessControlList(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Create a new IpAccessControlList resource
    #
    # + payload - You must provide a `CreateSipIpAccessControlListRequest` record as a payload to create an IpAccessControlList.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - Created 
    remote isolated function createSipIpAccessControlList(CreateSipIpAccessControlListRequest payload, string? accountSid = ()) returns SipSip_ip_access_control_list|error {
        return self.generatedClient->createSipIpAccessControlList(accountSid ?: self.accountSid, payload);
    }
    # Fetch a specific instance of an IpAccessControlList
    #
    # + sid - A 34 character string that uniquely identifies the resource to fetch.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function fetchSipIpAccessControlList(string sid, string? accountSid = ()) returns SipSip_ip_access_control_list|error {
        return self.generatedClient->fetchSipIpAccessControlList(accountSid ?: self.accountSid, sid);
    }
    # Rename an IpAccessControlList
    #
    # + sid - A 34 character string that uniquely identifies the resource to udpate.
    # + payload - You must provide a `UpdateSipIpAccessControlListRequest` record as a payload to update an IpAccessControlList.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function updateSipIpAccessControlList(string sid, UpdateSipIpAccessControlListRequest payload, string? accountSid = ()) returns SipSip_ip_access_control_list|error {
        return self.generatedClient->updateSipIpAccessControlList(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete an IpAccessControlList from the requested account
    #
    # + sid - A 34 character string that uniquely identifies the resource to delete.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipIpAccessControlList(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipIpAccessControlList(accountSid ?: self.accountSid, sid);
    }
    # Fetch an IpAccessControlListMapping resource.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP domain.
    # + sid - A 34 character string that uniquely identifies the resource to fetch.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function fetchSipIpAccessControlListMapping(string domainSid, string sid, string? accountSid = ()) returns SipSip_domainSip_ip_access_control_list_mapping|error {
        return self.generatedClient->fetchSipIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Delete an IpAccessControlListMapping resource.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP domain.
    # + sid - A 34 character string that uniquely identifies the resource to delete.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipIpAccessControlListMapping(string domainSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, sid);
    }
    # Retrieve a list of IpAccessControlListMapping resources.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP domain.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - OK 
    remote isolated function listSipIpAccessControlListMapping(string domainSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipIpAccessControlListMappingResponse|error {
        return self.generatedClient->listSipIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, pageSize, page, pageToken);
    }
    # Create a new IpAccessControlListMapping resource.
    #
    # + domainSid - A 34 character string that uniquely identifies the SIP domain.
    # + payload - You must provide a `CreateSipIpAccessControlListMappingRequest` record as a payload to create an IpAccessControlListMapping resource.
    # + accountSid - The unique id of the Account that is responsible for this resource.
    # + return - Created 
    remote isolated function createSipIpAccessControlListMapping(string domainSid, CreateSipIpAccessControlListMappingRequest payload, string? accountSid = ()) returns SipSip_domainSip_ip_access_control_list_mapping|error {
        return self.generatedClient->createSipIpAccessControlListMapping(accountSid ?: self.accountSid, domainSid, payload);
    }
    # Read multiple IpAddress resources.
    #
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to read.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function listSipIpAddress(string ipAccessControlListSid, int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListSipIpAddressResponse|error {
        return self.generatedClient->listSipIpAddress(accountSid ?: self.accountSid, ipAccessControlListSid, pageSize, page, pageToken);
    }
    # Create a new IpAddress resource.
    #
    # + ipAccessControlListSid - The IpAccessControlList Sid with which to associate the created IpAddress resource.
    # + payload - You must provide a `CreateSipIpAddressRequest` record as a payload to create an IpAddress resource.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - Created 
    remote isolated function createSipIpAddress(string ipAccessControlListSid, CreateSipIpAddressRequest payload, string? accountSid = ()) returns SipSip_ip_access_control_listSip_ip_address|error {
        return self.generatedClient->createSipIpAddress(accountSid ?: self.accountSid, ipAccessControlListSid, payload);
    }
    # Read one IpAddress resource.
    #
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to fetch.
    # + sid - A 34 character string that uniquely identifies the IpAddress resource to fetch.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function fetchSipIpAddress(string ipAccessControlListSid, string sid, string? accountSid = ()) returns SipSip_ip_access_control_listSip_ip_address|error {
        return self.generatedClient->fetchSipIpAddress(accountSid ?: self.accountSid, ipAccessControlListSid, sid);
    }
    # Update an IpAddress resource.
    #
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to update.
    # + sid - A 34 character string that identifies the IpAddress resource to update.
    # + payload - You must provide a `UpdateSipIpAddressRequest` record as a payload to update an IpAddress resource.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - OK 
    remote isolated function updateSipIpAddress(string ipAccessControlListSid, string sid, UpdateSipIpAddressRequest payload, string? accountSid = ()) returns SipSip_ip_access_control_listSip_ip_address|error {
        return self.generatedClient->updateSipIpAddress(accountSid ?: self.accountSid, ipAccessControlListSid, sid, payload);
    }
    # Delete an IpAddress resource.
    #
    # + ipAccessControlListSid - The IpAccessControlList Sid that identifies the IpAddress resources to delete.
    # + sid - A 34 character string that uniquely identifies the resource to delete.
    # + accountSid - The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for this resource.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteSipIpAddress(string ipAccessControlListSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteSipIpAddress(accountSid ?: self.accountSid, ipAccessControlListSid, sid);
    }
    # Create a Siprec
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Siprec resource is associated with.
    # + payload - You must provide a `CreateSiprecRequest` record as a payload to create a Siprec.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Siprec resource.
    # + return - Created 
    remote isolated function createSiprec(string callSid, CreateSiprecRequest payload, string? accountSid = ()) returns CallSiprec|error {
        return self.generatedClient->createSiprec(accountSid ?: self.accountSid, callSid, payload);
    }
    # Stop a Siprec using either the SID of the Siprec resource or the `name` used when creating the resource
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Siprec resource is associated with.
    # + sid - The SID of the Siprec resource, or the `name` used when creating the resource.
    # + payload - You must provide a `UpdateSiprecRequest` record as a payload to update a Siprec.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Siprec resource.
    # + return - OK 
    remote isolated function updateSiprec(string callSid, string sid, UpdateSiprecRequest payload, string? accountSid = ()) returns CallSiprec|error {
        return self.generatedClient->updateSiprec(accountSid ?: self.accountSid, callSid, sid, payload);
    }
    # Create a Stream
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Stream resource is associated with.
    # + payload - You must provide a `CreateStreamRequest` record as a payload to create a Stream.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Stream resource.
    # + return - Created 
    remote isolated function createStream(string callSid, CreateStreamRequest payload, string? accountSid = ()) returns CallStream|error {
        return self.generatedClient->createStream(accountSid ?: self.accountSid, callSid, payload);
    }
    # Stop a Stream using either the SID of the Stream resource or the `name` used when creating the resource
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Stream resource is associated with.
    # + sid - The SID of the Stream resource, or the `name` used when creating the resource
    # + payload - You must provide a `UpdateStreamRequest` record as a payload to update a Stream.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Stream resource.
    # + return - OK 
    remote isolated function updateStream(string callSid, string sid, UpdateStreamRequest payload, string? accountSid = ()) returns CallStream|error {
        return self.generatedClient->updateStream(accountSid ?: self.accountSid, callSid, sid, payload);
    }
    # Create a new token for ICE servers
    #
    # + payload - You must provide a `CreateTokenRequest` record as a payload to create a token.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createToken(CreateTokenRequest payload, string? accountSid = ()) returns Token|error {
        return self.generatedClient->createToken(accountSid ?: self.accountSid, payload);
    }
    # Fetch an instance of a Transcription
    #
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resource to fetch.
    # + return - OK 
    remote isolated function fetchTranscription(string sid, string? accountSid = ()) returns Transcription|error {
        return self.generatedClient->fetchTranscription(accountSid ?: self.accountSid, sid);
    }
    # Delete a transcription from the account used to make the request
    #
    # + sid - The Twilio-provided string that uniquely identifies the Transcription resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteTranscription(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteTranscription(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of transcriptions belonging to the account used to make the request
    #
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to read.
    # + return - OK 
    remote isolated function listTranscription(int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListTranscriptionResponse|error {
        return self.generatedClient->listTranscription(accountSid ?: self.accountSid, pageSize, page, pageToken);
    }
    # Retrieve a list of usage-records belonging to the account used to make the request
    #
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecord(Usage_record_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordResponse|error {
        return self.generatedClient->listUsageRecord(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordAllTime(Usage_record_all_time_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordAllTimeResponse|error {
        return self.generatedClient->listUsageRecordAllTime(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of daily usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordDaily(Usage_record_daily_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordDailyResponse|error {
        return self.generatedClient->listUsageRecordDaily(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of last month's usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordLastMonth(Usage_record_last_month_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordLastMonthResponse|error {
        return self.generatedClient->listUsageRecordLastMonth(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of monthly usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordMonthly(Usage_record_monthly_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordMonthlyResponse|error {
        return self.generatedClient->listUsageRecordMonthly(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of this month's usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordThisMonth(Usage_record_this_month_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordThisMonthResponse|error {
        return self.generatedClient->listUsageRecordThisMonth(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of today's usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordToday(Usage_record_today_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordTodayResponse|error {
        return self.generatedClient->listUsageRecordToday(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of yearly usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordYearly(Usage_record_yearly_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordYearlyResponse|error {
        return self.generatedClient->listUsageRecordYearly(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Retrieve a list of yesterday's usage-records belonging to the account used to make the request
    # 
    # + category - The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    # + startDate - Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    # + endDate - Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    # + includeSubaccounts - Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
    # + return - OK 
    remote isolated function listUsageRecordYesterday(Usage_record_yesterday_enum_category? category = (), string? startDate = (), string? endDate = (), boolean? includeSubaccounts = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageRecordYesterdayResponse|error {
        return self.generatedClient->listUsageRecordYesterday(accountSid ?: self.accountSid, category, startDate, endDate, includeSubaccounts, pageSize, page, pageToken);
    }
    # Fetch and instance of a usage-trigger
    #
    # + sid - The Twilio-provided string that uniquely identifies the UsageTrigger resource to fetch.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resource to fetch.
    # + return - OK 
    remote isolated function fetchUsageTrigger(string sid, string? accountSid = ()) returns UsageUsage_trigger|error {
        return self.generatedClient->fetchUsageTrigger(accountSid ?: self.accountSid, sid);
    }
    # Update an instance of a usage trigger
    #
    # + sid - The Twilio-provided string that uniquely identifies the UsageTrigger resource to update.
    # + payload - You must provide a `UpdateUsageTriggerRequest` record as a payload to update a UsageTrigger resource.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resources to update.
    # + return - OK 
    remote isolated function updateUsageTrigger(string sid, UpdateUsageTriggerRequest payload, string? accountSid = ()) returns UsageUsage_trigger|error {
        return self.generatedClient->updateUsageTrigger(accountSid ?: self.accountSid, sid, payload);
    }
    # Delete a usage-trigger from the account used to make the request
    # 
    # + sid - The Twilio-provided string that uniquely identifies the UsageTrigger resource to delete.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resources to delete.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteUsageTrigger(string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteUsageTrigger(accountSid ?: self.accountSid, sid);
    }
    # Retrieve a list of usage-triggers belonging to the account used to make the request
    #
    # + recurring - The frequency of recurring UsageTriggers to read. Can be: `daily`, `monthly`, or `yearly` to read recurring UsageTriggers. An empty value or a value of `alltime` reads non-recurring UsageTriggers.
    # + triggerBy - The trigger field of the UsageTriggers to read.  Can be: `count`, `usage`, or `price` as described in the [UsageRecords documentation](https://www.twilio.com/docs/usage/api/usage-record#usage-count-price).
    # + usageCategory - The usage category of the UsageTriggers to read. Must be a supported [usage categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories).
    # + pageSize - How many resources to return in each list page. The default is 50, and the maximum is 1000.
    # + page - The page index. This value is simply for client state.
    # + pageToken - The page token. This is provided by the API.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageTrigger resources to read.
    # + return - OK 
    remote isolated function listUsageTrigger(Usage_trigger_enum_recurring? recurring = (), Usage_trigger_enum_trigger_field? triggerBy = (), Usage_trigger_enum_usage_category? usageCategory = (), int? pageSize = (), int? page = (), string? pageToken = (), string? accountSid = ()) returns ListUsageTriggerResponse|error {
        return self.generatedClient->listUsageTrigger(accountSid ?: self.accountSid, recurring, triggerBy, usageCategory, pageSize, page, pageToken);
    }
    # Create a new UsageTrigger
    #
    # + payload - You must provide a `CreateUsageTriggerRequest` record as a payload to create a UsageTrigger.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
    # + return - Created 
    remote isolated function createUsageTrigger(CreateUsageTriggerRequest payload, string? accountSid = ()) returns UsageUsage_trigger|error {
        return self.generatedClient->createUsageTrigger(accountSid ?: self.accountSid, payload);
    }
    # Create a new User Defined Message for the given Call SID.
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Message is associated with.
    # + payload - You must provide a `CreateUserDefinedMessageRequest` record as a payload to create a User Defined Message.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created User Defined Message.
    # + return - Created 
    remote isolated function createUserDefinedMessage(string callSid, CreateUserDefinedMessageRequest payload, string? accountSid = ()) returns CallUser_defined_message|error {
        return self.generatedClient->createUserDefinedMessage(accountSid ?: self.accountSid, callSid, payload);
    }
    # Subscribe to User Defined Messages for a given Call SID.
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Messages subscription is associated with. This refers to the Call SID that is producing the user defined messages.
    # + payload - You must provide a `CreateUserDefinedMessageSubscriptionRequest` record as a payload to create a User Defined Message Subscription.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that subscribed to the User Defined Messages.
    # + return - Created 
    remote isolated function createUserDefinedMessageSubscription(string callSid, CreateUserDefinedMessageSubscriptionRequest payload, string? accountSid = ()) returns CallUser_defined_message_subscription|error {
        return self.generatedClient->createUserDefinedMessageSubscription(accountSid ?: self.accountSid, callSid, payload);
    }
    # Delete a specific User Defined Message Subscription.
    #
    # + callSid - The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Message Subscription is associated with. This refers to the Call SID that is producing the User Defined Messages.
    # + sid - The SID that uniquely identifies this User Defined Message Subscription.
    # + accountSid - The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that subscribed to the User Defined Messages.
    # + return - The resource was deleted successfully. 
    remote isolated function deleteUserDefinedMessageSubscription(string callSid, string sid, string? accountSid = ()) returns http:Response|error {
        return self.generatedClient->deleteUserDefinedMessageSubscription(accountSid ?: self.accountSid, callSid, sid);
    }
}
