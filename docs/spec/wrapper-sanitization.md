# Sanitization for client
After generating the client using open API specification, the following modifications are made to the generated client by introducing a wrapper client.

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
