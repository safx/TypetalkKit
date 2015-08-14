//
//  Request+Addition.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit


public protocol TypetalkRequest: APIKitRequest {}
public protocol AuthRequest: APIKitRequest {}

extension APIKitRequest {
    public var requestBodyBuilder: RequestBodyBuilder {
        return .URL(encoding: NSUTF8StringEncoding)
    }
}

extension TypetalkRequest {
    public var baseURL: NSURL { return NSURL(string: TypetalkAPI.apiURLString)! }
}

extension AuthRequest {
    public var baseURL: NSURL { return NSURL(string: TypetalkAPI.authURLString)! }
}

extension DownloadAttachment {
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        fatalError("Not implement yet")
    }

    public static func makeDownloadAttachment(url: NSURL, attachmentType: AttachmentType? = nil) -> DownloadAttachment? {
        let u = url.absoluteString
        assert(u.hasPrefix(TypetalkAPI.apiURLString))

        let regexp = try! NSRegularExpression(pattern: TypetalkAPI.apiURLString + "topics/(\\d+)/posts/(\\d+)/attachments/(\\d+)/(.+)", options: [])
        let ns = u as NSString
        let ms = regexp.matchesInString(u, options: [], range: NSMakeRange(0, ns.length))

        if ms.count != 1 || regexp.numberOfCaptureGroups != 4 { return .None }
        let m = ms[0]

        guard let topicId      = TopicID     (ns.substringWithRange(m.rangeAtIndex(1))) else { return .None }
        guard let postId       = PostID      (ns.substringWithRange(m.rangeAtIndex(2))) else { return .None }
        guard let attachmentId = AttachmentID(ns.substringWithRange(m.rangeAtIndex(3))) else { return .None }
        let filename           = ns.substringWithRange(m.rangeAtIndex(4))

        return DownloadAttachment(topicId: topicId, postId: postId, attachmentId: attachmentId, filename: filename, type: attachmentType)
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
        head.map { data.appendData($0.dataUsingEncoding(NSUTF8StringEncoding)!) }
        data.appendData(self.contents)
        tail.map { data.appendData($0.dataUsingEncoding(NSUTF8StringEncoding)!) }

        return data
    }

    private func createBoundary() -> String {
        let uuid = CFUUIDCreate(nil)
        let uuidString = CFUUIDCreateString(nil, uuid)
        return "Boundary-\(uuidString)"
    }

}
