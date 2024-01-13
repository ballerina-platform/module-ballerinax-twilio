# Changelog
This file contains all the notable changes done to the Ballerina Twilio Connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.0.0] - 2024-01-12

### Added
- Following functionalities are added to the Twilio connector.
    - Create a new Twilio subaccount
    - Retrieve a collection of accounts linked to the requester's account
    - Modify account properties
    - Handle addresses: create, list, delete, fetch, update
    - Manage applications: create, retrieve list, delete, fetch, update properties
    - Work with authorized connect apps: fetch instance, retrieve list
    - List available phone number countries and types
    - Fetch account balance
    - Manage outgoing calls and recordings
    - Handle conferences: fetch instance, update, retrieve list
    - Manage connect apps: fetch instance, update, delete, retrieve list
    - Handle incoming phone numbers: update, fetch, delete, list, purchase
    - Manage add-ons, keys, and media resources
    - Handle messages: send, retrieve list, delete, fetch, update, create feedback
    - Manage signing keys and notifications
    - Handle outgoing caller IDs: fetch instance, update, delete, retrieve list
    - Manage participants in a conference: fetch instance, update properties, kick, create, retrieve list
    - Handle payments and queues: create session, update, remove empty queue, retrieve list
    - Manage recordings: fetch instance, delete, retrieve list
    - Handle add-on results and payloads: fetch instance, delete, retrieve list
    - Manage recording transcriptions: fetch, delete, list
    - Handle phone number SafeList: add, check, remove
    - Manage short codes: fetch instance, update, retrieve list
    - Manage credential list mappings and IP Access Control Lists
    - Handle domains: create, fetch instance, update attributes, delete
    - Manage usage records and triggers: fetch instance, update, delete, create, retrieve list
    - Manage user-defined messages: create, subscribe, delete subscription

### Changed
- getAccountDetails() changed to fetchAccount()
- sendSms() changed to createMessage()
- getMessage() changed to fetchMessage()
- sendWhatsAppMessage() available under createMessage() with channel type as whatsapp
- makeVoiceCall() changed to createCall()