//
//  Invite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Invite : Deserializable, ObjcBase {
    public let id: InviteID
    public let sender: Account
    public let account: Account?
    public let message: String
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public let mailAddress: String?
    public let status: String

    public init(id: InviteID = 0, sender: Account = Account(), account: Account? = nil, message: String = "", createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate(), mailAddress: String? = nil, status: String = "") {
        self.id = id
        self.sender = sender
        self.account = account
        self.message = message
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.mailAddress = mailAddress
        self.status = status
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: InviteID?
        var sender: Account?
        var account: Account?
        var message: String?
        var createdAt: NSDate?
        var updatedAt: NSDate?
        var mailAddress: String?
        var status: String?

        id          <-- data["id"]
        sender      <-- data["sender"]
        account     <-- data["account"]
        message     <-- data["message"]
        createdAt   <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt   <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        mailAddress <-- data["mailAddress"]
        status      <-- data["status"]

        self.init(id: id ?? 0, sender: sender ?? Account(), account: account, message: message ?? "", createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate(), mailAddress: mailAddress, status: status ?? "")
    }
}
