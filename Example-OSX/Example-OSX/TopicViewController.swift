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
    fileprivate var topics: [TopicWithUserInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
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
                    TopicViewController.startObserving()
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

    func fetchTopic(spaceKey: String) {
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

    // MARK: - Streaming

    fileprivate static var observing: Bool = false

    fileprivate static func startObserving() {
        _ = TypetalkAPI.streaming { event in
            switch event {
            case .disconnected(let error):
                observing = true
                print("WS: Error", error.debugDescription)
            case .connected:
                observing = false
                print("WS: Connected")
            default:
                print("WS:", event)
            }
        }
    }

    // MARK: - Action

    @IBAction func columnChangeSelected(_ sender: NSTableView) {
        if topics.count <= sender.selectedRow { return }

        let topic = topics[sender.selectedRow]
        let controller = self.parent?.childViewControllers[1] as! MessageViewController
        controller.detailItem = topic
    }

    // MARK: - Table View

    func numberOfRows(in tableView: NSTableView) -> Int {
        return topics.count
    }

    func tableView(_ tableView: NSTableView, viewFor viewForTableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "TopicCell", owner: nil) as! NSTableCellView
        cell.textField?.stringValue = topics[row].topic.name
        return cell
    }
}
