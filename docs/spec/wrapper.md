# Sanitizations for client
After generating the client using open api specification, the following modifications are made to the generated client by introducing a wrapper client.

Remove the `string accountSid` parameter from all non-account-related functions and add it as an optional parameter to each function, with the default parameter set to `accountSid` in the initial client configurations.

For example, the function:

```ballerina
remote isolated function createCall(string accountSid, CreateCallRequest payload) returns Call|error {
}
```

should be restructured to:

```ballerina
remote isolated function createCall(CreateCallRequest payload, string? accountSid = ()) returns Call|error {
    return self.generatedClient->createCall(accountSid ?: self.accountSid, payload);
}
```
