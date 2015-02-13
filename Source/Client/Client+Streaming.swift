//
//  Client+Streaming.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import TypetalkKit
import Starscream


public enum StreamingEvent {
    case Connect
    case Disconnect(NSError?)
    case PostMessage(PostMessageResponse)
    //case SaveBookmark
    case LikeMessage(LikeMessageResponse)
    case UnlikeMessage(LikeMessageResponse)
    case Unknown(String, [String:AnyObject])
}

public protocol TypetalkStreamingDelegate: class {
    func streamDidReceive(client: Client, event: StreamingEvent)
}

// MARK: Typetalk Streaming API

private var g_stream_delegate: TypetalkStreamingDelegate?

extension Client : WebSocketDelegate {

    private var socket : WebSocket {
        struct Static {
            static let instance = WebSocket(url: Router.Streaming.URLRequest.URL)
        }
        return Static.instance
    }

    public var delegate : TypetalkStreamingDelegate? {
        get { return g_stream_delegate }
        set { g_stream_delegate = newValue }
    }
    
    public func streaming() -> Bool {
        switch oauth2.state {
        case .SignedIn(let (credential)):
            socket.headers["Authorization"] = "Bearer \(credential.accessToken)"
            socket.delegate = self
            socket.connect()
            return true
        default:
            return false
        }
    }

    // MARK: WebSocketDelegate funcs

    private func sendStreamEventIfPossible(event: StreamingEvent?) {
        if let ev = event {
            if let dl = delegate {
                dl.streamDidReceive(self, event: ev)
            }
        }
    }
    
    public func websocketDidConnect(socket: WebSocket) {
        sendStreamEventIfPossible(.Connect)
    }
    
    public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        sendStreamEventIfPossible(.Disconnect(error))
    }

    public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        let jsondata = text.dataUsingEncoding(NSUnicodeStringEncoding)!
        let json = NSJSONSerialization.JSONObjectWithData(jsondata, options: nil, error: nil) as [String:AnyObject]
        let type = json["type"] as? String
        let data = json["data"] as? [String:AnyObject]
        if type != nil && data != nil {
            var event: StreamingEvent?
            if type == "postMessage" {
                event = .PostMessage(PostMessageResponse(data: data!))
            } else if type == "likeMessage" {
                event = .LikeMessage(LikeMessageResponse(data: data!))
            } else if type == "unlikeMessage" {
                // FIXME: UnlikeMessageResponse should be used.
                event = .UnlikeMessage(LikeMessageResponse(data: data!))
            } else {
                event = .Unknown(type!, data!)
            }
            
            sendStreamEventIfPossible(event)
        }
    }
    
    public func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        fatalError("Never be called")
    }
    
}