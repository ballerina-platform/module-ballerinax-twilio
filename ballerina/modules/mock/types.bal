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

import ballerina/constraint;
import ballerina/http;

public type OkAddress record {|
    *http:Ok;
    Address body;
|};

public type OkAccount record {|
    *http:Ok;
    Account body;
|};

public type OkCall record {|
    *http:Ok;
    Call body;
|};

public type OkMessage record {|
    *http:Ok;
    Message body;
|};

public type ListMessageResponse record {
    Message[] messages?;
    int end?;
    string first_page_uri?;
    string? next_page_uri?;
    int page?;
    int page_size?;
    string? previous_page_uri?;
    int 'start?;
    string uri?;
};

public type Account_enum_status "active"|"suspended"|"closed";

public type UpdateAccountRequest record {
    # Update the human-readable description of this Account
    string FriendlyName?;
    Account_enum_status Status?;
};

public type ListAddressResponse record {
    Address[] addresses?;
    int end?;
    string first_page_uri?;
    string? next_page_uri?;
    int page?;
    int page_size?;
    string? previous_page_uri?;
    int 'start?;
    string uri?;
};

public type Call_enum_status "queued"|"ringing"|"in-progress"|"completed"|"busy"|"failed"|"no-answer"|"canceled";

public type Call record {
    # The unique string that we created to identify this Call resource.
    string? sid?;
    # The date and time in GMT that this resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format.
    string? date_created?;
    # The date and time in GMT that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format.
    string? date_updated?;
    # The SID that identifies the call that created this leg.
    string? parent_call_sid?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Call resource.
    string? account_sid?;
    # The phone number, SIP address, Client identifier or SIM SID that received this call. Phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +16175551212). SIP addresses are formatted as `name@company.com`. Client identifiers are formatted `client:name`. SIM SIDs are formatted as `sim:sid`.
    string? to?;
    # The phone number, SIP address or Client identifier that received this call. Formatted for display. Non-North American phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +442071838750).
    string? to_formatted?;
    # The phone number, SIP address, Client identifier or SIM SID that made this call. Phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +16175551212). SIP addresses are formatted as `name@company.com`. Client identifiers are formatted `client:name`. SIM SIDs are formatted as `sim:sid`.
    string? 'from?;
    # The calling phone number, SIP address, or Client identifier formatted for display. Non-North American phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +442071838750).
    string? from_formatted?;
    # If the call was inbound, this is the SID of the IncomingPhoneNumber resource that received the call. If the call was outbound, it is the SID of the OutgoingCallerId resource from which the call was placed.
    string? phone_number_sid?;
    Call_enum_status status?;
    # The start time of the call, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format. Empty if the call has not yet been dialed.
    string? start_time?;
    # The time the call ended, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format. Empty if the call did not complete successfully.
    string? end_time?;
    # The length of the call in seconds. This value is empty for busy, failed, unanswered, or ongoing calls.
    string? duration?;
    # The charge for this call, in the currency associated with the account. Populated after the call is completed. May not be immediately available.
    string? price?;
    # The currency in which `Price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format (e.g., `USD`, `EUR`, `JPY`). Always capitalized for calls.
    string? price_unit?;
    # A string describing the direction of the call. Can be: `inbound` for inbound calls, `outbound-api` for calls initiated via the REST API or `outbound-dial` for calls initiated by a `<Dial>` verb. Using [Elastic SIP Trunking](https://www.twilio.com/docs/sip-trunking), the values can be [`trunking-terminating`](https://www.twilio.com/docs/sip-trunking#termination) for outgoing calls from your communications infrastructure to the PSTN or [`trunking-originating`](https://www.twilio.com/docs/sip-trunking#origination) for incoming calls to your communications infrastructure from the PSTN.
    string? direction?;
    # Either `human` or `machine` if this call was initiated with answering machine detection. Empty otherwise.
    string? answered_by?;
    # The API version used to create the call.
    string? api_version?;
    # The forwarding phone number if this call was an incoming call forwarded from another number (depends on carrier supporting forwarding). Otherwise, empty.
    string? forwarded_from?;
    # The Group SID associated with this call. If no Group is associated with the call, the field is empty.
    string? group_sid?;
    # The caller's name if this call was an incoming call to a phone number with caller ID Lookup enabled. Otherwise, empty.
    string? caller_name?;
    # The wait time in milliseconds before the call is placed.
    string? queue_time?;
    # The unique identifier of the trunk resource that was used for this call. The field is empty if the call was not made using a SIP trunk or if the call is not terminated.
    string? trunk_sid?;
    # The URI of this resource, relative to `https://api.twilio.com`.
    string? uri?;
    # A list of subresources available to this call, identified by their URIs relative to `https://api.twilio.com`.
    record {}? subresource_uris?;
};

