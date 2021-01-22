public type SmsEvent record {|
    string SmsSid;
    string SmsStatus;
    string From;
    string To;
    string ApiVersion;
    string MessageSid;
    string AccountSid;
    string MessageStatus?;
    string ToCountry?;
    string ToState?;
    string SmsMessageSid?;
    string NumMedia?;
    string ToCity?;
    string FromZip?;
    string FromState?;
    string FromCity?;
    string Body?;
    string FromCountry?;
    string ToZip?;
    string NumSegments?;
    string MessagingServiceSid?;
|};

public type CallEvent record {|
    string AccountSid; //
    string ApiVersion; //
    string CallSid; //
    string CallStatus; // 
    string Called;  //
    string CalledCity?; //
    string CalledCountry; //
    string CalledState?;//
    string CalledZip?;//
    string Caller; //
    string CallDuration?;
    string CallerCity?; 
    string CallerCountry?; 
    string CallerState?; 
    string CallerZip?; 
    string Direction; //
    string Duration?; 
    string From; //
    string FromCity?; 
    string FromCountry?; 
    string FromState?; 
    string FromZip?; 
    string To; //
    string ToCity?; //
    string ToCountry; //
    string ToState?;//
    string ToZip?;//
    string Timestamp?;
    string CallbackSource?; 
    string SipResponseCode?;
    string SequenceNumber?; 

|};

public type CallRecordingEvent record {|
    string AccountSid;
    string CallSid;
    string RecordingSid;
    string RecordingUrl;
    string RecordingStatus;
    float RecordingDuration;
    int RecordingChanels;
    string RecordingStartTime;
    string RecordingSource;
    string RecordingTrack;
|};


public type TwilioEvent SmsEvent|CallEvent;
