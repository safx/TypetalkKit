//
//  Embed.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/04/07.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Embed : Deserializable, ObjcBase {
    public let type: String
    public let version: Float
    public let providerName: String
    public let providerURL: NSURL?
    public let title: String
    public let authorName: String
    public let authorURL: NSURL?
    public let html: String
    public let width: Int
    public let height: Int

    public init(type: String = "", version: Float = 0.0, providerName: String = "", providerURL: NSURL? = nil, title: String = "", authorName: String = "", authorURL: NSURL? = nil, html: String = "", width: Int = 0, height: Int = 0) {
        self.type = type
        self.version = version
        self.providerName = providerName
        self.providerURL = providerURL
        self.title = title
        self.authorName = authorName
        self.authorURL = authorURL
        self.html = html
        self.width = width
        self.height = height
    }

    required public convenience init(data: [String: AnyObject]) {
        var type: String?
        var version: Float?
        var providerName: String?
        var providerURL: NSURL?
        var title: String?
        var authorName: String?
        var authorURL: NSURL?
        var html: String?
        var width: Int?
        var height: Int?

        type         <-- data["type"]
        version      <-- data["version"]
        providerName <-- data["provider_name"]
        providerURL  <-- data["provider_url"]
        title        <-- data["title"]
        authorName   <-- data["author_name"]
        authorURL    <-- data["author_url"]
        html         <-- data["html"]
        width        <-- data["width"]
        height       <-- data["height"]

        self.init(type: type ?? "", version: version ?? 0, providerName: providerName ?? "", providerURL: providerURL, title: title ?? "", authorName: authorName ?? "", authorURL: authorURL, html: html ?? "", width: width ?? 0, height: height ?? 0)
    }
}