public type CreateAddressRequest record {
    # The name to associate with the new address.
    string CustomerName;
    # The number and street address of the new address.
    string Street;
    # The city of the new address.
    string City;
    # The state or region of the new address.
    string Region;
    # The postal code of the new address.
    string PostalCode;
    # The ISO country code of the new address.
    string IsoCountry;
    # A descriptive string that you create to describe the new address. It can be up to 64 characters long.
    string FriendlyName?;
    # Whether to enable emergency calling on the new address. Can be: `true` or `false`.
    boolean EmergencyEnabled?;
    # Whether we should automatically correct the address. Can be: `true` or `false` and the default is `true`. If empty or `true`, we will correct the address you provide if necessary. If `false`, we won't alter the address you provide.
    boolean AutoCorrectAddress?;
    # The additional number and street address of the address.
    string StreetSecondary?;
};

public type Call_enum_update_status "canceled"|"completed";

public type UpdateCallRequest record {
    # The absolute URL that returns the TwiML instructions for the call. We will call this URL using the `method` when the call connects. For more information, see the [Url Parameter](https://www.twilio.com/docs/voice/make-calls#specify-a-url-parameter) section in [Making Calls](https://www.twilio.com/docs/voice/make-calls).
    string Url?;
    # The HTTP method we should use when calling the `url`. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" Method?;
    Call_enum_update_status Status?;
    # The URL that we call using the `fallback_method` if an error occurs when requesting or executing the TwiML at `url`. If an `application_sid` parameter is present, this parameter is ignored.
    string FallbackUrl?;
    # The HTTP method that we should use to request the `fallback_url`. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" FallbackMethod?;
    # The URL we should call using the `status_callback_method` to send status information to your application. If no `status_callback_event` is specified, we will send the `completed` status. If an `application_sid` parameter is present, this parameter is ignored. URLs must contain a valid hostname (underscores are not permitted).
    string StatusCallback?;
    # The HTTP method we should use when requesting the `status_callback` URL. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" StatusCallbackMethod?;
    # TwiML instructions for the call Twilio will use without fetching Twiml from url. Twiml and url parameters are mutually exclusive
    string Twiml?;
    # The maximum duration of the call in seconds. Constraints depend on account and configuration.
    int TimeLimit?;
};

public type CreateAccountRequest record {
    # A human readable description of the account to create, defaults to `SubAccount Created at {YYYY-MM-DD HH:MM meridian}`
    string FriendlyName?;
};

public type Account record {
    # The authorization token for this account. This token should be kept a secret, so no sharing.
    string? auth_token?;
    # The date that this account was created, in GMT in RFC 2822 format
    string? date_created?;
    # The date that this account was last updated, in GMT in RFC 2822 format.
    string? date_updated?;
    # A human readable description of this account, up to 64 characters long. By default the FriendlyName is your email address.
    string? friendly_name?;
    # The unique 34 character id that represents the parent of this account. The OwnerAccountSid of a parent account is it's own sid.
    string? owner_account_sid?;
    # A 34 character string that uniquely identifies this resource.
    string? sid?;
    Account_enum_status status?;
    # A Map of various subresources available for the given Account Instance
    record {}? subresource_uris?;
    Account_enum_type 'type?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
};

