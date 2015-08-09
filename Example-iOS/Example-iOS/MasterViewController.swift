//
//  MasterViewController.swift
//  iOSExample
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import TypetalkKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var topics: [TopicWithUserInfo] = []


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }*/

        fetchData()
    }
    
    func fetchData() {

        if TypetalkAPI.isSignedIn {
            TypetalkAPI.sendRequest(GetTopics()) { result in
                switch result {
                case .Success(let ts):
                    self.topics = ts.topics
                    self.tableView.reloadData()
                case .Failure(let error):
                    print(error)
                    TypetalkAPI.requestRefreshToken { (err) -> Void in
                        if err == nil {
                            self.fetchData()
                        }
                    }
                }
            }
        } else {
            TypetalkAPI.authorize { (error) -> Void in
                if (error == nil) {
                    self.fetchData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let topic = topics[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = topic
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as! TopicCell

        let topic = topics[indexPath.row]
        cell.model = topic
        return cell
    }
}

