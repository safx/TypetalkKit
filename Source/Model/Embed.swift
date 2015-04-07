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
    public let type: String = ""
    public let version: Float = 0.0
    public let providerName: String = ""
    public let providerURL: NSURL?
    public let title: String = ""
    public let authorName: String = ""
    public let authorURL: NSURL?
    public let html: String = ""
    public let width: Int = 0
    public let height: Int = 0

    required public init() {}

    required public init(data: [String: AnyObject]) {
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
    }
}
