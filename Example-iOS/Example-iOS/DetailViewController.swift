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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension

        self.title = detailItem?.topic.name
        getMessages()

        weak var weakTableView = self.tableView
        _ = TypetalkAPI.streaming { (event) in
            switch event {
            case .connected             : print("connected")
            case .disconnected(let err) : print("disconnected: \(String(describing: err))")
            case .postMessage(let res)  :
                self.append(newPost: res.post!)
                DispatchQueue.main.async { () -> Void in
                    weakTableView?.reloadData()
                }
            default: ()
            }
        }
    }

    fileprivate func getMessages() {
        if let topic = detailItem {
            let topicid = topic.topic.id

            TypetalkAPI.send(GetMessages(topicId: topicid)) { result -> Void in
                switch result {
                case .success(let ms):
                    self.posts = ms.posts
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let m = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.model = m
        return cell
    }

    fileprivate func append(newPost post: Post) {
        let row = posts.count
        posts.append(post)
        let indexPath = IndexPath(row: row, section: 0)
        tableView.insertRows(at: [indexPath], with: .none)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
