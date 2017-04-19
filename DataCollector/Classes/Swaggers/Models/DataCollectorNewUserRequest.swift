//
// DataCollectorNewUserRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class DataCollectorNewUserRequest: JSONEncodable {
    /** Unique ID of the device triggering the event */
    public var deviceId: String?
    /** A key/value list of properties for this event. Values can be numerical, strings or booleans, proper typing matters (quoted vs unquoted) */
    public var eventProperties: Any?
    /** Epoch timestamp &lt;i&gt;in milliseconds&lt;/i&gt; of when event itself occurred */
    public var eventTimestamp: Int64?
    /** Specifies the canonical model name of the request. Ex: DataCollectorNewUserRequest - newUser, NewEventRequest - newEvent,e tc */
    public var requestType: String?
    /** Epoch timestamp &lt;i&gt;in milliseconds&lt;/i&gt; of when event was sent to the API */
    public var sendTimestamp: Int64?
    /** Unique ID of the new user */
    public var userId: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["deviceId"] = self.deviceId
        nillableDictionary["eventProperties"] = self.eventProperties
        nillableDictionary["eventTimestamp"] = self.eventTimestamp?.encodeToJSON()
        nillableDictionary["requestType"] = self.requestType
        nillableDictionary["sendTimestamp"] = self.sendTimestamp?.encodeToJSON()
        nillableDictionary["userId"] = self.userId
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
