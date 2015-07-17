// This file was auto-generated from Model.swift with swift-idl.

import Foundation

public enum MessageDirection: String, JSONDecodable {
    case Backward = "backward"
    case Forward = "forward"

    public static func parseJSON(data: AnyObject) throws -> MessageDirection {
        if let v = data as? String, val = MessageDirection(rawValue: v) {
            return val
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "MessageDirection")
    }

    public func toJSON() -> String {
        return rawValue
    }
}


public enum AttachmentType: String, JSONDecodable {
    case Small = "small"
    case Medium = "medium"
    case Large = "large"

    public static func parseJSON(data: AnyObject) throws -> AttachmentType {
        if let v = data as? String, val = AttachmentType(rawValue: v) {
            return val
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "AttachmentType")
    }

    public func toJSON() -> String {
        return rawValue
    }
}


public enum Scope: String, JSONDecodable {
    case my = "my"
    case topic_read = "topic.read"
    case topic_post = "topic.post"
    case topic_write = "topic.write"
    case topic_delete = "topic.delete"

    public static func parseJSON(data: AnyObject) throws -> Scope {
        if let v = data as? String, val = Scope(rawValue: v) {
            return val
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "Scope")
    }

    public func toJSON() -> String {
        return rawValue
    }
}


public struct Account: JSONDecodable {
    public let id: AccountID
    public let name: String
    public let fullName: String
    public let suggestion: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public static func parseJSON(data: AnyObject) throws -> Account {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Account", type: "NSDictionary")
        }
    
        let id: AccountID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                id = 0
            } else {
                do {
                    id = try AccountID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "AccountID")
                }
            }
        } else {
            id = 0
        }
        
        let name: String
        if let v: AnyObject = data["name"] {
            if v is NSNull {
                name = ""
            } else {
                do {
                    name = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "name", type: "String")
                }
            }
        } else {
            name = ""
        }
        
        let fullName: String
        if let v: AnyObject = data["fullName"] {
            if v is NSNull {
                fullName = ""
            } else {
                do {
                    fullName = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "fullName", type: "String")
                }
            }
        } else {
            fullName = ""
        }
        
        let suggestion: String
        if let v: AnyObject = data["suggestion"] {
            if v is NSNull {
                suggestion = ""
            } else {
                do {
                    suggestion = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "suggestion", type: "String")
                }
            }
        } else {
            suggestion = ""
        }
        
        let imageUrl: NSURL
        if let v: AnyObject = data["imageUrl"] {
            if v is NSNull {
                imageUrl = NSURL()
            } else {
                do {
                    imageUrl = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "imageUrl", type: "NSURL")
                }
            }
        } else {
            imageUrl = NSURL()
        }
        
        let createdAt: NSDate
        if let v: AnyObject = data["createdAt"] {
            if v is NSNull {
                createdAt = NSDate()
            } else {
                do {
                    createdAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "createdAt", type: "NSDate")
                }
            }
        } else {
            createdAt = NSDate()
        }
        
        let updatedAt: NSDate
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                updatedAt = NSDate()
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            updatedAt = NSDate()
        }
        
        return Account(id: id, name: name, fullName: fullName, suggestion: suggestion, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt)
    }

    public init(id: AccountID = 0, name: String = "", fullName: String = "", suggestion: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.suggestion = suggestion
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


public struct AccountWithOnlineStatus: JSONDecodable {
    public let account: Account
    public let online: Bool

    public static func parseJSON(data: AnyObject) throws -> AccountWithOnlineStatus {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "AccountWithOnlineStatus", type: "NSDictionary")
        }
    
        let account: Account
        if let v: AnyObject = data["account"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "account")
            } else {
                do {
                    account = try Account.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "account", type: "Account")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "account")
        }
        
        let online: Bool
        if let v: AnyObject = data["online"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "online")
            } else {
                do {
                    online = try Bool.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "online", type: "Bool")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "online")
        }
        
        return AccountWithOnlineStatus(account: account, online: online)
    }
}


public struct AccountWithMailAddress: JSONDecodable {
    public let account: Account
    public let mailAddress: String?

    public static func parseJSON(data: AnyObject) throws -> AccountWithMailAddress {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "AccountWithMailAddress", type: "NSDictionary")
        }
    
        let account: Account
        if let v: AnyObject = data["account"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "account")
            } else {
                do {
                    account = try Account.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "account", type: "Account")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "account")
        }
        
        let mailAddress: String?
        if let v: AnyObject = data["mailAddress"] {
            if v is NSNull {
                mailAddress = nil
            } else {
                do {
                    mailAddress = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "mailAddress", type: "String")
                }
            }
        } else {
            mailAddress = nil
        }
        
        return AccountWithMailAddress(account: account, mailAddress: mailAddress)
    }
}


public struct Attachment: JSONDecodable {
    public let contentType: String
    public let fileKey: String
    public let fileName: String
    public let fileSize: Int

    public static func parseJSON(data: AnyObject) throws -> Attachment {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Attachment", type: "NSDictionary")
        }
    
