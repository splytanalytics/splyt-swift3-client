//
// DataCollectorEndTransactionRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class DataCollectorEndTransactionRequest: JSONEncodable {
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
    /** The outcome of the transaction. Can be anything from a code to a word to a boolean depending on your neeeds. Ex: success, 200, invalid, insufficient_funds, etc */
    public var result: String?
    /** Epoch timestamp &lt;i&gt;in milliseconds&lt;/i&gt; of when event was sent to the API */
    public var sendTimestamp: Int64?
    /** Unique transaction ID */
    public var transactionId: String?
    /** Unique ID of the user triggering the event */
    public var userId: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["category"] = self.category
        nillableDictionary["deviceId"] = self.deviceId
        nillableDictionary["eventProperties"] = self.eventProperties
        nillableDictionary["eventTimestamp"] = self.eventTimestamp?.encodeToJSON()
        nillableDictionary["requestType"] = self.requestType
        nillableDictionary["result"] = self.result
        nillableDictionary["sendTimestamp"] = self.sendTimestamp?.encodeToJSON()
        nillableDictionary["transactionId"] = self.transactionId
        nillableDictionary["userId"] = self.userId
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
