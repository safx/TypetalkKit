//
//  Request+Addition.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit
import Result

public protocol TypetalkRequest: APIKitRequest {}
public protocol AuthRequest: APIKitRequest {}


extension APIKitRequest {
    public var bodyParameters: BodyParameters? {
        let ps = self.parameters as? [String: AnyObject] ?? [:]
        return FormURLArrayEncodedBodyParameters(formObject: ps, encoding: String.Encoding.utf8)
    }
}

extension TypetalkRequest {
    public var baseURL: URL { return URL(string: TypetalkAPI.apiURLString)! }
}

extension AuthRequest {
    public var baseURL: URL { return URL(string: TypetalkAPI.authURLString)! }
}

extension APIKitRequest {
    fileprivate func rewriteListParameter(urlRequest: URLRequest, parameter: String) throws -> URLRequest {
        let URL = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: URL, resolvingAgainstBaseURL: true) else {
            throw RequestError.invalidBaseURL(baseURL)
        }
        
        if let p = parameters as? [String:Any], let postIds = p[parameter] as? [Int], postIds.count > 0 {
            components.query = postIds.map { (e) -> String in
                return parameter + "[]=" + e.description
            }.joined(separator: "&")
        }
        
        var newRequest = urlRequest
        newRequest.url = components.url
        return newRequest
    }
}

extension RemoveMessageFromTalk {
    public func intercept(urlRequest: URLRequest) throws -> URLRequest {
        return try rewriteListParameter(urlRequest: urlRequest, parameter: "postIds")
    }
}

extension GetOnlineStatus {
    public func intercept(urlRequest: URLRequest) throws -> URLRequest {
        return try rewriteListParameter(urlRequest: urlRequest, parameter: "accountIds")
    }
}

extension DownloadAttachment {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Data {
        guard let obj = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return obj as DownloadAttachment.APIKitResponse
    }

    public var bodyParameters: BodyParameters? {
        return nil
    }

    public typealias DataParser = NullDataParser
    public var dataParser: DataParser {
        return NullDataParser()
    }

    public convenience init?(url: URL, attachmentType: AttachmentType? = nil) {
        let u = url.absoluteString
        precondition(u.hasPrefix(TypetalkAPI.apiURLString))

        let regexp = try! NSRegularExpression(pattern: TypetalkAPI.apiURLString + "v1/topics/(\\d+)/posts/(\\d+)/attachments/(\\d+)/(.+)", options: [])
        let ns = u as NSString
        let ms = regexp.matches(in: u, options: [], range: NSMakeRange(0, ns.length))

        guard ms.count == 1 && regexp.numberOfCaptureGroups == 4 else { return nil }
        let m = ms[0]

#if os(macOS)
        guard let topicId      = TopicID     (ns.substring(with: m.range(at: 1))) else { return nil }
        guard let postId       = PostID      (ns.substring(with: m.range(at: 2))) else { return nil }
        guard let attachmentId = AttachmentID(ns.substring(with: m.range(at: 3))) else { return nil }
        let filename           = ns.substring(with: m.range(at: 4))
#else
        guard let topicId      = TopicID     (ns.substring(with: m.range(at: 1))) else { return nil }
        guard let postId       = PostID      (ns.substring(with: m.range(at: 2))) else { return nil }
        guard let attachmentId = AttachmentID(ns.substring(with: m.range(at: 3))) else { return nil }
        let filename           = ns.substring(with: m.range(at: 4))
#endif
        self.init(topicId: topicId, postId: postId, attachmentId: attachmentId, filename: filename, type: attachmentType)
    }
}

extension UploadAttachment {
    public var bodyParameters: BodyParameters? {
        return MultipartFormDataBodyParameters(parts: [MultipartFormDataBodyParameters.Part(data: self.file as Data, name: "FIXME: self.name")])
    }
}

// Helper funcs

open class RawDataParser: DataParser {
    open var contentType: String? {
        return nil
    }

    open func parse(data: Data) throws -> Any {
        return data as Any
    }
}

public struct FormURLArrayEncodedBodyParameters: BodyParameters {
    public let form: [String: AnyObject]
    public let encoding: String.Encoding

    public init(formObject: [String: AnyObject], encoding: String.Encoding = String.Encoding.utf8) {
        self.form = formObject
        self.encoding = encoding
    }

    public var contentType: String {
        return "application/x-www-form-urlencoded"
    }

    public func buildEntity() throws -> RequestBodyEntity {
        return .data(try dataFromObject(form, encoding: encoding))
    }
}

private func dataFromObject(_ object: [String: AnyObject], encoding: String.Encoding) throws -> Data {
    let string = stringFromDictionary(object)
    guard let data = string.data(using: encoding, allowLossyConversion: false) else {
        throw URLEncodedSerialization.Error.cannotGetDataFromString(string, encoding)
    }
    return data
}

private func escape(_ string: String) -> String {
    // Reserved characters defined by RFC 3986
    // Reference: https://www.ietf.org/rfc/rfc3986.txt
    let generalDelimiters = ":/?#[]@"
    let subDelimiters = "!$&'()*+,;="
    let reservedCharacters = generalDelimiters + subDelimiters

    let allowedCharacterSet = NSMutableCharacterSet()
    allowedCharacterSet.formUnion(with: CharacterSet.urlQueryAllowed)
    allowedCharacterSet.removeCharacters(in: reservedCharacters)

    return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet) ?? string
}

private func stringFromDictionary(_ dictionary: [String:AnyObject]) -> String {
    let pairs = dictionary.map { key, value -> String in
        if value is NSNull {
            return "\(escape(key))"
        }

        if let arr = value as? [AnyObject] {
            return arr.map { (e) -> String in
                let valueAsString = (e as? String) ?? "\(e)"
                return "\(escape(key + "[]"))=\(escape(valueAsString))"
            }.joined(separator: "&")
        }

        let valueAsString = (value as? String) ?? "\(value)"
        return "\(escape(key))=\(escape(valueAsString))"
    }

    return pairs.joined(separator: "&")
}
