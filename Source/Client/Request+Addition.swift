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
    public var requestBodyBuilder: RequestBodyBuilder {
        return .Custom(contentTypeHeader: "application/x-www-form-urlencoded", buildBodyFromObject: { try dataFromObject($0, encoding: NSUTF8StringEncoding) } )
    }
}

extension TypetalkRequest {
    public var baseURL: NSURL { return NSURL(string: TypetalkAPI.apiURLString)! }
}

extension AuthRequest {
    public var baseURL: NSURL { return NSURL(string: TypetalkAPI.authURLString)! }
}

extension RemoveMessageFromTalk {
    // NOTE: Current APIKit imprementation doesn't allow to set to payload body on a DELETE request.
    //       So we override `buildURLRequest` method from APIKit directly for customizing behavior.
    public func buildURLRequest() -> Result<NSURLRequest, APIError> {
        let URL = path.isEmpty ? baseURL : baseURL.URLByAppendingPathComponent(path)
        guard let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: true) else {
            return .Failure(.InvalidBaseURL(baseURL))
        }

        let URLRequest = NSMutableURLRequest()
        let parameters = self.parameters

        do {
            URLRequest.HTTPBody = try requestBodyBuilder.buildBodyFromObject(parameters)
            URLRequest.setValue(requestBodyBuilder.contentTypeHeader, forHTTPHeaderField: "Content-Type")
        } catch {
            return .Failure(.RequestBodySerializationError(error))
        }

        URLRequest.URL = components.URL
        URLRequest.HTTPMethod = method.rawValue
        URLRequest.setValue(responseBodyParser.acceptHeader, forHTTPHeaderField: "Accept")

        HTTPHeaderFields.forEach { key, value in
            URLRequest.setValue(value, forHTTPHeaderField: key)
        }

        do {
            try configureURLRequest(URLRequest)
        } catch {
            return .Failure(.ConfigurationError(error))
        }

        return .Success(URLRequest)
    }
}

extension DownloadAttachment {
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> APIKitResponse? {
        return object as? NSData
    }

    public var responseBodyParser: ResponseBodyParser {
        return .Custom(acceptHeader: "application/octet-stream", parseData: { $0 })
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

    public var requestBodyBuilder: RequestBodyBuilder {
        let boundary = createBoundary()

        return .Custom(contentTypeHeader: "multipart/form-data; boundary=\(boundary)", buildBodyFromObject: { (object: AnyObject) throws -> NSData in
            return self.createFormData(boundary)
        })
    }

    private func createFormData(boundary: String) -> NSData {
        let head = [
            "--\(boundary)\r\n",
            "Content-Disposition: form-data; name=\"file\"; filename=\"\(self.name)\"\r\n",
            "Content-Type: application/octet-stream; charset=ISO-8859-1\r\n",
            "Content-Transfer-Encoding: binary\r\n\r\n",
        ]
        let tail = ["\r\n--\(boundary)--\r\n"]

        let data = NSMutableData()
        head.forEach { data.appendData($0.dataUsingEncoding(NSUTF8StringEncoding)!) }
        data.appendData(self.contents)
        tail.forEach { data.appendData($0.dataUsingEncoding(NSUTF8StringEncoding)!) }

        return data
    }

    private func createBoundary() -> String {
        let uuid = CFUUIDCreate(nil)
        let uuidString = CFUUIDCreateString(nil, uuid)
        return "Boundary-\(uuidString)"
    }
}

// APIKit
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

internal func dataFromObject(object: AnyObject, encoding: NSStringEncoding) throws -> NSData {
    guard let dictionary = object as? [String:AnyObject] else {
        throw URLEncodedSerialization.Error.CannotCastObjectToDictionary(object)
    }
    let string = stringFromDictionary(dictionary)
    guard let data = string.dataUsingEncoding(encoding, allowLossyConversion: false) else {
        throw URLEncodedSerialization.Error.CannotGetDataFromString(string, encoding)
    }

    return data
}

internal func stringFromDictionary(dictionary: [String:AnyObject]) -> String {
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
