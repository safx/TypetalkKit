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
    fileprivate var messages: GetMessagesResponse? = nil
    var detailItem: TopicWithUserInfo? = nil {
        didSet {
            getMessages()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = detailItem?.topic.name
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func getMessages() {
        if let topic = detailItem {
            let topicid = topic.topic.id
            TypetalkAPI.send(GetMessages(topicId: topicid)) { result -> Void in
                switch result {
                case .success(let ms):
                    self.messages = ms
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    // MARK: - Table View

    func numberOfRows(in tableView: NSTableView) -> Int {
        return messages == nil ? 0 : messages!.posts!.count
    }

    func tableView(_ tableView: NSTableView, viewFor viewForTableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "MessageCell", owner: nil) as! MessageCell
        cell.model = messages!.posts?[row]
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let font = NSFont(name: "Helvetica", size: 13)!
        let attr: [String:AnyObject] = [NSFontAttributeName: font]
        let mes = messages!.posts![row].message
        
        let size = (mes as NSString).size(withAttributes: attr)

        return max(size.height + 32, 56)
    }
}
