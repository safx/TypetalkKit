//
//  Router.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire


extension Router: URLRequestConvertible {
    private static let baseURLString = "https://typetalk.in/api/v1/"

    public static func makeDownloadAttachment(url: NSURL, attachmentType: AttachmentType? = nil) -> Router? {
        let u = url.absoluteString
        assert(u.hasPrefix(Router.baseURLString))

        let regexp = try! NSRegularExpression(pattern: baseURLString + "topics/(\\d+)/posts/(\\d+)/attachments/(\\d+)/(.+)", options: [])
        let ns = u as NSString
        let ms = regexp.matchesInString(u, options: [], range: NSMakeRange(0, ns.length))

        if ms.count != 1 || regexp.numberOfCaptureGroups != 4 { return .None }
        let m = ms[0]

        guard let topicId      = TopicID     (ns.substringWithRange(m.rangeAtIndex(1))) else { return .None }
        guard let postId       = PostID      (ns.substringWithRange(m.rangeAtIndex(2))) else { return .None }
        guard let attachmentId = AttachmentID(ns.substringWithRange(m.rangeAtIndex(3))) else { return .None }
        let filename           = ns.substringWithRange(m.rangeAtIndex(4))

        return Router.DownloadAttachment(topicId: topicId, postId: postId, attachmentId: attachmentId, filename: filename, type: attachmentType)
    }

    public var URLRequest: NSURLRequest {
        let request = NSMutableURLRequest(URL: (NSURL(string: Router.baseURLString + path))!)
        request.HTTPMethod = method

        if params.isEmpty { return request }
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: params).0
    }

    public func URLRequest(OAuth2Token: String) -> NSURLRequest {
        let request = URLRequest.mutableCopy() as! NSMutableURLRequest
        request.setValue("Bearer \(OAuth2Token)", forHTTPHeaderField: "Authorization")
        return request
    }

    public func URLRequest(OAuth2Token: String, fileName: String, fileContent: NSData) -> NSURLRequest {
        func generateBoundary() -> String {
            let uuid = CFUUIDCreate(nil)
            let uuidString = CFUUIDCreateString(nil, uuid)
            return "Boundary-\(uuidString)"
        }

        let boundary = generateBoundary()

        let head = [
            "--\(boundary)\r\n",
            "Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n",
            "Content-Type: application/octet-stream; charset=ISO-8859-1\r\n",
            "Content-Transfer-Encoding: binary\r\n\r\n",
        ]
        let tail = ["\r\n--\(boundary)--\r\n"]

        let formData = NSMutableData()
        head.map { formData.appendData($0.dataUsingEncoding(NSUTF8StringEncoding)!) }
        formData.appendData(fileContent)
        tail.map { formData.appendData($0.dataUsingEncoding(NSUTF8StringEncoding)!) }

        let request = URLRequest(OAuth2Token).mutableCopy() as! NSMutableURLRequest
        assert(request.HTTPMethod == "POST")

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("\(formData.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = formData

        return request
    }
}