public type Address record {
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource.
    string? account_sid?;
    # The city in which the address is located.
    string? city?;
    # The name associated with the address.This property has a maximum length of 16 4-byte characters, or 21 3-byte characters.
    string? customer_name?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format.
    string? date_created?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format.
    string? date_updated?;
    # The string that you assigned to describe the resource.
    string? friendly_name?;
    # The ISO country code of the address.
    string? iso_country?;
    # The postal code of the address.
    string? postal_code?;
    # The state or region of the address.
    string? region?;
    # The unique string that that we created to identify the Address resource.
    string? sid?;
    # The number and street address of the address.
    string? street?;
    # The URI of the resource, relative to `https://api.twilio.com`.
    string? uri?;
    # Whether emergency calling has been enabled on this number.
    boolean? emergency_enabled?;
    # Whether the address has been validated to comply with local regulation. In countries that require valid addresses, an invalid address will not be accepted. `true` indicates the Address has been validated. `false` indicate the country doesn't require validation or the Address is not valid.
    boolean? validated?;
    # Whether the address has been verified to comply with regulation. In countries that require valid addresses, an invalid address will not be accepted. `true` indicates the Address has been verified. `false` indicate the country doesn't require verified or the Address is not valid.
    boolean? verified?;
    # The additional number and street address of the address.
    string? street_secondary?;
};

public type Account_enum_type "Trial"|"Full";