        let contentType: String
        if let v: AnyObject = data["contentType"] {
            if v is NSNull {
                contentType = ""
            } else {
                do {
                    contentType = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "contentType", type: "String")
                }
            }
        } else {
            contentType = ""
        }
        
        let fileKey: String
        if let v: AnyObject = data["fileKey"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "fileKey")
            } else {
                do {
                    fileKey = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "fileKey", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "fileKey")
        }
        
        let fileName: String
        if let v: AnyObject = data["fileName"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "fileName")
            } else {
                do {
                    fileName = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "fileName", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "fileName")
        }
        
        let fileSize: Int
        if let v: AnyObject = data["fileSize"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "fileSize")
            } else {
                do {
                    fileSize = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "fileSize", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "fileSize")
        }
        
        return Attachment(contentType: contentType, fileKey: fileKey, fileName: fileName, fileSize: fileSize)
    }
}


public struct Bookmark: JSONDecodable {
    public let postId: PostID
    public let updatedAt: NSDate

    public static func parseJSON(data: AnyObject) throws -> Bookmark {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Bookmark", type: "NSDictionary")
        }
    
        let postId: PostID
        if let v: AnyObject = data["postId"] {
            if v is NSNull {
                postId = 0
            } else {
                do {
                    postId = try PostID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "postId", type: "PostID")
                }
            }
        } else {
            postId = 0
        }
        
        let updatedAt: NSDate
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                updatedAt = NSDate()
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            updatedAt = NSDate()
        }
        
        return Bookmark(postId: postId, updatedAt: updatedAt)
    }

    public init(postId: PostID = 0, updatedAt: NSDate = NSDate()) {
        self.postId = postId
        self.updatedAt = updatedAt
    }
}


public struct Embed: JSONDecodable {
    public let type: String
    public let version: Float
    public let providerName: String // JSON:"provider_name"
    public let providerURL: NSURL?  // JSON:"provider_url"
    public let title: String
    public let authorName: String   // JSON:"author_name"
    public let authorURL: NSURL?    // JSON:"author_url"
    public let html: String
    public let width: Int
    public let height: Int

    public static func parseJSON(data: AnyObject) throws -> Embed {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Embed", type: "NSDictionary")
        }
    
        let type: String
        if let v: AnyObject = data["type"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "type")
            } else {
                do {
                    type = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "type", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "type")
        }
        
        let version: Float
        if let v: AnyObject = data["version"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "version")
            } else {
                do {
                    version = try Float.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "version", type: "Float")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "version")
        }
        
        let providerName: String
        if let v: AnyObject = data["provider_name"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "provider_name")
            } else {
                do {
                    providerName = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "provider_name", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "provider_name")
        }
        
        let providerURL: NSURL?
        if let v: AnyObject = data["provider_url"] {
            if v is NSNull {
                providerURL = nil
            } else {
                do {
                    providerURL = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "provider_url", type: "NSURL")
                }
            }
        } else {
            providerURL = nil
        }
        
        let title: String
        if let v: AnyObject = data["title"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "title")
            } else {
                do {
                    title = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "title", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "title")
        }
        
        let authorName: String
        if let v: AnyObject = data["author_name"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "author_name")
            } else {
                do {
                    authorName = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "author_name", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "author_name")
        }
        
        let authorURL: NSURL?
        if let v: AnyObject = data["author_url"] {
            if v is NSNull {
                authorURL = nil
            } else {
                do {
                    authorURL = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "author_url", type: "NSURL")
                }
            }
        } else {
            authorURL = nil
        }
        
        let html: String
        if let v: AnyObject = data["html"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "html")
            } else {
                do {
                    html = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "html", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "html")
        }
        
        let width: Int
        if let v: AnyObject = data["width"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "width")
            } else {
                do {
                    width = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "width", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "width")
        }
        
        let height: Int
        if let v: AnyObject = data["height"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "height")
            } else {
                do {
                    height = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "height", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "height")
        }
        
        return Embed(type: type, version: version, providerName: providerName, providerURL: providerURL, title: title, authorName: authorName, authorURL: authorURL, html: html, width: width, height: height)
    }
}


public struct Invite: JSONDecodable {
    public let id: InviteID
    public let sender: Account?
    public let account: Account?
    public let message: String
    public let createdAt: NSDate?
    public let updatedAt: NSDate?
    public let mailAddress: String?
    public let status: String
    public let topic: Topic?
    public let team: Team?
    public let role: String?

    public static func parseJSON(data: AnyObject) throws -> Invite {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Invite", type: "NSDictionary")
        }
    
