struct event {
    1: required string timestamp, #timestamp as iso8601
    2: required string version,
    3: optional string host,
    4: optional string message
}
