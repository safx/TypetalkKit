//
//  Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/19.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import XCTest
import TypetalkKit

class ClientTests: TestCase {
    
    func test_parseGetProfile() {
        let data = json("api_get-profile")
        let account = Client.sharedClient._parseGetProfile(data)
        XCTAssertEqual(account.id, 100)
        XCTAssertEqual(account.name, "jessica")
        XCTAssertEqual(account.fullName, "Jessica Fitzherbert")
        XCTAssertEqual(account.suggestion, "Jessica Fitzherbert")
        XCTAssertEqual(account.imageUrl.absoluteString!, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
        XCTAssertEqual(account.createdAt.description, "2014-06-24 02:32:29 +0000")
        XCTAssertEqual(account.updatedAt.description, "2014-06-24 02:32:29 +0000")
    }

    func test_parseGetTopics() {
        let data = json("api_get-topics")
        let topics = Client.sharedClient._parseGetTopics(data)
        XCTAssertEqual(countElements(topics), 9)
        
        let last = topics[8]
        XCTAssertEqual(last.topic!.id, 206)
        XCTAssertEqual(last.topic!.name, "VisualDesigners")
        XCTAssertEqual(last.topic!.suggestion, "VisualDesigners")
        XCTAssertEqual(last.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(last.topic!.createdAt.description, "2014-06-08 02:32:29 +0000")
        XCTAssertEqual(last.topic!.updatedAt.description, "2014-06-08 02:32:29 +0000")
        XCTAssertFalse(last.favorite)
        XCTAssertNil(last.unread)
    }

    func test_parseGetMessages() {
        let data = json("api_get-messages")
        let messages = Client.sharedClient._parseGetMessages(data)
        XCTAssertEqual(countElements(messages.posts), 8)
            
        let last = messages.posts[7]
        XCTAssertEqual(last.id, 307)
        XCTAssertEqual(last.topicId, 208)
        XCTAssertEqual(last.replyTo!, 306)
        XCTAssertEqual(last.message, "Hope it doesn't sound arrogant but I'm the greatest man in the world!")
    }

    func test_parsePostMessage() {
        let data = json("api_post-message")
        let (topic, post) = Client.sharedClient._parsePostMessage(data)
        XCTAssertEqual(topic.id, 208)
        XCTAssertEqual(topic.name, "IT Peeps")
        XCTAssertEqual(topic.suggestion, "IT Peeps")
        
        XCTAssertEqual(post.id, 333)
        XCTAssertNil(post.replyTo)
        XCTAssertNil(post.mention)
        XCTAssertEqual(post.message, "Let's party like it's 1999!")
        XCTAssertTrue(post.attachments.isEmpty)
        XCTAssertTrue(post.likes.isEmpty)
        XCTAssertTrue(post.talks.isEmpty)
        XCTAssertTrue(post.links.isEmpty)
        
        XCTAssertEqual(post.account!.id, 100)
        XCTAssertEqual(post.account!.name, "jessica")
    }
    
    func test_parseGetTopicMembers() {
        let data = json("api_get-topic-members")
        let (accounts, pendings) = Client.sharedClient._parseGetTopicMembers(data)
        XCTAssertEqual(accounts.count, 6)

        let last = accounts[5]
        XCTAssertEqual(last.id, 103)
        XCTAssertEqual(last.name, "stefhull")
        XCTAssertEqual(last.fullName, "StefHull")
        XCTAssertEqual(last.suggestion, "StefHull")
        XCTAssertEqual(last.imageUrl.absoluteString!, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
        XCTAssertEqual(last.createdAt.description, "2014-06-27 02:32:29 +0000")

        XCTAssertEqual(pendings.count, 1)
        
        let pending = pendings[0]
        XCTAssertEqual(pending.id, 106)
        XCTAssertEqual(pending.name, "chelseab")
        XCTAssertEqual(pending.fullName, "ChelseaB")
        XCTAssertEqual(pending.suggestion, "ChelseaB")
        XCTAssertEqual(pending.imageUrl.absoluteString!, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
        XCTAssertEqual(pending.createdAt.description, "2014-06-30 02:32:29 +0000")
    }

    func test_parseGetMessage() {
        let data = json("api_get-message")
        let message = Client.sharedClient._parseGetMessage(data)
        
        XCTAssertEqual(message.team!.id, 700)
        XCTAssertEqual(message.team!.name, "Nulab Inc.")
        XCTAssertEqual(message.team!.imageUrl.absoluteString!, "https://typetalk.in/teams/700/image.png?t=1402367549000")
        XCTAssertEqual(message.team!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(message.team!.updatedAt.description, "2014-06-10 02:32:29 +0000")

        XCTAssertEqual(message.topic!.id, 208)
        XCTAssertEqual(message.topic!.name, "IT Peeps")
        XCTAssertEqual(message.topic!.suggestion, "IT Peeps")
        XCTAssertEqual(message.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
        XCTAssertEqual(message.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(message.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
        
        XCTAssertEqual(message.post!.id, 307)
        XCTAssertEqual(message.post!.topicId, 208)
        XCTAssertEqual(message.post!.replyTo!, 306)
        XCTAssertEqual(countElements(message.post!.likes), 1)

        XCTAssertEqual(countElements(message.replies), 2)
    }

    func test_parseDeleteMessage() {
        let data = json("api_delete-message")
        let post = Client.sharedClient._parseDeleteMessage(data)
        
        XCTAssertEqual(post.id, 333)
        XCTAssertNil(post.replyTo)
        XCTAssertNil(post.mention)
        XCTAssertEqual(post.message, "Let's party like it's 1999!")
        XCTAssertTrue(post.attachments.isEmpty)
        XCTAssertEqual(post.account!.id, 100)
        XCTAssertEqual(post.account!.name, "jessica")
        XCTAssertEqual(countElements(post.attachments), 0)
        XCTAssertTrue(post.likes.isEmpty)
        XCTAssertTrue(post.talks.isEmpty)
        XCTAssertTrue(post.links.isEmpty)
    }

    func test_parseLikeMessage() {
        let data = json("api_like-message")
        let post = Client.sharedClient._parseLikeMessage(data)
        
        XCTAssertEqual(post.id, 604)
        XCTAssertEqual(post.postId, 305)
        XCTAssertEqual(post.topicId, 208)
        XCTAssertEqual(post.comment!, "")
        XCTAssertEqual(post.account!.id, 100)
        XCTAssertEqual(post.account!.name, "jessica")
        XCTAssertEqual(post.account!.fullName, "Jessica Fitzherbert")
        XCTAssertEqual(post.account!.suggestion, "Jessica Fitzherbert")
        XCTAssertEqual(post.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
        XCTAssertEqual(post.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
        XCTAssertEqual(post.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
    }

    func test_parseUnlikeMessage() {
        let data = json("api_unlike-message")
        let post = Client.sharedClient._parseUnlikeMessage(data)
        
        XCTAssertEqual(post.id, 604)
        XCTAssertEqual(post.postId, 305)
        XCTAssertEqual(post.topicId, 208)
        XCTAssertEqual(post.comment!, "")
        XCTAssertEqual(post.account!.id, 100)
        XCTAssertEqual(post.account!.name, "jessica")
        XCTAssertEqual(post.account!.fullName, "Jessica Fitzherbert")
        XCTAssertEqual(post.account!.suggestion, "Jessica Fitzherbert")
        XCTAssertEqual(post.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
        XCTAssertEqual(post.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
        XCTAssertEqual(post.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
    }

    func test_parseFavoriteTopic() {
        let data = json("api_favorite-topic")
        let result = Client.sharedClient._parseFavoriteTopic(data)
        let (topic, favorite) = result
        
        XCTAssertEqual(topic.id, 206)
        XCTAssertEqual(topic.name, "VisualDesigners")
        XCTAssertEqual(topic.suggestion, "VisualDesigners")
        XCTAssertEqual(topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(topic.createdAt.description, "2014-06-08 02:32:29 +0000")
        XCTAssertEqual(topic.updatedAt.description, "2014-06-08 02:32:29 +0000")

        XCTAssertTrue(favorite)
    }

    func test_parseUnfavoriteTopic() {
        let data = json("api_unfavorite-topic")
        let result = Client.sharedClient._parseUnfavoriteTopic(data)
        let (topic, favorite) = result
        
        XCTAssertEqual(topic.id, 206)
        XCTAssertEqual(topic.name, "VisualDesigners")
        XCTAssertEqual(topic.suggestion, "VisualDesigners")
        XCTAssertEqual(topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(topic.createdAt.description, "2014-06-08 02:32:29 +0000")
        XCTAssertEqual(topic.updatedAt.description, "2014-06-08 02:32:29 +0000")
        
        XCTAssertFalse(favorite)
    }

    func test_parseGetNotifications() {
        let data = json("api_get-notifications")
        let notifications = Client.sharedClient._parseGetNotifications(data)
        
        XCTAssertEqual(countElements(notifications.mentions), 2)
        let mention = notifications.mentions[1]
        XCTAssertEqual(mention.id, 500)
        XCTAssertEqual(mention.readAt!.description, "2014-06-30 15:00:00 +0000")
        XCTAssertEqual(mention.post!.id, 308)
        XCTAssertEqual(mention.post!.topicId, 202)
        XCTAssertEqual(mention.post!.topic!.id, 202)
        XCTAssertEqual(mention.post!.topic!.name, "Arts & Crafts Club")
        XCTAssertNil(mention.post!.replyTo)
        XCTAssertEqual(mention.post!.message, "@jessica What do you think about this?")
        XCTAssertEqual(mention.post!.account!.id, 101)
        XCTAssertEqual(mention.post!.account!.name, "ahorowitz")
        
        XCTAssertEqual(countElements(notifications.teamInvites), 2)
        let team = notifications.teamInvites[1]
        XCTAssertEqual(team.id, 800)
        XCTAssertEqual(team.team!.id, 702)
        XCTAssertEqual(team.team!.name, "Cycling team")
        XCTAssertEqual(team.sender!.id, 106)
        XCTAssertEqual(team.sender!.name, "chelseab")
        XCTAssertEqual(team.account!.id, 100)
        XCTAssertEqual(team.account!.name, "jessica")
        
        XCTAssertEqual(countElements(notifications.topicInvites), 2)
        let topic = notifications.topicInvites[1]
        XCTAssertEqual(topic.id, 600)
        XCTAssertEqual(topic.topic!.id, 209)
        XCTAssertEqual(topic.topic!.name, "Web Site")
        XCTAssertEqual(topic.sender!.id, 106)
        XCTAssertEqual(topic.sender!.name, "chelseab")
        XCTAssertEqual(topic.account!.id, 100)
        XCTAssertEqual(topic.account!.name, "jessica")
    }

    func test_parseGetNotificationStatus() {
        let data = json("api_get-notification-status")
        let status = Client.sharedClient._parseGetNotificationStatus(data)

        XCTAssertEqual(status.unreadMentions!, 1)
        XCTAssertEqual(status.unopenedAccess!, 1)
        XCTAssertEqual(status.pendingTeamInvite!, 2)
        XCTAssertEqual(status.pendingTopicInvite!, 2)
    }
    
    func test_parseOpenNotification() {
        let data = json("api_open-notification")
        let status = Client.sharedClient._parseOpenNotification(data)

        XCTAssertEqual(status.unopenedAccess!, 0)
        XCTAssertNil(status.unreadMentions)
        XCTAssertNil(status.pendingTeamInvite)
        XCTAssertNil(status.pendingTopicInvite)
    }
    
    func test_parseSaveReadTopic() {
        let data = json("api_save-read-topic")
        let unread = Client.sharedClient._parseSaveReadTopic(data)
        
        XCTAssertEqual(unread.topicId, 208)
        XCTAssertEqual(unread.postId, 307)
        XCTAssertEqual(unread.count, 0)
    }
    
    func test_parseGetMentions() {
        let data = json("api_get-mentions")
        let mentions = Client.sharedClient._parseGetMentions(data)
        
        XCTAssertEqual(countElements(mentions), 2)
        let mention = mentions[0]
        
        XCTAssertEqual(mention.id, 501)
        XCTAssertNil(mention.readAt)
        XCTAssertEqual(mention.post!.id, 309)
        XCTAssertEqual(mention.post!.topicId, 203)
        XCTAssertEqual(mention.post!.topic!.id, 203)
        XCTAssertEqual(mention.post!.topic!.name, "Techies")
        XCTAssertEqual(mention.post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(mention.post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
        XCTAssertEqual(mention.post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
        XCTAssertNil(mention.post!.replyTo)
        XCTAssertEqual(mention.post!.message, "@jessica Help me!")
    }
    
    func test_parseSaveReadMention() {
        let data = json("api_save-read-mention")
        let mention = Client.sharedClient._parseSaveReadMention(data)
        
        XCTAssertEqual(mention.id, 501)
        XCTAssertEqual(mention.post!.id, 309)
        XCTAssertEqual(mention.post!.topicId, 203)
        XCTAssertEqual(mention.readAt!.description, "2014-07-25 03:38:52 +0000")
        XCTAssertEqual(mention.post!.topic!.id, 203)
        XCTAssertEqual(mention.post!.topic!.name, "Techies")
        XCTAssertEqual(mention.post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(mention.post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
        XCTAssertEqual(mention.post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
        XCTAssertNil(mention.post!.replyTo)
        XCTAssertEqual(mention.post!.message, "@jessica Help me!")
    }

    func test_parseAcceptTeamInvite() {
        let data = json("api_accept-team-invite")
        let v = Client.sharedClient._parseAcceptTeamInvite(data)
        let (topics, invite) = v

        XCTAssertEqual(countElements(topics), 2)
        let topic = topics[1]
        XCTAssertEqual(topic.id, 212)
        XCTAssertEqual(topic.name, "Races")
        XCTAssertEqual(topic.suggestion, "Races")
        XCTAssertEqual(topic.lastPostedAt!.description, "2014-06-12 04:32:29 +0000")
        XCTAssertEqual(topic.createdAt.description, "2014-06-12 03:32:29 +0000")
        XCTAssertEqual(topic.updatedAt.description, "2014-06-12 03:32:29 +0000")

        XCTAssertEqual(invite.id, 800)
        XCTAssertEqual(invite.team!.id, 702)
        XCTAssertEqual(invite.team!.name, "Cycling team")
        XCTAssertEqual(invite.sender!.id, 106)
        XCTAssertEqual(invite.sender!.name, "chelseab")
        XCTAssertEqual(invite.account!.id, 100)
        XCTAssertEqual(invite.account!.name, "jessica")

        XCTAssertEqual(invite.role, "member")
        XCTAssertEqual(invite.message, "Hello. Please join us.")
    }

    func test_parseDeclineTeamInvite() {
        let data = json("api_decline-team-invite")
        let invite = Client.sharedClient._parseDeclineTeamInvite(data)
        XCTAssertEqual(invite.id, 801)
        XCTAssertEqual(invite.team!.id, 703)
        XCTAssertEqual(invite.team!.name, "WP Team")
        XCTAssertEqual(invite.sender!.id, 105)
        XCTAssertEqual(invite.sender!.name, "brad")
        XCTAssertEqual(invite.account!.id, 100)
        XCTAssertEqual(invite.account!.name, "jessica")
        
        XCTAssertEqual(invite.role, "admin")
        XCTAssertEqual(invite.message, "This team is for new project.")
    }

    func test_parseAcceptTopicInvite() {
        let data = json("api_accept-topic-invite")
        let invite = Client.sharedClient._parseAcceptTopicInvite(data)
        XCTAssertEqual(invite.id, 600)
        XCTAssertEqual(invite.topic!.id, 209)
        XCTAssertEqual(invite.topic!.name, "Web Site")
        XCTAssertEqual(invite.sender!.id, 106)
        XCTAssertEqual(invite.sender!.name, "chelseab")
        XCTAssertEqual(invite.account!.id, 100)
        XCTAssertEqual(invite.account!.name, "jessica")
        XCTAssertEqual(invite.message, "It is a new project. Join us!")
    }
    
    func test_parseDeclineTopicInvite() {
        let data = json("api_decline-topic-invite")
        let invite = Client.sharedClient._parseDeclineTopicInvite(data)
        XCTAssertEqual(invite.id, 601)
        XCTAssertEqual(invite.topic!.id, 210)
        XCTAssertEqual(invite.topic!.name, "Development")
        XCTAssertEqual(invite.sender!.id, 105)
        XCTAssertEqual(invite.sender!.name, "brad")
        XCTAssertEqual(invite.account!.id, 100)
        XCTAssertEqual(invite.account!.name, "jessica")
        XCTAssertEqual(invite.message, "It is a new project. Join us!")
    }
    
    func test_parseCreateTopic() {
        let data = json("api_create-topic")
        let topic = Client.sharedClient._parseCreateTopic(data)
        
        XCTAssertEqual(topic.topic!.id, 222)
        XCTAssertEqual(topic.topic!.name, "Test topic")
        XCTAssertEqual(topic.topic!.suggestion, "Test topic")
        XCTAssertNil(topic.topic!.lastPostedAt)
        XCTAssertEqual(topic.topic!.createdAt.description, "2014-07-25 03:38:55 +0000")
        XCTAssertEqual(topic.topic!.updatedAt.description, "2014-07-25 03:38:55 +0000")
        
        XCTAssertEqual(countElements(topic.teams), 1)
        let team = topic.teams[0]
        XCTAssertEqual(team.team!.id, 700)
        XCTAssertEqual(team.team!.name, "Nulab Inc.")
        XCTAssertEqual(team.team!.imageUrl.absoluteString!, "https://typetalk.in/teams/700/image.png?t=1402367549000")
        XCTAssertEqual(team.team!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(team.team!.updatedAt.description, "2014-06-10 02:32:29 +0000")
    }

    func test_parseUpdateTopic() {
        let data = json("api_update-topic")
        let topic = Client.sharedClient._parseUpdateTopic(data)
        
        XCTAssertEqual(topic.topic!.id, 222)
        XCTAssertEqual(topic.topic!.name, "Update test topic")
        XCTAssertEqual(topic.topic!.suggestion, "Update test topic")
        XCTAssertNil(topic.topic!.lastPostedAt)
        XCTAssertEqual(topic.topic!.createdAt.description, "2014-07-25 03:38:55 +0000")
        XCTAssertEqual(topic.topic!.updatedAt.description, "2014-07-25 03:38:56 +0000")
        
        XCTAssertEqual(countElements(topic.teams), 0)
        XCTAssertEqual(countElements(topic.accounts), 1)
        XCTAssertEqual(countElements(topic.invites), 2)
    }

    func test_parseDeleteTopic() {
        let data = json("api_delete-topic")
        let topic = Client.sharedClient._parseDeleteTopic(data)
        
        XCTAssertEqual(topic.id, 222)
        XCTAssertEqual(topic.name, "Update test topic")
        XCTAssertEqual(topic.suggestion, "Update test topic")
        XCTAssertNil(topic.lastPostedAt)
        XCTAssertEqual(topic.createdAt.description, "2014-07-25 03:38:55 +0000")
        XCTAssertEqual(topic.updatedAt.description, "2014-07-25 03:38:56 +0000")
    }

    func test_parseGetTopicDetails() {
        let data = json("api_get-topic-details")
        let topic = Client.sharedClient._parseUpdateTopic(data)
        
        XCTAssertEqual(topic.topic!.id, 208)
        XCTAssertEqual(topic.topic!.name, "IT Peeps")
        XCTAssertEqual(topic.topic!.suggestion, "IT Peeps")
        XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
        XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
        
        XCTAssertEqual(countElements(topic.teams), 1)
        XCTAssertEqual(countElements(topic.accounts), 2)
        XCTAssertEqual(countElements(topic.invites), 2)
    }

    func test_parseInviteTopicMember() {
        let data = json("api_invite-topic-member")
        let topic = Client.sharedClient._parseUpdateTopic(data)
        
        XCTAssertEqual(topic.topic!.id, 207)
        XCTAssertEqual(topic.topic!.name, "Art Directors")
        XCTAssertEqual(topic.topic!.suggestion, "Art Directors")
        XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-09 02:32:29 +0000")
        XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-09 02:32:29 +0000")
        
        XCTAssertEqual(countElements(topic.teams), 0)
        XCTAssertEqual(countElements(topic.accounts), 1)
        XCTAssertEqual(countElements(topic.invites), 2)
    }

    func test_parseRemoveTopicMember() {
        let data = json("api_remove-topic-member")
        let topic = Client.sharedClient._parseRemoveTopicMember(data)
        
        XCTAssertEqual(topic.topic!.id, 208)
        XCTAssertEqual(topic.topic!.name, "IT Peeps")
        XCTAssertEqual(topic.topic!.suggestion, "IT Peeps")
        XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
        XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
        
        XCTAssertEqual(countElements(topic.teams), 1)
        XCTAssertEqual(countElements(topic.accounts), 0)
        XCTAssertEqual(countElements(topic.invites), 0)
    }

    func test_parseGetTeams() {
        let data = json("api_get-teams")
        let teams = Client.sharedClient._parseGetTeams(data)
        
        XCTAssertEqual(countElements(teams), 3)
        let first = teams[0]
        let (team, count) = first
        XCTAssertEqual(count, 4)
        XCTAssertEqual(team.id, 700)
        XCTAssertEqual(team.name, "Nulab Inc.")
        XCTAssertEqual(team.imageUrl.absoluteString!, "https://typetalk.in/teams/700/image.png?t=1402367549000")
        XCTAssertEqual(team.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(team.updatedAt.description, "2014-06-10 02:32:29 +0000")

    }

    func test_parseGetFriends() {
        let data = json("api_get-friends")
        let accounts = Client.sharedClient._parseGetFriends(data)
        
        XCTAssertEqual(countElements(accounts), 5)
        let last = accounts[4]
        XCTAssertEqual(last.id, 103)
        XCTAssertEqual(last.name, "stefhull")
        XCTAssertEqual(last.fullName, "StefHull")
        XCTAssertEqual(last.suggestion, "StefHull")
        XCTAssertEqual(last.imageUrl.absoluteString!, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
        XCTAssertEqual(last.createdAt.description, "2014-06-27 02:32:29 +0000")
        XCTAssertEqual(last.updatedAt.description, "2014-06-27 02:32:29 +0000")
    }

    func test_parseSearchAccounts() {
        let data = json("api_search-accounts")
        let account = Client.sharedClient._parseSearchAccounts(data)
        
        XCTAssertEqual(account.id, 102)
        XCTAssertEqual(account.name, "moss")
        XCTAssertEqual(account.fullName, "Moss")
        XCTAssertEqual(account.suggestion, "Moss")
        XCTAssertEqual(account.imageUrl.absoluteString!, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
        XCTAssertEqual(account.createdAt.description, "2014-06-26 02:32:29 +0000")
        XCTAssertEqual(account.updatedAt.description, "2014-06-26 02:32:29 +0000")
    }

    func test_parseGetTalks() {
        let data = json("api_get-talks")
        let talks = Client.sharedClient._parseGetTalks(data)

        XCTAssertEqual(countElements(talks), 2)
        let last = talks[1]
        XCTAssertEqual(last.id, 900)
        XCTAssertEqual(last.topicId, 208)
        XCTAssertEqual(last.name, "About us")
        XCTAssertEqual(last.suggestion, "About us")
        XCTAssertEqual(last.createdAt.description, "2014-07-02 03:42:29 +0000")
        XCTAssertEqual(last.updatedAt.description, "2014-07-02 03:52:29 +0000")
    }

    func test_parseGetTalk() {
        let data = json("api_get-talk")
        let talk = Client.sharedClient._parseGetTalk(data)
        
        XCTAssertEqual(talk.topic!.id, 208)
        XCTAssertEqual(talk.topic!.name, "IT Peeps")
        XCTAssertEqual(talk.topic!.suggestion, "IT Peeps")
        XCTAssertEqual(talk.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
        XCTAssertEqual(talk.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(talk.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
        
        XCTAssertEqual(talk.talk!.id, 900)
        XCTAssertEqual(talk.talk!.topicId, 208)
        XCTAssertEqual(talk.talk!.name, "About us")
        XCTAssertEqual(talk.talk!.createdAt.description, "2014-07-02 03:42:29 +0000")
        XCTAssertEqual(talk.talk!.updatedAt.description, "2014-07-02 03:52:29 +0000")
        
        XCTAssertEqual(countElements(talk.posts), 2)
        let last = talk.posts[1]
        XCTAssertEqual(last.id, 306)
        XCTAssertEqual(last.topicId, 208)
        XCTAssertEqual(last.replyTo!, 305)
        XCTAssertEqual(last.message, "Oh. What time of the month? The weekend?")

        XCTAssertEqual(talk.hasNext, false)
    }
}
