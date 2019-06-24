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
        if UIDevice.current.userInterfaceIdiom == .pad {
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
        fetchSpace()
    }

    func fetchSpace() {
        if TypetalkAPI.isSignedIn {
            TypetalkAPI.send(GetSpaces()) { result in
                switch result {
                case .success(let ss):
                    guard let mySpace = ss.mySpaces.last else { return }
                    self.fetchTopic(spaceKey: mySpace.space.key)
                case .failure(let error):
                    print(error)
                    _ = TypetalkAPI.requestRefreshToken { (err) -> Void in
                        if err == nil {
                            self.fetchData()
                        } else {
                            TypetalkAPI.authorize { (error) -> Void in
                                if (error == nil) {
                                    self.fetchData()
                                }
                            }
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

    fileprivate func fetchTopic(spaceKey: String) {

        if TypetalkAPI.isSignedIn {
            TypetalkAPI.send(GetTopics(spaceKey: spaceKey)) { result in
                switch result {
                case .success(let ts):
                    self.topics = ts.topics
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                    _ = TypetalkAPI.requestRefreshToken { (err) -> Void in
                        if err == nil {
                            self.fetchData()
                        } else {
                            TypetalkAPI.authorize { (error) -> Void in
                                if (error == nil) {
                                    self.fetchData()
                                }
                            }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let topic = topics[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = topic
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell

        let topic = topics[indexPath.row]
        cell.model = topic
        return cell
    }
}

