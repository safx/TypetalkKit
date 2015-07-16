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

    /*static func makeDownloadAttachmen(url: String) -> Router {
        let u = url.absoluteString
        assert(u.hasPrefix(Router2.baseURLString))
        let len = Router2.baseURLString.characters.count
        let s = u.substringFromIndex(advance(u.startIndex, len))
        return (.GET, .topic_read, "\(s)")
    }*/

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


