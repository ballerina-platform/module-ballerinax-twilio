# Sanitization for client
After generating the client using OpenAPI specification, the following modifications are made to the generated client by introducing a wrapper client.

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

2. Updated authentication configuration structure replacing the original `http:CredentialsConfig` with custom authentication configurations, allowing support for both Auth Token based and API Key based authentication mechanisms.

The `ConnectionConfig` type now accepts `AuthTokenConfig` or `ApiKeyConfig` as possible values for the `auth` field.
        
```ballerina
public type ConnectionConfig record {|
    AuthTokenConfig|ApiKeyConfig auth;
    // Other methods
|}
```

`AuthTokenConfig`: Contains `accountSid` and `authToken` for standard token-based authentication.

```ballerina
public type AuthTokenConfig record {|
    string accountSid;
    string authToken;
|};
```

`ApiKeyConfig`: Contains `accountSid`, `apiKey`, and `apiSecret` for API key-based authentication.

```ballerina
public type ApiKeyConfig record {|
    string apiKey;
    string apiSecret;
    string accountSid;
|};
```
