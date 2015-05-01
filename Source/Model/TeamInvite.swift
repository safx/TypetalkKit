//
//  TeamInvite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TeamInvite: Invite, Deserializable, ObjcBase {
    public let team: Team
    public let role: String
    
    public init(team: Team = Team(), role: String = "") {
        self.team = team
        self.role = role
    }
    
    public convenience required init(data: [String: AnyObject]) {
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

        var team: Team?
        var role: String?

        team <-- data["team"]
        role <-- data["role"]

        self.init(id: id ?? 0, sender: sender ?? Account(), account: account, message: message ?? "", createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate(), mailAddress: mailAddress, status: status ?? "", team: team ?? Team(), role: role ?? "")
    }

    public init() {
        fatalError("init() has not been implemented")
    }

    public init(id: InviteID, sender: Account, account: Account?, message: String, createdAt: NSDate, updatedAt: NSDate, mailAddress: String?, status: String, team: Team = Team(), role: String = "") {
        self.team = team
        self.role = role
        super.init(id: id, sender: sender, account: account, message: message, createdAt: createdAt, updatedAt: updatedAt, mailAddress: mailAddress, status: status)
    }
}
