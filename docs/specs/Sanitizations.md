# Sanitizations

1. Remove the `api.v2010.account.` and `api.v2010.` suffixes from the record names to improve the user-friendliness of the record names.

   For example, `api.v2010.account.address` will be renamed to `address` in the specification, resulting in the type name of `ApiV2010AccountAddress` becoming `Address`.

2. Remove `available_phone_number_country` from `available_phone_number_country.available_phone_number_toll_free` to avoid the OpenAPI tool reference handling error ([`Ballerina only supports local references.`](https://github.com/ballerina-platform/ballerina-standard-library/issues/4887)), and also to improve the user-friendliness of the record names.

3. Change parameter names due to this [issue](https://github.com/ballerina-platform/ballerina-standard-library/issues/4882).

   - `startTime<`   -> `startedOnOrBefore`
   - `startTime>`   -> `startedOnOrAfter`
   - `endTime<`     -> `endedOnOrBefore`
   - `endTime>`     -> `endedOnOrAfter`
   - `messageDate<` -> `loggedOnOrBefore`
   - `messageDate>` -> `loggedOnOrAfter`
   - `dateCreated<` -> `createdOnOrBefore`
   - `dateCreated>` -> `createdOnOrAfter`
   - `dateUpdated<` -> `updatedOnOrBefore`
   - `dateUpdated>` -> `updatedOnOrAfter`
   - `dateSent<`    -> `sentOnOrBefore`
   - `dateSent>`    -> `sentOnOrAfter`