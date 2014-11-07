//
//  DetailViewController.swift
//  iOSExample
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import TypetalkKit

class DetailViewController: UITableViewController {
    var messages: GetMessagesResponse? = nil
    var detailItem: TopicWithUserInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = detailItem?.topic.name
        getMessages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMessages() {
        if let topic = detailItem? {
            let topicid = topic.topic.id
            Client.sharedClient.getMessages(topicid) { (messages, error) -> Void in
                if error != nil {
                    // TODO
                } else if let ms = messages? {
                    self.messages = ms
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages? == nil ? 0 : messages!.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let m = messages!.posts[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as MessageCell
        cell.model = m
        return cell
    }
}

