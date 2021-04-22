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
// under the License.

// Twilio API urls
final string TWILIO_API_BASE_URL = "https://api.twilio.com/2010-04-01";
final string AUTHY_API_BASE_URL = "https://api.authy.com/protected";

final string TWILIO_ACCOUNTS_API = "/Accounts";
final string AUTHY_APP_API = "/json/app/details";
final string AUTHY_USER_API = "/json/users";
final string AUTHY_OTP_SMS_API = "/json/sms";
final string AUTHY_OTP_CALL_API = "/json/call";
final string AUTHY_OTP_VERIFY_API = "/json/verify";

final string SMS_SEND = "/Messages.json";
final string WHATSAPP_SEND = "/Messages.json";
final string VOICE_CALL = "/Calls.json";
final string JSON_EXTENSION = ".json";

final string USER_ADD = "/new";
final string USER_STATUS = "/status";
final string USER_REMOVE = "/remove";
final string USER_SECRET = "/secret";
final string MESSAGE = "/Messages/";

// Pre defined strings
final string CHARSET_UTF8 = "utf-8";
final string AUTHORIZATION = "Authorization";
final string BASIC = "Basic";
final string CONTENT_TYPE = "Content-Type";
final string X_AUTHY_API_KEY = "X-Authy-API-Key";
final string WHATSAPP = "whatsapp";

// API related parameters
final string TO = "To";
final string FROM = "From";
final string BODY = "Body";
final string URL = "Url";
final string STATUS_CALLBACK_URL = "StatusCallback";
final string STATUS_CALLBACK_METHOD = "StatusCallbackMethod";
final string STATUS_CALLBACK_EVENT = "StatusCallbackEvent";

// Conf parameter keys
final string ACCOUNT_SID = "ACCOUNT_SID";
final string AUTH_TOKEN = "AUTH_TOKEN";
final string AUTHY_API_KEY = "AUTHY_API_KEY";

// HTTP methods for incoming event payload
public const POST = "POST";
public const GET = "GET";

//Symbols
const string FORWARD_SLASH = "/";