        let id: InviteID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "id")
            } else {
                do {
                    id = try InviteID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "InviteID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "id")
        }
        
        let sender: Account?
        if let v: AnyObject = data["sender"] {
            if v is NSNull {
                sender = nil
            } else {
                do {
                    sender = try Account.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "sender", type: "Account")
                }
            }
        } else {
            sender = nil
        }
        
        let account: Account?
        if let v: AnyObject = data["account"] {
            if v is NSNull {
                account = nil
            } else {
                do {
                    account = try Account.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "account", type: "Account")
                }
            }
        } else {
            account = nil
        }
        
        let message: String
        if let v: AnyObject = data["message"] {
            if v is NSNull {
                message = ""
            } else {
                do {
                    message = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "message", type: "String")
                }
            }
        } else {
            message = ""
        }
        
        let createdAt: NSDate?
        if let v: AnyObject = data["createdAt"] {
            if v is NSNull {
                createdAt = nil
            } else {
                do {
                    createdAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "createdAt", type: "NSDate")
                }
            }
        } else {
            createdAt = nil
        }
        
        let updatedAt: NSDate?
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                updatedAt = nil
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            updatedAt = nil
        }
        
        let mailAddress: String?
        if let v: AnyObject = data["mailAddress"] {
            if v is NSNull {
                mailAddress = nil
            } else {
                do {
                    mailAddress = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "mailAddress", type: "String")
                }
            }
        } else {
            mailAddress = nil
        }
        
        let status: String
        if let v: AnyObject = data["status"] {
            if v is NSNull {
                status = ""
            } else {
                do {
                    status = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "status", type: "String")
                }
            }
        } else {
            status = ""
        }
        
        let topic: Topic?
        if let v: AnyObject = data["topic"] {
            if v is NSNull {
                topic = nil
            } else {
                do {
                    topic = try Topic.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
                }
            }
        } else {
            topic = nil
        }
        
        let team: Team?
        if let v: AnyObject = data["team"] {
            if v is NSNull {
                team = nil
            } else {
                do {
                    team = try Team.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "team", type: "Team")
                }
            }
        } else {
            team = nil
        }
        
        let role: String?
        if let v: AnyObject = data["role"] {
            if v is NSNull {
                role = nil
            } else {
                do {
                    role = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "role", type: "String")
                }
            }
        } else {
            role = nil
        }
        
        return Invite(id: id, sender: sender, account: account, message: message, createdAt: createdAt, updatedAt: updatedAt, mailAddress: mailAddress, status: status, topic: topic, team: team, role: role)
    }
}


public struct Like: JSONDecodable {
    public let id: LikeID
    public let postId: PostID
    public let topicId: TopicID
    public let comment: String?
    public let account: Account?

    public static func parseJSON(data: AnyObject) throws -> Like {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Like", type: "NSDictionary")
        }
    
        let id: LikeID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "id")
            } else {
                do {
                    id = try LikeID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "LikeID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "id")
        }
        
        let postId: PostID
        if let v: AnyObject = data["postId"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "postId")
            } else {
                do {
                    postId = try PostID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "postId", type: "PostID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "postId")
        }
        
        let topicId: TopicID
        if let v: AnyObject = data["topicId"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "topicId")
            } else {
                do {
                    topicId = try TopicID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topicId", type: "TopicID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "topicId")
        }
        
        let comment: String?
        if let v: AnyObject = data["comment"] {
            if v is NSNull {
                comment = nil
            } else {
                do {
                    comment = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "comment", type: "String")
                }
            }
        } else {
            comment = nil
        }
        
        let account: Account?
        if let v: AnyObject = data["account"] {
            if v is NSNull {
                account = nil
            } else {
                do {
                    account = try Account.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "account", type: "Account")
                }
            }
        } else {
            account = nil
        }
        
        return Like(id: id, postId: postId, topicId: topicId, comment: comment, account: account)
    }
}


public struct Link: JSONDecodable {
    public let id: LinkID
    public let url: NSURL
    public let contentType: String
    public let title: String
    public let description: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate
    public let embed: Embed?

    public static func parseJSON(data: AnyObject) throws -> Link {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Link", type: "NSDictionary")
        }
    
        let id: LinkID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "id")
            } else {
                do {
                    id = try LinkID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "LinkID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "id")
        }
        
        let url: NSURL
        if let v: AnyObject = data["url"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "url")
            } else {
                do {
                    url = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "url", type: "NSURL")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "url")
        }
        
        let contentType: String
        if let v: AnyObject = data["contentType"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "contentType")
            } else {
                do {
                    contentType = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "contentType", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "contentType")
        }
        
        let title: String
        if let v: AnyObject = data["title"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "title")
            } else {
                do {
                    title = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "title", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "title")
        }
        
        let description: String
        if let v: AnyObject = data["description"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "description")
            } else {
                do {
                    description = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "description", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "description")
        }
        
        let imageUrl: NSURL
        if let v: AnyObject = data["imageUrl"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "imageUrl")
            } else {
                do {
                    imageUrl = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "imageUrl", type: "NSURL")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "imageUrl")
        }
        
        let createdAt: NSDate
        if let v: AnyObject = data["createdAt"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "createdAt")
            } else {
                do {
                    createdAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "createdAt", type: "NSDate")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "createdAt")
        }
        
        let updatedAt: NSDate
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "updatedAt")
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "updatedAt")
        }
        
        let embed: Embed?
        if let v: AnyObject = data["embed"] {
            if v is NSNull {
                embed = nil
            } else {
                do {
                    embed = try Embed.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "embed", type: "Embed")
                }
            }
        } else {
            embed = nil
        }
        
        return Link(id: id, url: url, contentType: contentType, title: title, description: description, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt, embed: embed)
    }
}


