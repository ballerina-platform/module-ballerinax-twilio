// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

//Webhook events

public const string QUEUED = "queued";
public const string SENDING= "sending";
public const string SENT = "sent";
public const string RECEIVING = "receiving";
public const string RECEIVED = "received";
public const string DELIVERED = "delivered";
public const string UNDELIVERED= "undelivered";
public const string READ = "read";

// Call Progress Events 
// These needs to be specify in the StatusCallbbackEvent parameter during the call initiation.
// If no StatusCallbackEvent is specified, completed is fired by default.

# Twilio removes your call from the queue and starts dialing
public const string INITIATED = "initiated";
# The call is currently ringing
public const string RINGING = "ringing";
# The call was answered and is currently in progress.
public const string ANSWERED = "answered";
# The call has been connected, and the connection is currently active.
public const string IN_PROGRESS= "in-progress";
# The call was answered and has ended normally.
public const string COMPLETED = "completed";

// Final Call Statuses - After a call has finished, the following final status options are possible:

# Twilio dialed the number, but received a busy response.
public const string BUSY = "busy";
# Twilio's carriers could not connect the call. Possible causes include the destination is unreachable, or the number 
# may have been input incorrectly.
public const string FAILED = "failed";
# Twilio dialed the number but no one answered before the timeout parameter value elapsed. This can be configured for 
# each call, but by default is set to 60 seconds on outbound API calls, and 30 seconds on outbound <Dial> calls.
public const string NO_ANSWER= "no-answer";
# Prior to being answered, an outbound call was cancelled via an HTTP POST request to the REST API, or an incoming call 
# was disconnected by the calling party
public const string CANCELED= "canceled";


// HTTP methods for incoming event payload
public const POST = "POST";
public const GET = "GET";

// Custom Error Definitions
const INVALID_SIGNATURE = "Invalid Signature";