public type CreateCallRequest record {
    # The phone number, SIP address, or client identifier to call.
    string To;
    # The phone number or client identifier to use as the caller id. If using a phone number, it must be a Twilio number or a Verified [outgoing caller id](https://www.twilio.com/docs/voice/api/outgoing-caller-ids) for your account. If the `to` parameter is a phone number, `From` must also be a phone number.
    string From;
    # The HTTP method we should use when calling the `url` parameter's value. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" Method?;
    # The URL that we call using the `fallback_method` if an error occurs when requesting or executing the TwiML at `url`. If an `application_sid` parameter is present, this parameter is ignored.
    string FallbackUrl?;
    # The HTTP method that we should use to request the `fallback_url`. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" FallbackMethod?;
    # The URL we should call using the `status_callback_method` to send status information to your application. If no `status_callback_event` is specified, we will send the `completed` status. If an `application_sid` parameter is present, this parameter is ignored. URLs must contain a valid hostname (underscores are not permitted).
    string StatusCallback?;
    # The call progress events that we will send to the `status_callback` URL. Can be: `initiated`, `ringing`, `answered`, and `completed`. If no event is specified, we send the `completed` status. If you want to receive multiple events, specify each one in a separate `status_callback_event` parameter. See the code sample for [monitoring call progress](https://www.twilio.com/docs/voice/api/call-resource?code-sample=code-create-a-call-resource-and-specify-a-statuscallbackevent&code-sdk-version=json). If an `application_sid` is present, this parameter is ignored.
    string[] StatusCallbackEvent?;
    # The HTTP method we should use when calling the `status_callback` URL. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" StatusCallbackMethod?;
    # A string of keys to dial after connecting to the number, maximum of 32 digits. Valid digits in the string include: any digit (`0`-`9`), '`#`', '`*`' and '`w`', to insert a half second pause. For example, if you connected to a company phone number and wanted to pause for one second, and then dial extension 1234 followed by the pound key, the value of this parameter would be `ww1234#`. Remember to URL-encode this string, since the '`#`' character has special meaning in a URL. If both `SendDigits` and `MachineDetection` parameters are provided, then `MachineDetection` will be ignored.
    string SendDigits?;
    # The integer number of seconds that we should allow the phone to ring before assuming there is no answer. The default is `60` seconds and the maximum is `600` seconds. For some call flows, we will add a 5-second buffer to the timeout value you provide. For this reason, a timeout value of 10 seconds could result in an actual timeout closer to 15 seconds. You can set this to a short time, such as `15` seconds, to hang up before reaching an answering machine or voicemail.
    int Timeout?;
    # Whether to record the call. Can be `true` to record the phone call, or `false` to not. The default is `false`. The `recording_url` is sent to the `status_callback` URL.
    boolean Record?;
    # The number of channels in the final recording. Can be: `mono` or `dual`. The default is `mono`. `mono` records both legs of the call in a single channel of the recording file. `dual` records each leg to a separate channel of the recording file. The first channel of a dual-channel recording contains the parent call and the second channel contains the child call.
    string RecordingChannels?;
    # The URL that we call when the recording is available to be accessed.
    string RecordingStatusCallback?;
    # The HTTP method we should use when calling the `recording_status_callback` URL. Can be: `GET` or `POST` and the default is `POST`.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" RecordingStatusCallbackMethod?;
    # The username used to authenticate the caller making a SIP call.
    string SipAuthUsername?;
    # The password required to authenticate the user account specified in `sip_auth_username`.
    string SipAuthPassword?;
    # Whether to detect if a human, answering machine, or fax has picked up the call. Can be: `Enable` or `DetectMessageEnd`. Use `Enable` if you would like us to return `AnsweredBy` as soon as the called party is identified. Use `DetectMessageEnd`, if you would like to leave a message on an answering machine. If `send_digits` is provided, this parameter is ignored. For more information, see [Answering Machine Detection](https://www.twilio.com/docs/voice/answering-machine-detection).
    string MachineDetection?;
    # The number of seconds that we should attempt to detect an answering machine before timing out and sending a voice request with `AnsweredBy` of `unknown`. The default timeout is 30 seconds.
    int MachineDetectionTimeout?;
    # The recording status events that will trigger calls to the URL specified in `recording_status_callback`. Can be: `in-progress`, `completed` and `absent`. Defaults to `completed`. Separate  multiple values with a space.
    string[] RecordingStatusCallbackEvent?;
    # Whether to trim any leading and trailing silence from the recording. Can be: `trim-silence` or `do-not-trim` and the default is `trim-silence`.
    string Trim?;
    # The phone number, SIP address, or Client identifier that made this call. Phone numbers are in [E.164 format](https://wwnw.twilio.com/docs/glossary/what-e164) (e.g., +16175551212). SIP addresses are formatted as `name@company.com`.
    string CallerId?;
    # The number of milliseconds that is used as the measuring stick for the length of the speech activity, where durations lower than this value will be interpreted as a human and longer than this value as a machine. Possible Values: 1000-6000. Default: 2400.
    int MachineDetectionSpeechThreshold?;
    # The number of milliseconds of silence after speech activity at which point the speech activity is considered complete. Possible Values: 500-5000. Default: 1200.
    int MachineDetectionSpeechEndThreshold?;
    # The number of milliseconds of initial silence after which an `unknown` AnsweredBy result will be returned. Possible Values: 2000-10000. Default: 5000.
    int MachineDetectionSilenceTimeout?;
    # Select whether to perform answering machine detection in the background. Default, blocks the execution of the call until Answering Machine Detection is completed. Can be: `true` or `false`.
    string AsyncAmd?;
    # The URL that we should call using the `async_amd_status_callback_method` to notify customer application whether the call was answered by human, machine or fax.
    string AsyncAmdStatusCallback?;
    # The HTTP method we should use when calling the `async_amd_status_callback` URL. Can be: `GET` or `POST` and the default is `POST`.
    "HEAD"|"GET"|"POST"|"PATCH"|"PUT"|"DELETE" AsyncAmdStatusCallbackMethod?;
    # The SID of a BYOC (Bring Your Own Carrier) trunk to route this call with. Note that `byoc` is only meaningful when `to` is a phone number; it will otherwise be ignored. (Beta)
    @constraint:String {maxLength: 34, minLength: 34, pattern: re `^BY[0-9a-fA-F]{32}$`}
    string Byoc?;
    # The Reason for the outgoing call. Use it to specify the purpose of the call that is presented on the called party's phone. (Branded Calls Beta)
    string CallReason?;
    # A token string needed to invoke a forwarded call. A call_token is generated when an incoming call is received on a Twilio number. Pass an incoming call's call_token value to a forwarded call via the call_token parameter when creating a new call. A forwarded call should bear the same CallerID of the original incoming call.
    string CallToken?;
    # The audio track to record for the call. Can be: `inbound`, `outbound` or `both`. The default is `both`. `inbound` records the audio that is received by Twilio. `outbound` records the audio that is generated from Twilio. `both` records the audio that is received and generated by Twilio.
    string RecordingTrack?;
    # The maximum duration of the call in seconds. Constraints depend on account and configuration.
    int TimeLimit?;
    # The absolute URL that returns the TwiML instructions for the call. We will call this URL using the `method` when the call connects. For more information, see the [Url Parameter](https://www.twilio.com/docs/voice/make-calls#specify-a-url-parameter) section in [Making Calls](https://www.twilio.com/docs/voice/make-calls).
    string Url?;
    # TwiML instructions for the call Twilio will use without fetching Twiml from url parameter. If both `twiml` and `url` are provided then `twiml` parameter will be ignored. Max 4000 characters.
    string Twiml?;
    # The SID of the Application resource that will handle the call, if the call will be handled by an application.
    @constraint:String {maxLength: 34, minLength: 34, pattern: re `^AP[0-9a-fA-F]{32}$`}
    string ApplicationSid?;
};

