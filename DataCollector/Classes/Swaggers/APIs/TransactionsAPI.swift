//
// TransactionsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



open class TransactionsAPI: APIBase {
    /**
     Begins a new transaction
     
     - parameter customerId: (query) customerId 
     - parameter request: (body) Transaction initiation information (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func beginTransaction(customerId: String, request: DataCollectorBeginTransactionRequest? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        beginTransactionWithRequestBuilder(customerId: customerId, request: request).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Begins a new transaction
     - POST /v2/transactions
     - Use the event properties to describe the initial state of the transaction
     
     - parameter customerId: (query) customerId 
     - parameter request: (body) Transaction initiation information (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func beginTransactionWithRequestBuilder(customerId: String, request: DataCollectorBeginTransactionRequest? = nil) -> RequestBuilder<Void> {
        let path = "/v2/transactions"
        let URLString = DataCollectorAPI.basePath + path
        let parameters = request?.encodeToJSON() as? [String:AnyObject]

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "customerId": customerId
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = DataCollectorAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Ends the transaction
     
     - parameter id: (path) Unique ID of the transaction being finalized 
     - parameter customerId: (query) customerId 
     - parameter request: (body) Transaction finalization information (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func endTransaction(id: String, customerId: String, request: DataCollectorEndTransactionRequest? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        endTransactionWithRequestBuilder(id: id, customerId: customerId, request: request).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Ends the transaction
     - PUT /v2/transactions/{id}/end
     - Submits final transaction state to Knetik.io
     
     - parameter id: (path) Unique ID of the transaction being finalized 
     - parameter customerId: (query) customerId 
     - parameter request: (body) Transaction finalization information (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func endTransactionWithRequestBuilder(id: String, customerId: String, request: DataCollectorEndTransactionRequest? = nil) -> RequestBuilder<Void> {
        var path = "/v2/transactions/{id}/end"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = DataCollectorAPI.basePath + path
        let parameters = request?.encodeToJSON() as? [String:AnyObject]

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "customerId": customerId
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = DataCollectorAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Creates and finalizes a collection of transaction information
     
     - parameter customerId: (query) customerId 
     - parameter request: (body) Collection state information (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateCollection(customerId: String, request: DataCollectorUpdateCollectionRequest? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        updateCollectionWithRequestBuilder(customerId: customerId, request: request).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Creates and finalizes a collection of transaction information
     - POST /v2/collections
     - This operation basically encapsulates beginTransaction and endTransaction semantics into a single step and is used to update user balance information in Knetik.io
     
     - parameter customerId: (query) customerId 
     - parameter request: (body) Collection state information (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func updateCollectionWithRequestBuilder(customerId: String, request: DataCollectorUpdateCollectionRequest? = nil) -> RequestBuilder<Void> {
        let path = "/v2/collections"
        let URLString = DataCollectorAPI.basePath + path
        let parameters = request?.encodeToJSON() as? [String:AnyObject]

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "customerId": customerId
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = DataCollectorAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Updates the progress for the given transaction
     
     - parameter id: (path) Unique ID of the transaction being updated 
     - parameter customerId: (query) customerId 
     - parameter request: (body) Transaction progress information (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateTransaction(id: String, customerId: String, request: DataCollectorUpdateTransactionRequest? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        updateTransactionWithRequestBuilder(id: id, customerId: customerId, request: request).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Updates the progress for the given transaction
     - PUT /v2/transactions/{id}
     - Use the event properties to update the state of the transaction
     
     - parameter id: (path) Unique ID of the transaction being updated 
     - parameter customerId: (query) customerId 
     - parameter request: (body) Transaction progress information (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func updateTransactionWithRequestBuilder(id: String, customerId: String, request: DataCollectorUpdateTransactionRequest? = nil) -> RequestBuilder<Void> {
        var path = "/v2/transactions/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = DataCollectorAPI.basePath + path
        let parameters = request?.encodeToJSON() as? [String:AnyObject]

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "customerId": customerId
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = DataCollectorAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}