public struct Member: JSONDecodable {
    public let account: Account
    public let role: String

    public static func parseJSON(data: AnyObject) throws -> Member {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Member", type: "NSDictionary")
        }
    
        let account: Account
        if let v: AnyObject = data["account"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "account")
            } else {
                do {
                    account = try Account.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "account", type: "Account")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "account")
        }
        
        let role: String
        if let v: AnyObject = data["role"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "role")
            } else {
                do {
                    role = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "role", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "role")
        }
        
        return Member(account: account, role: role)
    }
}


public struct Mention: JSONDecodable {
    public let id: MentionID
    public let readAt: NSDate?
    public let post: Post?

    public static func parseJSON(data: AnyObject) throws -> Mention {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Mention", type: "NSDictionary")
        }
    
        let id: MentionID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                id = 0
            } else {
                do {
                    id = try MentionID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "MentionID")
                }
            }
        } else {
            id = 0
        }
        
        let readAt: NSDate?
        if let v: AnyObject = data["readAt"] {
            if v is NSNull {
                readAt = nil
            } else {
                do {
                    readAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "readAt", type: "NSDate")
                }
            }
        } else {
            readAt = nil
        }
        
        let post: Post?
        if let v: AnyObject = data["post"] {
            if v is NSNull {
                post = nil
            } else {
                do {
                    post = try Post.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "post", type: "Post")
                }
            }
        } else {
            post = nil
        }
        
        return Mention(id: id, readAt: readAt, post: post)
    }

    public init(id: MentionID = 0, readAt: NSDate? = nil, post: Post? = nil) {
        self.id = id
        self.readAt = readAt
        self.post = post
    }
}


public struct Notifications: JSONDecodable {
    public let mentions: [Mention]
    public let invites: Invites

    public static func parseJSON(data: AnyObject) throws -> Notifications {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Notifications", type: "NSDictionary")
        }
    
        let mentions: [Mention]
        if let v: AnyObject = data["mentions"] {
            if v is NSNull {
                mentions = []
            } else {
                do {
                    mentions = try Mention.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "mentions")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "mentions", type: "Mention")
                }
            }
        } else {
            mentions = []
        }
        
        let invites: Invites
        if let v: AnyObject = data["invites"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "invites")
            } else {
                do {
                    invites = try Invites.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "invites", type: "Invites")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "invites")
        }
        
        return Notifications(mentions: mentions, invites: invites)
    }

public struct Invites: JSONDecodable {
    public let teams: [Invite]
    public let topics: [Invite]

    public static func parseJSON(data: AnyObject) throws -> Invites {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Invites", type: "NSDictionary")
        }
    
        let teams: [Invite]
        if let v: AnyObject = data["teams"] {
            if v is NSNull {
                teams = []
            } else {
                do {
                    teams = try Invite.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "teams")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "teams", type: "Invite")
                }
            }
        } else {
            teams = []
        }
        
        let topics: [Invite]
        if let v: AnyObject = data["topics"] {
            if v is NSNull {
                topics = []
            } else {
                do {
                    topics = try Invite.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "topics")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topics", type: "Invite")
                }
            }
        } else {
            topics = []
        }
        
        return Invites(teams: teams, topics: topics)
    }
}
}


public struct NotificationStatus: JSONDecodable {
    public let mention: Mention?
    public let access: Access?
    public let invite: Invite?

    public static func parseJSON(data: AnyObject) throws -> NotificationStatus {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "NotificationStatus", type: "NSDictionary")
        }
    
        let mention: Mention?
        if let v: AnyObject = data["mention"] {
            if v is NSNull {
                mention = nil
            } else {
                do {
                    mention = try Mention.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "mention", type: "Mention")
                }
            }
        } else {
            mention = nil
        }
        
        let access: Access?
        if let v: AnyObject = data["access"] {
            if v is NSNull {
                access = nil
            } else {
                do {
                    access = try Access.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "access", type: "Access")
                }
            }
        } else {
            access = nil
        }
        
        let invite: Invite?
        if let v: AnyObject = data["invite"] {
            if v is NSNull {
                invite = nil
            } else {
                do {
                    invite = try Invite.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "invite", type: "Invite")
                }
            }
        } else {
            invite = nil
        }
        
        return NotificationStatus(mention: mention, access: access, invite: invite)
    }

public struct Mention: JSONDecodable {
    public let unread: Int?

    public static func parseJSON(data: AnyObject) throws -> Mention {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Mention", type: "NSDictionary")
        }
    
        let unread: Int?
        if let v: AnyObject = data["unread"] {
            if v is NSNull {
                unread = nil
            } else {
                do {
                    unread = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "unread", type: "Int")
                }
            }
        } else {
            unread = nil
        }
        
        return Mention(unread: unread)
    }
}
public struct Access: JSONDecodable {
    public let unopened: Int?

    public static func parseJSON(data: AnyObject) throws -> Access {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Access", type: "NSDictionary")
        }
    
