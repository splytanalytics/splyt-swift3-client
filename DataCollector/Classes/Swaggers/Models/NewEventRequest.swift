//
// NewEventRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class NewEventRequest: DataCollectorBaseRequest {

    /** The outcome of the transaction. Can be anything from a code to a word to a boolean depending on your neeeds. Ex: success, 200, invalid, insufficient_funds, etc */
    public var result: String?
    /** Unique transaction ID */
    public var transactionId: String?
    /** The name/type of the transaction */
    public var category: String?

    

    // MARK: JSONEncodable
    override open func encodeToJSON() -> Any {
        var nillableDictionary = super.encodeToJSON() as? [String:Any?] ?? [String:Any?]()
        nillableDictionary["result"] = self.result
        nillableDictionary["transaction_id"] = self.transactionId
        nillableDictionary["category"] = self.category

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
