# Proposal: Add API Key Based Authentication Support for Twilio Connector

_Owners_: @SachinAkash01  
_Reviewers_: @ayeshLK @NipunaRanasinghe    
_Created_: 2024/11/07  
_Updated_: 2024/11/07  
_Issue_: [#7343](https://github.com/ballerina-platform/ballerina-library/issues/7343)

## Summary
Implement the capabilities to support API Key based authentication for the Ballerina Twilio Connector.

## Goals
- Enhance the Ballerina Twilio Connector by adding support for API Key based authentication for client validation.

## Motivation
In the current Ballerina Twilio connector (version 4.x.x), only Auth Token-based authentication is supported, which grants full access to the associated Twilio account. While this is sufficient for local testing or low-risk scenarios, it poses significant security challenges in production environments. Auth Tokens allow any client with access to interact with the entire Twilio account, including sensitive resources and data, exposing a risk of unauthorized access if credentials are compromised.

API Key-based authentication provides a robust alternative by enabling finer-grained control over access permissions. Twilio’s API Key authentication allows developers to issue and manage multiple keys with tailored scopes, specific to certain applications or functionalities. API Keys can be rotated, revoked, or regenerated without impacting the overall account integrity, thereby reducing downtime in the event of a compromise and allowing for quicker incident response.

By implementing API Key-based authentication in the Ballerina Twilio connector, we can offer developers a more flexible and secure mechanism for managing Twilio API interactions. This approach aligns with industry best practices, improving security posture and minimizing the risks associated with broad-scope credentials in production environments.

## Description
In the current approach (Auth Token based authentication) of the Ballerina Twilio connector requires an `accountSid`and `authToken`, which grants full access to the Twilio account. To improve security and offer more granular control over access, this proposal introduces support for API Key-based authentication. API Key-based authentication allows developers to use an `apiKey`, `apiSecret`, and `accountSid` limiting access to specific resources and allowing for easier key management

### Enhanced ConnectionConfig Structure:
- The `ConnectionConfig` type will be modified to support both authentication mechanisms. The `auth` field will be accepting either `AuthTokenConfig` or `ApiKeyConfig` allowing the user to specify their preferred authentication method.

```ballerina
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    AuthTokenConfig|ApiKeyConfig auth;
    //other fields
|};
```

- Two distinct records `AuthTokenConfig`  and 	`ApiKeyConfig`, define the required fields for each authentication type.

```ballerina
public type AuthTokenConfig record {|
    string accountSid;
    string authToken;
|};

public type ApiKeyConfig record {|
    string accountSid;
    string apiKey;
    string apiSecret;
|};
```

- This approach improves security and flexibility, allowing granular control over Twilio account access without exposing the full account credentials in production settings.
