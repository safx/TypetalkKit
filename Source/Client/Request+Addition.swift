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
    public var bodyParameters: BodyParametersType? {
        let ps = self.parameters as? [String: AnyObject] ?? [:]
        return FormURLArrayEncodedBodyParameters(formObject: ps, encoding: NSUTF8StringEncoding)
    }
}

extension TypetalkRequest {
    public var baseURL: NSURL { return NSURL(string: TypetalkAPI.apiURLString)! }
}

extension AuthRequest {
    public var baseURL: NSURL { return NSURL(string: TypetalkAPI.authURLString)! }
}

extension RemoveMessageFromTalk {
    // force rewrite URL
    public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
        let URL = path.isEmpty ? baseURL : baseURL.URLByAppendingPathComponent(path)
        guard let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: true) else {
            throw RequestError.InvalidBaseURL(baseURL)
        }

        let ps = parameters as? [String: AnyObject] ?? [:]
        if let postIds = ps["postIds"] as? [Int] where postIds.count > 0 {
            components.query = postIds.map { (e) -> String in
                return "postIds[]=\(e)"
            }.joinWithSeparator("&")
        }

        URLRequest.URL = components.URL
        return URLRequest
    }
}

extension DownloadAttachment {
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> APIKitResponse {
        guard let obj = object as? NSData else {
            throw ResponseError.UnexpectedObject(object)
        }
        return obj
    }

    public var bodyParameters: BodyParametersType? {
        return nil
    }

    public var dataParser: DataParserType {
        return RawDataParser()
    }

    public convenience init?(url: NSURL, attachmentType: AttachmentType? = nil) {
        let u = url.absoluteString
        assert(u.hasPrefix(TypetalkAPI.apiURLString))

        let regexp = try! NSRegularExpression(pattern: TypetalkAPI.apiURLString + "topics/(\\d+)/posts/(\\d+)/attachments/(\\d+)/(.+)", options: [])
        let ns = u as NSString
        let ms = regexp.matchesInString(u, options: [], range: NSMakeRange(0, ns.length))

        guard ms.count == 1 && regexp.numberOfCaptureGroups == 4 else { return nil }
        let m = ms[0]

        guard let topicId      = TopicID     (ns.substringWithRange(m.rangeAtIndex(1))) else { return nil }
        guard let postId       = PostID      (ns.substringWithRange(m.rangeAtIndex(2))) else { return nil }
        guard let attachmentId = AttachmentID(ns.substringWithRange(m.rangeAtIndex(3))) else { return nil }
        let filename           = ns.substringWithRange(m.rangeAtIndex(4))

        self.init(topicId: topicId, postId: postId, attachmentId: attachmentId, filename: filename, type: attachmentType)
    }
}

extension UploadAttachment {
    public var bodyParameters: BodyParametersType? {
        return MultipartFormDataBodyParameters(parts: [MultipartFormDataBodyParameters.Part(data: self.contents, name: self.name)])
    }
}

// Helper funcs

public class RawDataParser: DataParserType {
    public var contentType: String? {
        return nil
    }

    public func parseData(data: NSData) throws -> AnyObject {
        return data
    }
}

public struct FormURLArrayEncodedBodyParameters: BodyParametersType {
    public let form: [String: AnyObject]
    public let encoding: NSStringEncoding

    public init(formObject: [String: AnyObject], encoding: NSStringEncoding = NSUTF8StringEncoding) {
        self.form = formObject
        self.encoding = encoding
    }

    public var contentType: String {
        return "application/x-www-form-urlencoded"
    }

    public func buildEntity() throws -> RequestBodyEntity {
        return .Data(try dataFromObject(form, encoding: encoding))
    }
}

private func dataFromObject(object: [String: AnyObject], encoding: NSStringEncoding) throws -> NSData {
    let string = stringFromDictionary(object)
    guard let data = string.dataUsingEncoding(encoding, allowLossyConversion: false) else {
        throw URLEncodedSerialization.Error.CannotGetDataFromString(string, encoding)
    }
    return data
}

private func escape(string: String) -> String {
    // Reserved characters defined by RFC 3986
    // Reference: https://www.ietf.org/rfc/rfc3986.txt
    let generalDelimiters = ":/?#[]@"
    let subDelimiters = "!$&'()*+,;="
    let reservedCharacters = generalDelimiters + subDelimiters

    let allowedCharacterSet = NSMutableCharacterSet()
    allowedCharacterSet.formUnionWithCharacterSet(NSCharacterSet.URLQueryAllowedCharacterSet())
    allowedCharacterSet.removeCharactersInString(reservedCharacters)

    return string.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? string
}

private func stringFromDictionary(dictionary: [String:AnyObject]) -> String {
    let pairs = dictionary.map { key, value -> String in
        if value is NSNull {
            return "\(escape(key))"
        }

        if let arr = value as? [AnyObject] {
            return arr.map { (e) -> String in
                let valueAsString = (e as? String) ?? "\(e)"
                return "\(escape(key + "[]"))=\(escape(valueAsString))"
            }.joinWithSeparator("&")
        }

        let valueAsString = (value as? String) ?? "\(value)"
        return "\(escape(key))=\(escape(valueAsString))"
    }

    return pairs.joinWithSeparator("&")
}
