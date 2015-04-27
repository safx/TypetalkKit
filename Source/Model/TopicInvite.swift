//
//  TopicInvite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TopicInvite: Invite, Deserializable, ObjcBase {
    public let topic: Topic

    public required init(topic: Topic = Topic()) {
        self.topic = topic
    }

    required public convenience init(data: [String: AnyObject]) {
        // super.init(data: data)
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

        var topic: Topic?
        topic <-- data["topic"]

        self.init(id: id ?? 0, sender: sender ?? Account(), account: account, message: message ?? "", createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate(), mailAddress: mailAddress, status: status ?? "", topic: topic ?? Topic())
    }

    public init(id: InviteID, sender: Account, account: Account?, message: String, createdAt: NSDate, updatedAt: NSDate, mailAddress: String?, status: String, topic: Topic = Topic()) {
        self.topic = topic
        super.init(id: id, sender: sender, account: account, message: message, createdAt: createdAt, updatedAt: updatedAt, mailAddress: mailAddress, status: status)
    }
}
