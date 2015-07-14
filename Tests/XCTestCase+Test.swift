//
//  TestUtil.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/14.
//  Copyright (c) 2014年 Safx. All rights reserved.
//

import Foundation
import XCTest


extension XCTestCase {
    func path(name: String) -> String {
        let bundle = NSBundle(forClass: ClientTests.self)
        return bundle.pathForResource(name, ofType: "json")!
    }

    func json(name: String) -> [String:AnyObject] {
        var error: NSError? = nil
        let data: NSData?
        do {
            data = try NSData(contentsOfFile: path(name), options: [])
        } catch let error1 as NSError {
            error = error1
            data = nil
        }
        
        do {
            let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            //assert(dic != nil && error == nil)
            return dic as! [String:AnyObject]
        } catch {

        }
        fatalError()
    }

    func streaming_json(name: String) -> [String:AnyObject] {
        let j = json("streaming-\(name)")
        let data: AnyObject? = j["data"]
        return data as! [String:AnyObject]!
    }
}