        let unopened: Int?
        if let v: AnyObject = data["unopened"] {
            if v is NSNull {
                unopened = nil
            } else {
                do {
                    unopened = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "unopened", type: "Int")
                }
            }
        } else {
            unopened = nil
        }
        
        return Access(unopened: unopened)
    }
}
public struct Invite: JSONDecodable {
    public let team: PendingCount?
    public let topic: PendingCount?

    public static func parseJSON(data: AnyObject) throws -> Invite {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Invite", type: "NSDictionary")
        }
    
        let team: PendingCount?
        if let v: AnyObject = data["team"] {
            if v is NSNull {
                team = nil
            } else {
                do {
                    team = try PendingCount.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "team", type: "PendingCount")
                }
            }
        } else {
            team = nil
        }
        
        let topic: PendingCount?
        if let v: AnyObject = data["topic"] {
            if v is NSNull {
                topic = nil
            } else {
                do {
                    topic = try PendingCount.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topic", type: "PendingCount")
                }
            }
        } else {
            topic = nil
        }
        
        return Invite(team: team, topic: topic)
    }

public struct PendingCount: JSONDecodable {
    public let pending: Int?

    public static func parseJSON(data: AnyObject) throws -> PendingCount {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "PendingCount", type: "NSDictionary")
        }
    
        let pending: Int?
        if let v: AnyObject = data["pending"] {
            if v is NSNull {
                pending = nil
            } else {
                do {
                    pending = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "pending", type: "Int")
                }
            }
        } else {
            pending = nil
        }
        
        return PendingCount(pending: pending)
    }
}
}
}


public struct Post: JSONDecodable {
    public let id: PostID
    public let topicId: TopicID
    public let topic: Topic?
    public let replyTo: Int?
    public let message: String
    public let account: Account
    public let attachments: [URLAttachment]
    public let likes: [Like]
    public let talks: [Talk]
    public let links: [Link]
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public static func parseJSON(data: AnyObject) throws -> Post {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Post", type: "NSDictionary")
        }
    
        let id: PostID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                id = 0
            } else {
                do {
                    id = try PostID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "PostID")
                }
            }
        } else {
            id = 0
        }
        
        let topicId: TopicID
        if let v: AnyObject = data["topicId"] {
            if v is NSNull {
                topicId = 0
            } else {
                do {
                    topicId = try TopicID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topicId", type: "TopicID")
                }
            }
        } else {
            topicId = 0
        }
        
        let topic: Topic?
        if let v: AnyObject = data["topic"] {
            if v is NSNull {
                topic = nil
            } else {
                do {
                    topic = try Topic.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
                }
            }
        } else {
            topic = nil
        }
        
        let replyTo: Int?
        if let v: AnyObject = data["replyTo"] {
            if v is NSNull {
                replyTo = nil
            } else {
                do {
                    replyTo = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "replyTo", type: "Int")
                }
            }
        } else {
            replyTo = nil
        }
        
        let message: String
        if let v: AnyObject = data["message"] {
            if v is NSNull {
                message = ""
            } else {
                do {
                    message = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "message", type: "String")
                }
            }
        } else {
            message = ""
        }
        
        let account: Account
        if let v: AnyObject = data["account"] {
            if v is NSNull {
                account = Account()
            } else {
                do {
                    account = try Account.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "account", type: "Account")
                }
            }
        } else {
            account = Account()
        }
        
        let attachments: [URLAttachment]
        if let v: AnyObject = data["attachments"] {
            if v is NSNull {
                attachments = []
            } else {
                do {
                    attachments = try URLAttachment.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "attachments")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "attachments", type: "URLAttachment")
                }
            }
        } else {
            attachments = []
        }
        
        let likes: [Like]
        if let v: AnyObject = data["likes"] {
            if v is NSNull {
                likes = []
            } else {
                do {
                    likes = try Like.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "likes")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "likes", type: "Like")
                }
            }
        } else {
            likes = []
        }
        
        let talks: [Talk]
        if let v: AnyObject = data["talks"] {
            if v is NSNull {
                talks = []
            } else {
                do {
                    talks = try Talk.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "talks")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "talks", type: "Talk")
                }
            }
        } else {
            talks = []
        }
        
        let links: [Link]
        if let v: AnyObject = data["links"] {
            if v is NSNull {
                links = []
            } else {
                do {
                    links = try Link.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "links")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "links", type: "Link")
                }
            }
        } else {
            links = []
        }
        
        let createdAt: NSDate
        if let v: AnyObject = data["createdAt"] {
            if v is NSNull {
                createdAt = NSDate()
            } else {
                do {
                    createdAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "createdAt", type: "NSDate")
                }
            }
        } else {
            createdAt = NSDate()
        }
        
        let updatedAt: NSDate
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                updatedAt = NSDate()
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            updatedAt = NSDate()
        }
        
        return Post(id: id, topicId: topicId, topic: topic, replyTo: replyTo, message: message, account: account, attachments: attachments, likes: likes, talks: talks, links: links, createdAt: createdAt, updatedAt: updatedAt)
    }

    public init(id: PostID = 0, topicId: TopicID = 0, topic: Topic? = nil, replyTo: Int? = nil, message: String = "", account: Account = Account(), attachments: [URLAttachment] = [], likes: [Like] = [], talks: [Talk] = [], links: [Link] = [], createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.topicId = topicId
        self.topic = topic
        self.replyTo = replyTo
        self.message = message
        self.account = account
        self.attachments = attachments
        self.likes = likes
        self.talks = talks
        self.links = links
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


public struct Talk: JSONDecodable {
    public let id: TalkID
    public let topicId: TopicID
    public let name: String
    public let suggestion: String
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public static func parseJSON(data: AnyObject) throws -> Talk {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Talk", type: "NSDictionary")
        }
    
        let id: TalkID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "id")
            } else {
                do {
                    id = try TalkID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "TalkID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "id")
        }
        
        let topicId: TopicID
        if let v: AnyObject = data["topicId"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "topicId")
            } else {
                do {
                    topicId = try TopicID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topicId", type: "TopicID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "topicId")
        }
        
        let name: String
        if let v: AnyObject = data["name"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "name")
            } else {
                do {
                    name = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "name", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "name")
        }
        
        let suggestion: String
        if let v: AnyObject = data["suggestion"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "suggestion")
            } else {
                do {
                    suggestion = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "suggestion", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "suggestion")
        }
        
        let createdAt: NSDate
        if let v: AnyObject = data["createdAt"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "createdAt")
            } else {
                do {
                    createdAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "createdAt", type: "NSDate")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "createdAt")
        }
        
        let updatedAt: NSDate
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "updatedAt")
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "updatedAt")
        }
        
        return Talk(id: id, topicId: topicId, name: name, suggestion: suggestion, createdAt: createdAt, updatedAt: updatedAt)
    }
}


