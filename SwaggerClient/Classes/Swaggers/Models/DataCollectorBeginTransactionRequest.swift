//
// DataCollectorBeginTransactionRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class DataCollectorBeginTransactionRequest: JSONEncodable {
    public enum TimeoutMode: String { 
        case txn = "TXN"
        case any = "ANY"
    }
    /** The name/type of the transaction */
    public var category: String?
    /** Unique ID of the device triggering the event */
    public var deviceId: String?
    /** A key/value list of properties for this event. Values can be numerical, strings or booleans, proper typing matters (quoted vs unquoted) */
    public var eventProperties: Any?
    /** Epoch timestamp &lt;i&gt;in milliseconds&lt;/i&gt; of when event itself occurred */
    public var eventTimestamp: Int64?
    /** Specifies the canonical model name of the request. Ex: DataCollectorNewUserRequest -&gt; newUser, NewEventRequest -&gt; newEvent,e tc */
    public var requestType: String?
    /** Epoch timestamp &lt;i&gt;in milliseconds&lt;/i&gt; of when event was sent to the API */
    public var sendTimestamp: Int64?
    /** Timeout (in seconds) for the transaction */
    public var timeout: Int32?
    /** Timeout mode for the transaction. With TXN, the timeout is reset when an update is posted to the same transaction. With ANY, the timeout is reset when an update is posted for any transaction w/ the same user/device */
    public var timeoutMode: TimeoutMode?
    /** Unique transaction ID */
    public var transactionId: String?
    /** Unique ID of the user triggering the event */
    public var userId: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["category"] = self.category
        nillableDictionary["device_id"] = self.deviceId
        nillableDictionary["event_properties"] = self.eventProperties
        nillableDictionary["event_timestamp"] = self.eventTimestamp?.encodeToJSON()
        nillableDictionary["request_type"] = self.requestType
        nillableDictionary["send_timestamp"] = self.sendTimestamp?.encodeToJSON()
        nillableDictionary["timeout"] = self.timeout?.encodeToJSON()
        nillableDictionary["timeout_mode"] = self.timeoutMode?.rawValue
        nillableDictionary["transaction_id"] = self.transactionId
        nillableDictionary["user_id"] = self.userId
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}