//
//  Invite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Invite : Deserializable, ObjcBase {
    public let id: InviteID = 0
    public let sender: Account = Account()
    public let account: Account? = nil
    public let message: String = ""
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()

    public let mailAddress: String? = nil
    public let status: String = ""

    public required init() {}

    required public init(data: [String: AnyObject]) {
        id          <<<  data["id"]
        sender      <<<< data["sender"]
        account     <<<< data["account"]
        message     <<<  data["message"]
        createdAt   <<< (value: data["createdAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt   <<< (value: data["updatedAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
        mailAddress <<<  data["mailAddress"]
        status      <<<  data["status"]
    }
}
