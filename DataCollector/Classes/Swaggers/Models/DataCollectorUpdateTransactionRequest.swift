//
// DataCollectorUpdateTransactionRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class DataCollectorUpdateTransactionRequest: DataCollectorBaseRequest {

    /** Progress of the transaction, expressed as a percentage between 1 - 99 */
    public var progress: Int32?
    /** Unique transaction ID */
    public var transactionId: String?
    /** The name/type of the transaction */
    public var category: String?

    

    // MARK: JSONEncodable
    override open func encodeToJSON() -> Any {
        var nillableDictionary = super.encodeToJSON() as? [String:Any?] ?? [String:Any?]()
        nillableDictionary["progress"] = self.progress?.encodeToJSON()
        nillableDictionary["transaction_id"] = self.transactionId
        nillableDictionary["category"] = self.category

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