public struct TalkMessages: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
    public let posts: [Post]
    public let hasNext: Bool

    public static func parseJSON(data: AnyObject) throws -> TalkMessages {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "TalkMessages", type: "NSDictionary")
        }
    
        let topic: Topic
        if let v: AnyObject = data["topic"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "topic")
            } else {
                do {
                    topic = try Topic.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "topic")
        }
        
        let talk: Talk
        if let v: AnyObject = data["talk"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "talk")
            } else {
                do {
                    talk = try Talk.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "talk", type: "Talk")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "talk")
        }
        
        let posts: [Post]
        if let v: AnyObject = data["posts"] {
            if v is NSNull {
                posts = []
            } else {
                do {
                    posts = try Post.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "posts")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "posts", type: "Post")
                }
            }
        } else {
            posts = []
        }
        
        let hasNext: Bool
        if let v: AnyObject = data["hasNext"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "hasNext")
            } else {
                do {
                    hasNext = try Bool.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "hasNext", type: "Bool")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "hasNext")
        }
        
        return TalkMessages(topic: topic, talk: talk, posts: posts, hasNext: hasNext)
    }
}


public struct Team: JSONDecodable {
    public let id: TeamID
    public let name: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public static func parseJSON(data: AnyObject) throws -> Team {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Team", type: "NSDictionary")
        }
    
        let id: TeamID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                id = 0
            } else {
                do {
                    id = try TeamID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "TeamID")
                }
            }
        } else {
            id = 0
        }
        
        let name: String
        if let v: AnyObject = data["name"] {
            if v is NSNull {
                name = ""
            } else {
                do {
                    name = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "name", type: "String")
                }
            }
        } else {
            name = ""
        }
        
        let imageUrl: NSURL
        if let v: AnyObject = data["imageUrl"] {
            if v is NSNull {
                imageUrl = NSURL()
            } else {
                do {
                    imageUrl = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "imageUrl", type: "NSURL")
                }
            }
        } else {
            imageUrl = NSURL()
        }
        
        let createdAt: NSDate
        if let v: AnyObject = data["createdAt"] {
            if v is NSNull {
                createdAt = NSDate()
            } else {
                do {
                    createdAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "createdAt", type: "NSDate")
                }
            }
        } else {
            createdAt = NSDate()
        }
        
        let updatedAt: NSDate
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                updatedAt = NSDate()
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            updatedAt = NSDate()
        }
        
        return Team(id: id, name: name, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt)
    }

    public init(id: TeamID = 0, name: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


public struct TeamWithMembers: JSONDecodable {
    public let team: Team
    public let members: [Member]

    public static func parseJSON(data: AnyObject) throws -> TeamWithMembers {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "TeamWithMembers", type: "NSDictionary")
        }
    
        let team: Team
        if let v: AnyObject = data["team"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "team")
            } else {
                do {
                    team = try Team.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "team", type: "Team")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "team")
        }
        
        let members: [Member]
        if let v: AnyObject = data["members"] {
            if v is NSNull {
                members = []
            } else {
                do {
                    members = try Member.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "members")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "members", type: "Member")
                }
            }
        } else {
            members = []
        }
        
        return TeamWithMembers(team: team, members: members)
    }
}


public struct TeamWithCount: JSONDecodable {
    public let team: Team
    public let memberCount: Int

