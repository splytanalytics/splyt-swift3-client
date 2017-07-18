// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject, AnyObject?) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject, AnyObject?) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0, $1) as AnyObject }
    }

    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source, nil) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0, instance: nil) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value, instance: nil)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject, instance: AnyObject?) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return (source as! NSNumber).int32Value as! T
        }
        if T.self is Int64.Type && source is NSNumber {
            return (source as! NSNumber).int64Value as! T
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source, instance) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source, instance: nil)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject, instance: AnyObject?) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int64 {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [BatchRequestResult]
        Decoders.addDecoder(clazz: [BatchRequestResult].self) { (source: AnyObject, instance: AnyObject?) -> [BatchRequestResult] in
            return Decoders.decode(clazz: [BatchRequestResult].self, source: source)
        }
        // Decoder for BatchRequestResult
        Decoders.addDecoder(clazz: BatchRequestResult.self) { (source: AnyObject, instance: AnyObject?) -> BatchRequestResult in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? BatchRequestResult() : instance as! BatchRequestResult
            
            result.code = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["code"] as AnyObject?)
            result.errors = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["errors"] as AnyObject?)
            result.request = Decoders.decodeOptional(clazz: DataCollectorBaseRequest.self, source: sourceDictionary["request"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorBaseRequest]
        Decoders.addDecoder(clazz: [DataCollectorBaseRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorBaseRequest] in
            return Decoders.decode(clazz: [DataCollectorBaseRequest].self, source: source)
        }
        // Decoder for DataCollectorBaseRequest
        Decoders.addDecoder(clazz: DataCollectorBaseRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorBaseRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            // Check discriminator to support inheritance
            if let discriminator = sourceDictionary["request_type"] as? String, instance == nil && discriminator != "DataCollectorBaseRequest" {
                return Decoders.decode(clazz: DataCollectorBaseRequest.self, discriminator: discriminator, source: source)
            }
            let result = instance == nil ? DataCollectorBaseRequest() : instance as! DataCollectorBaseRequest
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorBatchRequest]
        Decoders.addDecoder(clazz: [DataCollectorBatchRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorBatchRequest] in
            return Decoders.decode(clazz: [DataCollectorBatchRequest].self, source: source)
        }
        // Decoder for DataCollectorBatchRequest
        Decoders.addDecoder(clazz: DataCollectorBatchRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorBatchRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorBatchRequest() : instance as! DataCollectorBatchRequest
            
            result.batch = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["batch"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorBeginTransactionRequest]
        Decoders.addDecoder(clazz: [DataCollectorBeginTransactionRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorBeginTransactionRequest] in
            return Decoders.decode(clazz: [DataCollectorBeginTransactionRequest].self, source: source)
        }
        // Decoder for DataCollectorBeginTransactionRequest
        Decoders.addDecoder(clazz: DataCollectorBeginTransactionRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorBeginTransactionRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorBeginTransactionRequest() : instance as! DataCollectorBeginTransactionRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            result.timeout = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["timeout"] as AnyObject?)
            if let timeoutMode = sourceDictionary["timeout_mode"] as? String { 
                result.timeoutMode = DataCollectorBeginTransactionRequest.TimeoutMode(rawValue: (timeoutMode))
            }
            
            result.transactionId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["transaction_id"] as AnyObject?)
            result.category = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["category"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorEndTransactionRequest]
        Decoders.addDecoder(clazz: [DataCollectorEndTransactionRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorEndTransactionRequest] in
            return Decoders.decode(clazz: [DataCollectorEndTransactionRequest].self, source: source)
        }
        // Decoder for DataCollectorEndTransactionRequest
        Decoders.addDecoder(clazz: DataCollectorEndTransactionRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorEndTransactionRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorEndTransactionRequest() : instance as! DataCollectorEndTransactionRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            result.result = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["result"] as AnyObject?)
            result.transactionId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["transaction_id"] as AnyObject?)
            result.category = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["category"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorNewDeviceRequest]
        Decoders.addDecoder(clazz: [DataCollectorNewDeviceRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorNewDeviceRequest] in
            return Decoders.decode(clazz: [DataCollectorNewDeviceRequest].self, source: source)
        }
        // Decoder for DataCollectorNewDeviceRequest
        Decoders.addDecoder(clazz: DataCollectorNewDeviceRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorNewDeviceRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorNewDeviceRequest() : instance as! DataCollectorNewDeviceRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorNewUserRequest]
        Decoders.addDecoder(clazz: [DataCollectorNewUserRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorNewUserRequest] in
            return Decoders.decode(clazz: [DataCollectorNewUserRequest].self, source: source)
        }
        // Decoder for DataCollectorNewUserRequest
        Decoders.addDecoder(clazz: DataCollectorNewUserRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorNewUserRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorNewUserRequest() : instance as! DataCollectorNewUserRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorTuneRequest]
        Decoders.addDecoder(clazz: [DataCollectorTuneRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorTuneRequest] in
            return Decoders.decode(clazz: [DataCollectorTuneRequest].self, source: source)
        }
        // Decoder for DataCollectorTuneRequest
        Decoders.addDecoder(clazz: DataCollectorTuneRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorTuneRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorTuneRequest() : instance as! DataCollectorTuneRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            result.campaignName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["campaign_name"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorUpdateCollectionRequest]
        Decoders.addDecoder(clazz: [DataCollectorUpdateCollectionRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorUpdateCollectionRequest] in
            return Decoders.decode(clazz: [DataCollectorUpdateCollectionRequest].self, source: source)
        }
        // Decoder for DataCollectorUpdateCollectionRequest
        Decoders.addDecoder(clazz: DataCollectorUpdateCollectionRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorUpdateCollectionRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorUpdateCollectionRequest() : instance as! DataCollectorUpdateCollectionRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            result.balance = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["balance"] as AnyObject?)
            result.balanceModification = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["balance_modification"] as AnyObject?)
            result.currency = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["currency"] as AnyObject?)
            result.name = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["name"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorUpdateDeviceStateRequest]
        Decoders.addDecoder(clazz: [DataCollectorUpdateDeviceStateRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorUpdateDeviceStateRequest] in
            return Decoders.decode(clazz: [DataCollectorUpdateDeviceStateRequest].self, source: source)
        }
        // Decoder for DataCollectorUpdateDeviceStateRequest
        Decoders.addDecoder(clazz: DataCollectorUpdateDeviceStateRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorUpdateDeviceStateRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorUpdateDeviceStateRequest() : instance as! DataCollectorUpdateDeviceStateRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorUpdateTransactionRequest]
        Decoders.addDecoder(clazz: [DataCollectorUpdateTransactionRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorUpdateTransactionRequest] in
            return Decoders.decode(clazz: [DataCollectorUpdateTransactionRequest].self, source: source)
        }
        // Decoder for DataCollectorUpdateTransactionRequest
        Decoders.addDecoder(clazz: DataCollectorUpdateTransactionRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorUpdateTransactionRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorUpdateTransactionRequest() : instance as! DataCollectorUpdateTransactionRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            result.progress = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["progress"] as AnyObject?)
            result.transactionId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["transaction_id"] as AnyObject?)
            result.category = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["category"] as AnyObject?)
            return result
        }


        // Decoder for [DataCollectorUpdateUserStateRequest]
        Decoders.addDecoder(clazz: [DataCollectorUpdateUserStateRequest].self) { (source: AnyObject, instance: AnyObject?) -> [DataCollectorUpdateUserStateRequest] in
            return Decoders.decode(clazz: [DataCollectorUpdateUserStateRequest].self, source: source)
        }
        // Decoder for DataCollectorUpdateUserStateRequest
        Decoders.addDecoder(clazz: DataCollectorUpdateUserStateRequest.self) { (source: AnyObject, instance: AnyObject?) -> DataCollectorUpdateUserStateRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? DataCollectorUpdateUserStateRequest() : instance as! DataCollectorUpdateUserStateRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            return result
        }


        // Decoder for [NewEventRequest]
        Decoders.addDecoder(clazz: [NewEventRequest].self) { (source: AnyObject, instance: AnyObject?) -> [NewEventRequest] in
            return Decoders.decode(clazz: [NewEventRequest].self, source: source)
        }
        // Decoder for NewEventRequest
        Decoders.addDecoder(clazz: NewEventRequest.self) { (source: AnyObject, instance: AnyObject?) -> NewEventRequest in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? NewEventRequest() : instance as! NewEventRequest
            if decoders["\(DataCollectorBaseRequest.self)"] != nil {
              _ = Decoders.decode(clazz: DataCollectorBaseRequest.self, source: source, instance: result)
            }
            
            result.deviceId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_id"] as AnyObject?)
            result.eventProperties = Decoders.decodeOptional(clazz: Any.self, source: sourceDictionary["event_properties"] as AnyObject?)
            result.eventTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["event_timestamp"] as AnyObject?)
            result.requestType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["request_type"] as AnyObject?)
            result.sendTimestamp = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["send_timestamp"] as AnyObject?)
            result.userId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["user_id"] as AnyObject?)
            result.result = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["result"] as AnyObject?)
            result.transactionId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["transaction_id"] as AnyObject?)
            result.category = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["category"] as AnyObject?)
            return result
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}