public type UpdateMessageRequest record {
    # The new `body` of the Message resource. To redact the text content of a Message, this parameter's value must be an empty string
    string Body?;
    Message_enum_update_status Status?;
};

public type UpdateAddressRequest record {
    # A descriptive string that you create to describe the address. It can be up to 64 characters long.
    string FriendlyName?;
    # The name to associate with the address.
    string CustomerName?;
    # The number and street address of the address.
    string Street?;
    # The city of the address.
    string City?;
    # The state or region of the address.
    string Region?;
    # The postal code of the address.
    string PostalCode?;
    # Whether to enable emergency calling on the address. Can be: `true` or `false`.
    boolean EmergencyEnabled?;
    # Whether we should automatically correct the address. Can be: `true` or `false` and the default is `true`. If empty or `true`, we will correct the address you provide if necessary. If `false`, we won't alter the address you provide.
    boolean AutoCorrectAddress?;
    # The additional number and street address of the address.
    string StreetSecondary?;
};

public type ListCallResponse record {
    Call[] calls?;
    int end?;
    string first_page_uri?;
    string? next_page_uri?;
    int page?;
    int page_size?;
    string? previous_page_uri?;
    int 'start?;
    string uri?;
};

public type Message_enum_status "queued"|"sending"|"sent"|"failed"|"delivered"|"undelivered"|"receiving"|"received"|"accepted"|"scheduled"|"read"|"partially_delivered"|"canceled";

public type ListAccountResponse record {
    Account[] accounts?;
    int end?;
    string first_page_uri?;
    string? next_page_uri?;
    int page?;
    int page_size?;
    string? previous_page_uri?;
    int 'start?;
    string uri?;
};

public type Balance record {
    # The unique SID identifier of the Account.
    string? account_sid?;
    # The balance of the Account, in units specified by the unit parameter. Balance changes may not be reflected immediately. Child accounts do not contain balance information
    string? balance?;
    # The units of currency for the account balance
    string? currency?;
};

public type Message_enum_update_status "canceled";

public type Message_enum_content_retention "retain"|"discard";

public type Message_enum_address_retention "retain"|"obfuscate";

public type Message_enum_schedule_type "fixed";

public type Message_enum_risk_check "enable"|"disable";

