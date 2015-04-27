//
//  GetTalksResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetTalksResponse : Deserializable, ObjcBase {
    public let talks: [Talk]
    
    public required init(talks: [Talk] = []) {
        self.talks = talks
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var talks: [Talk]?
        talks <-- data["talks"]
        self.init(talks: talks ?? [])

    }
}
