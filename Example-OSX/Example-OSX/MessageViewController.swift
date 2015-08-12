//
//  MessageViewController.swift
//  TypetalkSample-OSX
//
//  Created by Safx Developer on 2015/01/29.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import AppKit
import Cocoa
import TypetalkKit

class MessageViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    private var messages: GetMessagesResponse? = nil
    var detailItem: TopicWithUserInfo? = nil {
        didSet {
            getMessages()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = detailItem?.topic.name
    }

    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func getMessages() {
        if let topic = detailItem {
            let topicid = topic.topic.id
            TypetalkAPI.sendRequest(GetMessages(topicId: topicid)) { result -> Void in
                switch result {
                case .Success(let ms):
                    self.messages = ms
                    self.tableView.reloadData()
                case .Failure(let error):
                    print(error)
                }
            }
        }
    }

    // MARK: - Table View

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return messages == nil ? 0 : messages!.posts.count
    }

    func tableView(tableView: NSTableView, viewForTableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("MessageCell", owner: nil) as! MessageCell
        cell.model = messages!.posts[row]
        return cell
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let font = NSFont(name: "Helvetica", size: 13)!
        let attr: [String:AnyObject] = [NSFontAttributeName: font]
        let mes = messages!.posts[row].message
        
        let size = (mes as NSString).sizeWithAttributes(attr)

        return max(size.height + 32, 56)
    }
}