public type CreateMessageRequest record {
    # The recipient's phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (for SMS/MMS) or [channel address](https://www.twilio.com/docs/messaging/channels), e.g. `whatsapp:+15552229999`.
    string To;
    # The URL of the endpoint to which Twilio sends [Message status callback requests](https://www.twilio.com/docs/sms/api/message-resource#twilios-request-to-the-statuscallback-url). URL must contain a valid hostname and underscores are not allowed. If you include this parameter with the `messaging_service_sid`, Twilio uses this URL instead of the Status Callback URL of the [Messaging Service](https://www.twilio.com/docs/messaging/api/service-resource). 
    string StatusCallback?;
    # The SID of the associated [TwiML Application](https://www.twilio.com/docs/usage/api/applications). If this parameter is provided, the `status_callback` parameter of this request is ignored; [Message status callback requests](https://www.twilio.com/docs/sms/api/message-resource#twilios-request-to-the-statuscallback-url) are sent to the TwiML App's `message_status_callback` URL.
    @constraint:String {maxLength: 34, minLength: 34, pattern: re `^AP[0-9a-fA-F]{32}$`}
    string ApplicationSid?;
    # The maximum price in US dollars that you are willing to pay for this Message's delivery. The value can have up to four decimal places. When the `max_price` parameter is provided, the cost of a message is checked before it is sent. If the cost exceeds `max_price`, the message is not sent and the Message `status` is `failed`.
    decimal MaxPrice?;
    # Boolean indicating whether or not you intend to provide delivery confirmation feedback to Twilio (used in conjunction with the [Message Feedback subresource](https://www.twilio.com/docs/sms/api/message-feedback-resource)). Default value is `false`.
    boolean ProvideFeedback?;
    # Total number of attempts made (including this request) to send the message regardless of the provider used
    int Attempt?;
    # The maximum length in seconds that the Message can remain in Twilio's outgoing message queue. If a queued Message exceeds the `validity_period`, the Message is not sent. Accepted values are integers from `1` to `14400`. Default value is `14400`. A `validity_period` greater than `5` is recommended. [Learn more about the validity period](https://www.twilio.com/blog/take-more-control-of-outbound-messages-using-validity-period-html)
    int ValidityPeriod?;
    # Reserved
    boolean ForceDelivery?;
    Message_enum_content_retention ContentRetention?;
    Message_enum_address_retention AddressRetention?;
    # Whether to detect Unicode characters that have a similar GSM-7 character and replace them. Can be: `true` or `false`.
    boolean SmartEncoded?;
    # Rich actions for non-SMS/MMS channels. Used for [sending location in WhatsApp messages](https://www.twilio.com/docs/whatsapp/message-features#location-messages-with-whatsapp).
    string[] PersistentAction?;
    # For Messaging Services with [Link Shortening configured](https://www.twilio.com/docs/messaging/features/how-to-configure-link-shortening) only: A Boolean indicating whether or not Twilio should shorten links in the `body` of the Message. Default value is `false`. If `true`, the `messaging_service_sid` parameter must also be provided.
    boolean ShortenUrls?;
    Message_enum_schedule_type ScheduleType?;
    # The time that Twilio will send the message. Must be in ISO 8601 format.
    string SendAt?;
    # If set to `true`, Twilio delivers the message as a single MMS message, regardless of the presence of media.
    boolean SendAsMms?;
    # For [Content Editor/API](https://www.twilio.com/docs/content) only: Key-value pairs of [Template variables](https://www.twilio.com/docs/content/using-variables-with-content-api) and their substitution values. `content_sid` parameter must also be provided. If values are not defined in the `content_variables` parameter, the [Template's default placeholder values](https://www.twilio.com/docs/content/content-api-resources#create-templates) are used.
    string ContentVariables?;
    Message_enum_risk_check RiskCheck?;
    # The sender's Twilio phone number (in [E.164](https://en.wikipedia.org/wiki/E.164) format), [alphanumeric sender ID](https://www.twilio.com/docs/sms/send-messages#use-an-alphanumeric-sender-id), [Wireless SIM](https://www.twilio.com/docs/iot/wireless/programmable-wireless-send-machine-machine-sms-commands), [short code](https://www.twilio.com/docs/sms/api/short-code), or [channel address](https://www.twilio.com/docs/messaging/channels) (e.g., `whatsapp:+15554449999`). The value of the `from` parameter must be a sender that is hosted within Twilio and belongs to the Account creating the Message. If you are using `messaging_service_sid`, this parameter can be empty (Twilio assigns a `from` value from the Messaging Service's Sender Pool) or you can provide a specific sender from your Sender Pool.
    string From?;
    # The SID of the [Messaging Service](https://www.twilio.com/docs/messaging/services) you want to associate with the Message. When this parameter is provided and the `from` parameter is omitted, Twilio selects the optimal sender from the Messaging Service's Sender Pool. You may also provide a `from` parameter if you want to use a specific Sender from the Sender Pool.
    @constraint:String {maxLength: 34, minLength: 34, pattern: re `^MG[0-9a-fA-F]{32}$`}
    string MessagingServiceSid?;
    # The text content of the outgoing message. Can be up to 1,600 characters in length. SMS only: If the `body` contains more than 160 [GSM-7](https://www.twilio.com/docs/glossary/what-is-gsm-7-character-encoding) characters (or 70 [UCS-2](https://www.twilio.com/docs/glossary/what-is-ucs-2-character-encoding) characters), the message is segmented and charged accordingly. For long `body` text, consider using the [send_as_mms parameter](https://www.twilio.com/blog/mms-for-long-text-messages).
    string Body?;
    # The URL of media to include in the Message content. `jpeg`, `jpg`, `gif`, and `png` file types are fully supported by Twilio and content is formatted for delivery on destination devices. The media size limit is 5 MB for supported file types (`jpeg`, `jpg`, `png`, `gif`) and 500 KB for [other types](https://www.twilio.com/docs/sms/accepted-mime-types) of accepted media. To send more than one image in the message, provide multiple `media_url` parameters in the POST request. You can include up to ten `media_url` parameters per message. [International](https://support.twilio.com/hc/en-us/articles/223179808-Sending-and-receiving-MMS-messages) and [carrier](https://support.twilio.com/hc/en-us/articles/223133707-Is-MMS-supported-for-all-carriers-in-US-and-Canada-) limits apply.
    string[] MediaUrl?;
    # For [Content Editor/API](https://www.twilio.com/docs/content) only: The SID of the Content Template to be used with the Message, e.g., `HXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`. If this parameter is not provided, a Content Template is not used. Find the SID in the Console on the Content Editor page. For Content API users, the SID is found in Twilio's response when [creating the Template](https://www.twilio.com/docs/content/content-api-resources#create-templates) or by [fetching your Templates](https://www.twilio.com/docs/content/content-api-resources#fetch-all-content-resources).
    @constraint:String {maxLength: 34, minLength: 34, pattern: re `^HX[0-9a-fA-F]{32}$`}
    string ContentSid?;
};