    public static func parseJSON(data: AnyObject) throws -> TeamWithCount {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "TeamWithCount", type: "NSDictionary")
        }
    
        let team: Team
        if let v: AnyObject = data["team"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "team")
            } else {
                do {
                    team = try Team.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "team", type: "Team")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "team")
        }
        
        let memberCount: Int
        if let v: AnyObject = data["memberCount"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "memberCount")
            } else {
                do {
                    memberCount = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "memberCount", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "memberCount")
        }
        
        return TeamWithCount(team: team, memberCount: memberCount)
    }
}


public struct Thumbnail: JSONDecodable {
    public let type: AttachmentType
    public let fileSize: Int
    public let width: Int
    public let height: Int

    public static func parseJSON(data: AnyObject) throws -> Thumbnail {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Thumbnail", type: "NSDictionary")
        }
    
        let type: AttachmentType
        if let v: AnyObject = data["type"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "type")
            } else {
                do {
                    type = try AttachmentType.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "type", type: "AttachmentType")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "type")
        }
        
        let fileSize: Int
        if let v: AnyObject = data["fileSize"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "fileSize")
            } else {
                do {
                    fileSize = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "fileSize", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "fileSize")
        }
        
        let width: Int
        if let v: AnyObject = data["width"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "width")
            } else {
                do {
                    width = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "width", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "width")
        }
        
        let height: Int
        if let v: AnyObject = data["height"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "height")
            } else {
                do {
                    height = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "height", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "height")
        }
        
        return Thumbnail(type: type, fileSize: fileSize, width: width, height: height)
    }
}


public struct Topic: JSONDecodable {
    public let id: TopicID
    public let name: String
    public let suggestion: String
    public let lastPostedAt: NSDate?
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public static func parseJSON(data: AnyObject) throws -> Topic {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Topic", type: "NSDictionary")
        }
    
        let id: TopicID
        if let v: AnyObject = data["id"] {
            if v is NSNull {
                id = 0
            } else {
                do {
                    id = try TopicID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "id", type: "TopicID")
                }
            }
        } else {
            id = 0
        }
        
        let name: String
        if let v: AnyObject = data["name"] {
            if v is NSNull {
                name = ""
            } else {
                do {
                    name = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "name", type: "String")
                }
            }
        } else {
            name = ""
        }
        
        let suggestion: String
        if let v: AnyObject = data["suggestion"] {
            if v is NSNull {
                suggestion = ""
            } else {
                do {
                    suggestion = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "suggestion", type: "String")
                }
            }
        } else {
            suggestion = ""
        }
        
        let lastPostedAt: NSDate?
        if let v: AnyObject = data["lastPostedAt"] {
            if v is NSNull {
                lastPostedAt = nil
            } else {
                do {
                    lastPostedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "lastPostedAt", type: "NSDate")
                }
            }
        } else {
            lastPostedAt = nil
        }
        
        let createdAt: NSDate
        if let v: AnyObject = data["createdAt"] {
            if v is NSNull {
                createdAt = NSDate()
            } else {
                do {
                    createdAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "createdAt", type: "NSDate")
                }
            }
        } else {
            createdAt = NSDate()
        }
        
        let updatedAt: NSDate
        if let v: AnyObject = data["updatedAt"] {
            if v is NSNull {
                updatedAt = NSDate()
            } else {
                do {
                    updatedAt = try NSDate.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "updatedAt", type: "NSDate")
                }
            }
        } else {
            updatedAt = NSDate()
        }
        
        return Topic(id: id, name: name, suggestion: suggestion, lastPostedAt: lastPostedAt, createdAt: createdAt, updatedAt: updatedAt)
    }

    public init(id: TopicID = 0, name: String = "", suggestion: String = "", lastPostedAt: NSDate? = nil, createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.name = name
        self.suggestion = suggestion
        self.lastPostedAt = lastPostedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


public struct TopicWithAccounts: JSONDecodable {
    public let topic: Topic
    public let teams: [TeamWithMembers]
    public let accounts: [Account]
    public let invites: [Invite]

    public static func parseJSON(data: AnyObject) throws -> TopicWithAccounts {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "TopicWithAccounts", type: "NSDictionary")
        }
    
        let topic: Topic
        if let v: AnyObject = data["topic"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "topic")
            } else {
                do {
                    topic = try Topic.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "topic")
        }
        
        let teams: [TeamWithMembers]
        if let v: AnyObject = data["teams"] {
            if v is NSNull {
                teams = []
            } else {
                do {
                    teams = try TeamWithMembers.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "teams")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "teams", type: "TeamWithMembers")
                }
            }
        } else {
            teams = []
        }
        
        let accounts: [Account]
        if let v: AnyObject = data["accounts"] {
            if v is NSNull {
                accounts = []
            } else {
                do {
                    accounts = try Account.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "accounts")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "accounts", type: "Account")
                }
            }
        } else {
            accounts = []
        }
        
        let invites: [Invite]
        if let v: AnyObject = data["invites"] {
            if v is NSNull {
                invites = []
            } else {
                do {
                    invites = try Invite.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "invites")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "invites", type: "Invite")
                }
            }
        } else {
            invites = []
        }
        
        return TopicWithAccounts(topic: topic, teams: teams, accounts: accounts, invites: invites)
    }
}


