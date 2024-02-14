# Sanitations: Ballerina Twilio Connector

_Author_: @RDPerera \
_Reviewers_: @NipunaRanasinghe \
_Created_: 2024/02/14 \
_Updated_: 2024/02/14 \
_Edition_: Swan Lake  

This document lists the sanitations applied to the OpenAPI specification and the generated client for the Twilio connector.

## Sanitations for the OpenAPI specification

This connector is generated using Twilio's Basic [API version 2010-04-01](https://github.com/twilio/twilio-oai/blob/main/spec/yaml/twilio_api_v2010.yaml), and the following sanitations were applied to the specification before client generation.

1. Removed the `api.v2010.account.` and `api.v2010.` suffixes from the record names to enhance the user-friendliness of the specifications. For instance, `api.v2010.account.address` is now renamed to `address`, resulting in the type name changing from `ApiV2010AccountAddress` to `Address`.

2. Excluded `available_phone_number_country` from `available_phone_number_country.available_phone_number_toll_free` to prevent an OpenAPI tool reference handling error ([`Ballerina only supports local references.`](https://github.com/ballerina-platform/ballerina-standard-library/issues/4887)). This change also improves the clarity of the record names.

3. Modified parameter names in response to [this issue](https://github.com/ballerina-platform/ballerina-standard-library/issues/4882).

   - `startTime<`       changed to   `startedOnOrBefore`
   - `startTime>`       changed to   `startedOnOrAfter`
   - `endTime<`         changed to   `endedOnOrBefore`
   - `endTime>`         changed to   `endedOnOrAfter`
   - `messageDate<`     changed to   `loggedOnOrBefore`
   - `messageDate>`     changed to   `loggedOnOrAfter`
   - `dateCreated<`     changed to   `createdOnOrBefore`
   - `dateCreated>`     changed to   `createdOnOrAfter`
   - `dateUpdated<`     changed to   `updatedOnOrBefore`
   - `dateUpdated>`     changed to   `updatedOnOrAfter`
   - `dateSent<`        changed to   `sentOnOrBefore`
   - `dateSent>`        changed to   `sentOnOrAfter`

4. Add missing payload documentation for the following functions.
   - createAccount
   - updateAccount
   - createAddress
   - updateAddress
   - createApplication
   - updateApplication
   - createCall
   - updateCall
   - updateCallFeedback
   - createCallFeedbackSummary
   - createCallRecording
   - updateCallRecording
   - updateConference
   - updateConferenceRecording
   - updateConnectApp
   - updateIncomingPhoneNumber
   - createIncomingPhoneNumber
   - createIncomingPhoneNumberAssignedAddOn
   - createIncomingPhoneNumberLocal
   - createIncomingPhoneNumberMobile
   - createIncomingPhoneNumberTollFree
   - updateKey
   - createNewKey
   - updateMember
   - createMessage
   - updateMessage
   - createMessageFeedback
   - listSigningKey
   - createNewSigningKey
   - updateOutgoingCallerId
   - createValidationRequest
   - updateParticipant
   - createParticipant
   - createPayments
   - updatePayments
   - updateQueue
   - createQueue
   - updateShortCode
   - fetchSigningKey
   - updateSigningKey
   - deleteSigningKey
   - createSipAuthCallsCredentialListMapping
   - createSipAuthCallsIpAccessControlListMapping
   - createSipAuthRegistrationsCredentialListMapping
   - createSipCredential
   - updateSipCredential
   - createSipCredentialList
   - updateSipCredentialList
   - createSipCredentialListMapping
   - createSipDomain
   - updateSipDomain
   - createSipIpAccessControlList
   - updateSipIpAccessControlList
   - createSipIpAccessControlListMapping
   - createSipIpAddress
   - updateSipIpAddress
   - createSiprec
   - updateSiprec
   - createStream
   - updateStream
   - createToken
   - updateUsageTrigger
   - createUsageTrigger
   - createUserDefinedMessage
   - createUserDefinedMessageSubscription

5. Add missing functions documentation for following functions.
   - createAddress
   - fetchAddress
   - updateAddress
   - deleteAddress
   - listAvailablePhoneNumberCountry
   - fetchAvailablePhoneNumberCountry
   - listAvailablePhoneNumberLocal
   - listAvailablePhoneNumberMachineToMachine
   - listAvailablePhoneNumberMobile
   - listAvailablePhoneNumberNational
   - listAvailablePhoneNumberTollFree
   - listAvailablePhoneNumberSharedCost
   - listAvailablePhoneNumberVoip
   - fetchCallNotification
   - listCallNotification
   - updateConference
   - listDependentPhoneNumber
   - listIncomingPhoneNumberLocal
   - listIncomingPhoneNumberMobile
   - listIncomingPhoneNumberTollFree
   - fetchKey
   - updateKey
   - deleteKey
   - createNewKey
   - listSigningKey
   - createValidationRequest
   - createParticipant
   - fetchRecordingTranscription
   - deleteRecordingTranscription
   - listRecordingTranscription
   - fetchSigningKey
   - updateSigningKey
   - deleteSigningKey
   - listUsageRecordAllTime
   - listUsageRecordDaily
   - listUsageRecordLastMonth
   - listUsageRecordMonthly
   - listUsageRecordThisMonth
   - listUsageRecordToday
   - listUsageRecordYearly
   - listUsageRecordYesterday
   - deleteUsageTrigger

6. Add missing `mms`, `sms`, `voice`,and `fax`  parameter documentation for the `capabilities` record.

## Sanitations for the generated client

After generating the client using openAPI specification, the following modifications are made to the generated client by introducing a wrapper client.

1. Removed the `string accountSid` parameter from all non-account-related functions and added it as an optional parameter to each function, with the default parameter set to `accountSid` in the initial client configurations.

For example, the function:

```ballerina
remote isolated function createCall(string accountSid, CreateCallRequest payload) returns Call|error {
}
```

is restructured as:

```ballerina
remote isolated function createCall(CreateCallRequest payload, string? accountSid = ()) returns Call|error {
    return self.generatedClient->createCall(accountSid ?: self.accountSid, payload);
}
```