public type Message_enum_direction "inbound"|"outbound-api"|"outbound-call"|"outbound-reply";

public type Message record {
    # The text content of the message
    string? body?;
    # The number of segments that make up the complete message. SMS message bodies that exceed the [character limit](https://www.twilio.com/docs/glossary/what-sms-character-limit) are segmented and charged as multiple messages. Note: For messages sent via a Messaging Service, `num_segments` is initially `0`, since a sender hasn't yet been assigned.
    string? num_segments?;
    Message_enum_direction direction?;
    # The sender's phone number (in [E.164](https://en.wikipedia.org/wiki/E.164) format), [alphanumeric sender ID](https://www.twilio.com/docs/sms/send-messages#use-an-alphanumeric-sender-id), [Wireless SIM](https://www.twilio.com/docs/iot/wireless/programmable-wireless-send-machine-machine-sms-commands), [short code](https://www.twilio.com/docs/sms/api/short-code), or  [channel address](https://www.twilio.com/docs/messaging/channels) (e.g., `whatsapp:+15554449999`). For incoming messages, this is the number or channel address of the sender. For outgoing messages, this value is a Twilio phone number, alphanumeric sender ID, short code, or channel address from which the message is sent.
    string? 'from?;
    # The recipient's phone number (in [E.164](https://en.wikipedia.org/wiki/E.164) format) or [channel address](https://www.twilio.com/docs/messaging/channels) (e.g. `whatsapp:+15552229999`)
    string? to?;
    # The [RFC 2822](https://datatracker.ietf.org/doc/html/rfc2822#section-3.3) timestamp (in GMT) of when the Message resource was last updated
    string? date_updated?;
    # The amount billed for the message in the currency specified by `price_unit`. The `price` is populated after the message has been sent/received, and may not be immediately availalble. View the [Pricing page](https://www.twilio.com/en-us/pricing) for more details.
    string? price?;
    # The description of the `error_code` if the Message `status` is `failed` or `undelivered`. If no error was encountered, the value is `null`.
    string? error_message?;
    # The URI of the Message resource, relative to `https://api.twilio.com`.
    string? uri?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource
    string? account_sid?;
    # The number of media files associated with the Message resource.
    string? num_media?;
    Message_enum_status status?;
    # The SID of the [Messaging Service](https://www.twilio.com/docs/messaging/api/service-resource) associated with the Message resource. The value is `null` if a Messaging Service was not used.
    string? messaging_service_sid?;
    # The unique, Twilio-provided string that identifies the Message resource.
    string? sid?;
    # The [RFC 2822](https://datatracker.ietf.org/doc/html/rfc2822#section-3.3) timestamp (in GMT) of when the Message was sent. For an outgoing message, this is when Twilio sent the message. For an incoming message, this is when Twilio sent the HTTP request to your incoming message webhook URL.
    string? date_sent?;
    # The [RFC 2822](https://datatracker.ietf.org/doc/html/rfc2822#section-3.3) timestamp (in GMT) of when the Message resource was created
    string? date_created?;
    # The [error code](https://www.twilio.com/docs/api/errors) returned if the Message `status` is `failed` or `undelivered`. If no error was encountered, the value is `null`.
    int? error_code?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format (e.g. `usd`, `eur`, `jpy`).
    string? price_unit?;
    # The API version used to process the Message
    string? api_version?;
    # A list of related resources identified by their URIs relative to `https://api.twilio.com`
    record {}? subresource_uris?;
};
