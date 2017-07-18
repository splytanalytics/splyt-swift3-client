//
// DataCollectorBeginTransactionRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class DataCollectorBeginTransactionRequest: DataCollectorBaseRequest {

    public enum TimeoutMode: String { 
        case txn = "TXN"
        case any = "ANY"
    }
    /** Timeout (in seconds) for the transaction */
    public var timeout: Int32?
    /** Timeout mode for the transaction. With TXN, the timeout is reset when an update is posted to the same transaction. With ANY, the timeout is reset when an update is posted for any transaction w/ the same user/device */
    public var timeoutMode: TimeoutMode?
    /** Unique transaction ID */
    public var transactionId: String?
    /** The name/type of the transaction */
    public var category: String?

    

    // MARK: JSONEncodable
    override open func encodeToJSON() -> Any {
        var nillableDictionary = super.encodeToJSON() as? [String:Any?] ?? [String:Any?]()
        nillableDictionary["timeout"] = self.timeout?.encodeToJSON()
        nillableDictionary["timeout_mode"] = self.timeoutMode?.rawValue
        nillableDictionary["transaction_id"] = self.transactionId
        nillableDictionary["category"] = self.category

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}