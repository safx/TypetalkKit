//
//  JSON.swift
//  Swift-idl
//
//  Created by Safx Developer on 2018/04/24.
//  Copyright (c) 2018 Safx Developers. All rights reserved.
//

import Foundation


struct AnyCodingKeys: CodingKey {
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int?

    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}


public enum JSON {
    case null
    case boolean(Bool)
    case number(Double)
    case string(String)
    indirect case array([JSON])
    indirect case object([String:JSON])
}


extension JSON: Decodable {
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: AnyCodingKeys.self) {
            self = JSON(from: container)
        } else if let container = try? decoder.unkeyedContainer() {
            self = JSON(from: container)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "malformed JSON"))
        }
    }

    private init(from container: KeyedDecodingContainer<AnyCodingKeys>) {
        var d: [String: JSON] = [:]
        for key in container.allKeys {
            if let value = try? container.decode(Bool.self, forKey: key) {
                d[key.stringValue] = .boolean(value)
            } else if let value = try? container.decode(Double.self, forKey: key) {
                d[key.stringValue] = .number(value)
            } else if let value = try? container.decode(String.self, forKey: key) {
                d[key.stringValue] = .string(value)
            } else if let value = try? container.nestedContainer(keyedBy: AnyCodingKeys.self, forKey: key) {
                d[key.stringValue] = JSON(from: value)
            } else if let value = try? container.nestedUnkeyedContainer(forKey: key) {
                d[key.stringValue] = JSON(from: value)
            }
        }
        self = .object(d)
    }

    private init(from container: UnkeyedDecodingContainer) {
        var container = container
        var a: [JSON] = []
        while !container.isAtEnd {
            if let value = try? container.decode(Bool.self) {
                a.append(.boolean(value))
            } else if let value = try? container.decode(Double.self) {
                a.append(.number(value))
            } else if let value = try? container.decode(String.self) {
                a.append(.string(value))
            } else if let value = try? container.nestedContainer(keyedBy: AnyCodingKeys.self) {
                a.append(JSON(from: value))
            } else if let value = try? container.nestedUnkeyedContainer() {
                a.append(JSON(from: value))
            }
        }
        self = .array(a)
    }
}


extension JSON: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .array(array):
            try container.encode(array)
        case let .object(object):
            try container.encode(object)
        case let .string(string):
            try container.encode(string)
        case let .number(number):
            try container.encode(number)
        case let .boolean(bool):
            try container.encode(bool)
        case .null:
            try container.encodeNil()
        }
    }
}
