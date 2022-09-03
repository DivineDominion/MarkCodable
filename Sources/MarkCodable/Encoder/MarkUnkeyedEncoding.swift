//
//  File.swift
//  
//
//  Created by Marin Todorov on 9/2/22.
//

import Foundation

struct MarkUnkeyedEncoding: UnkeyedEncodingContainer {
    private(set) var codingPath: CodingPath
    var userInfo = UserInfo()
    private(set) var data = CodingData()

    var count: Int { data.values.count }
    //var key: CodingKey { IndexCodingKey(intValue: count)! }

    init(codingPath: CodingPath, userInfo: UserInfo, to data: CodingData) {
        self.codingPath = codingPath
        self.userInfo = userInfo
        self.data = data
    }

    mutating func encodeNil() throws {
        data.encode(key: codingPath, value: "nil")
    }

    mutating func encode(_ value: Bool) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: String) throws {
        data.encode(key: codingPath, value: value)
    }

    mutating func encode(_ value: Double) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: Float) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: Int) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: Int8) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: Int16) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: Int32) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: Int64) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: UInt) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: UInt8) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: UInt16) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: UInt32) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode(_ value: UInt64) throws {
        data.encode(key: codingPath, value: String(value))
    }

    mutating func encode<T>(_ value: T) throws where T : Encodable {
        let markEncoding = MarkEncoding(codingPath: codingPath, userInfo: userInfo, to: data)

        switch value {
        case let url as URL:
            // Encode URLs as plain absolute URLs
            data.encode(key: codingPath, value: url.absoluteString, appending: true)
        default:
            data.isAppendingContainer.push(true)
            defer { data.isAppendingContainer.pop() }

            try value.encode(to: markEncoding)
        }
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        // TODO: nested containers in lists, unsupported
        fatalError()
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        // TODO: list in list, unsupported
        fatalError()
    }

    mutating func superEncoder() -> Encoder {
        MarkEncoding(codingPath: codingPath, userInfo: userInfo, to: data)
    }
}