public struct TopicWithUserInfo: JSONDecodable {
    public let topic: Topic
    public let favorite: Bool
    public let unread: Unread?

    public static func parseJSON(data: AnyObject) throws -> TopicWithUserInfo {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "TopicWithUserInfo", type: "NSDictionary")
        }
    
        let topic: Topic
        if let v: AnyObject = data["topic"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "topic")
            } else {
                do {
                    topic = try Topic.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "topic")
        }
        
        let favorite: Bool
        if let v: AnyObject = data["favorite"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "favorite")
            } else {
                do {
                    favorite = try Bool.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "favorite", type: "Bool")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "favorite")
        }
        
        let unread: Unread?
        if let v: AnyObject = data["unread"] {
            if v is NSNull {
                unread = nil
            } else {
                do {
                    unread = try Unread.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "unread", type: "Unread")
                }
            }
        } else {
            unread = nil
        }
        
        return TopicWithUserInfo(topic: topic, favorite: favorite, unread: unread)
    }
}


public struct Unread: JSONDecodable {
    public let topicId: TopicID
    public let postId: PostID
    public let count: Int

    public static func parseJSON(data: AnyObject) throws -> Unread {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "Unread", type: "NSDictionary")
        }
    
        let topicId: TopicID
        if let v: AnyObject = data["topicId"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "topicId")
            } else {
                do {
                    topicId = try TopicID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topicId", type: "TopicID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "topicId")
        }
        
        let postId: PostID
        if let v: AnyObject = data["postId"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "postId")
            } else {
                do {
                    postId = try PostID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "postId", type: "PostID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "postId")
        }
        
        let count: Int
        if let v: AnyObject = data["count"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "count")
            } else {
                do {
                    count = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "count", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "count")
        }
        
        return Unread(topicId: topicId, postId: postId, count: count)
    }
}


public struct URLAttachment: JSONDecodable {
    public let attachment: Attachment
    public let webUrl: NSURL
    public let apiUrl: NSURL
    public let thumbnails: [Thumbnail]

    public static func parseJSON(data: AnyObject) throws -> URLAttachment {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "URLAttachment", type: "NSDictionary")
        }
    
        let attachment: Attachment
        if let v: AnyObject = data["attachment"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "attachment")
            } else {
                do {
                    attachment = try Attachment.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "attachment", type: "Attachment")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "attachment")
        }
        
        let webUrl: NSURL
        if let v: AnyObject = data["webUrl"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "webUrl")
            } else {
                do {
                    webUrl = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "webUrl", type: "NSURL")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "webUrl")
        }
        
        let apiUrl: NSURL
        if let v: AnyObject = data["apiUrl"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "apiUrl")
            } else {
                do {
                    apiUrl = try NSURL.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "apiUrl", type: "NSURL")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "apiUrl")
        }
        
        let thumbnails: [Thumbnail]
        if let v: AnyObject = data["thumbnails"] {
            if v is NSNull {
                thumbnails = []
            } else {
                do {
                    thumbnails = try Thumbnail.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "thumbnails")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "thumbnails", type: "Thumbnail")
                }
            }
        } else {
            thumbnails = []
        }
        
        return URLAttachment(attachment: attachment, webUrl: webUrl, apiUrl: apiUrl, thumbnails: thumbnails)
    }
}


public struct TalkPost: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID]

    public static func parseJSON(data: AnyObject) throws -> TalkPost {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "TalkPost", type: "NSDictionary")
        }
    
        let topic: Topic
        if let v: AnyObject = data["topic"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "topic")
            } else {
                do {
                    topic = try Topic.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "topic")
        }
        
        let talk: Talk
        if let v: AnyObject = data["talk"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "talk")
            } else {
                do {
                    talk = try Talk.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "talk", type: "Talk")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "talk")
        }
        
        let postIds: [PostID]
        if let v: AnyObject = data["postIds"] {
            if v is NSNull {
                postIds = []
            } else {
                do {
                    postIds = try PostID.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "postIds")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "postIds", type: "PostID")
                }
            }
        } else {
            postIds = []
        }
        
        return TalkPost(topic: topic, talk: talk, postIds: postIds)
    }
}


public struct PostLinksEvent: JSONDecodable {
    public let postId: PostID
    public let links: [Link]

    public static func parseJSON(data: AnyObject) throws -> PostLinksEvent {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "PostLinksEvent", type: "NSDictionary")
        }
    
        let postId: PostID
        if let v: AnyObject = data["postId"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "postId")
            } else {
                do {
                    postId = try PostID.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "postId", type: "PostID")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "postId")
        }
        
        let links: [Link]
        if let v: AnyObject = data["links"] {
            if v is NSNull {
                links = []
            } else {
                do {
                    links = try Link.parseJSONArray(v)
                } catch JSONDecodeError.NonNullablle {
                    throw JSONDecodeError.NonNullablle(key: "links")
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "links", type: "Link")
                }
            }
        } else {
            links = []
        }
        
        return PostLinksEvent(postId: postId, links: links)
    }
}


