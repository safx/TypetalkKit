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
    var posts = [Post]()
    var detailItem: TopicWithUserInfo? = nil
    var ws: TypetalkStream!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = detailItem?.topic.name
        getMessages()

        weak var weakTableView = self.tableView
        ws = TypetalkStream(accessToken: TypetalkAPI.accessToken!) { (event) in
            switch event {
            case .Connected             : print("connected")
            case .Disconnected(let err) : print("disconnected: \(err)")
            case .PostMessage(let res)  :
                self.appendNewPost(res.post!)
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    weakTableView?.reloadData()
                }
            default: ()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMessages() {
        if let topic = detailItem {
            let topicid = topic.topic.id

            TypetalkAPI.sendRequest(GetMessages(topicId: topicid)) { result -> Void in
                switch result {
                case .Success(let ms):
                    self.posts = ms.posts
                    self.tableView.reloadData()
                case .Failure(let error):
                    print(error)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        cell.model = m
        return cell
    }

    func appendNewPost(post: Post) {
        let row = posts.count
        posts.append(post)
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
}

