//
//  DetailViewController.swift
//  iOSExample
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import TypetalkKit

class DetailViewController: UITableViewController, TypetalkStreamingDelegate {
    var posts = [Post]()
    var detailItem: TopicWithUserInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = detailItem?.topic.name
        getMessages()
        
        Client.sharedClient.delegate = self
        Client.sharedClient.streaming()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMessages() {
        if let topic = detailItem? {
            let topicid = topic.topic.id
            Client.sharedClient.getMessages(topicid, count: nil, from: nil, direction: nil) { (messages, error) -> Void in
                if error != nil {
                    // TODO
                } else if let ms = messages? {
                    self.posts = ms.posts
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
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let m = posts[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as MessageCell
        cell.model = m
        return cell
    }

    // MARK: - TypetalkStreamingDelegate funcs
    
    func streamDidReceive(client: Client, event: StreamingEvent) {
        switch event {
        case .Connect               : println("connected")
        case .Disconnect(let err)   : println("disconnected: \(err)")
        case .PostMessage(let res)  : appendNewPost(res.post!)
        case .LikeMessage(let res)  : println("like: \(res)")
        case .UnlikeMessage(let res): println("unlike: \(res)")
        case .Unknown(let (t, d))   : println("unknown: \(t) \(d)")
        }
    }
    
    func appendNewPost(post: Post) {
        let row = posts.count
        posts.append(post)
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
}

