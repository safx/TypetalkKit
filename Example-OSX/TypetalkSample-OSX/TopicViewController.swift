//
//  TopicViewController.swift
//  TypetalkSample-OSX
//
//  Created by Safx Developer on 2015/01/29.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Cocoa
import TypetalkKit

class TopicViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    private var topics: [TopicWithUserInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func fetchData() {
        if Client.sharedClient.isSignedIn {
            Client.sharedClient.getTopics { (topics, error) -> Void in
                if error != nil {
                    Client.sharedClient.requestRefreshToken { (err) -> Void in
                        if err == nil {
                            self.fetchData()
                        }
                    }
                } else if let ts = topics? {
                    self.topics = ts.topics
                    self.tableView.reloadData()
                }
            }
        } else {
            Client.sharedClient.authorize { (error) -> Void in
                if (error == nil) {
                    self.fetchData()
                }
            }
        }
    }

    // MARK: - Action

    @IBAction func columnChangeSelected(sender: NSTableView) {
        if countElements(topics) <= sender.selectedRow { return }
        
        let topic = topics[sender.selectedRow]
        let controller = self.parentViewController?.childViewControllers[1] as MessageViewController
        controller.detailItem = topic
    }
    
    // MARK: - Table View

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return topics.count
    }

    func tableView(tableView: NSTableView, viewForTableColumn: NSTableColumn, row: Int) -> NSView {
        var cell = tableView.makeViewWithIdentifier("TopicCell", owner: nil) as NSTableCellView
        cell.textField?.stringValue = topics[row].topic.name
        return cell
    }
}
