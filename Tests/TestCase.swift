//
//  TestCase.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/14.
//  Copyright (c) 2014年 Safx. All rights reserved.
//

import Foundation
import XCTest

class TestCase : XCTestCase {
    func json(name: String) -> [String:AnyObject] {
        var error: NSError? = nil
        //let bundle = NSBundle.mainBundle()
        let bundle = NSBundle(forClass: TestCase.self)
        let path = bundle.pathForResource(name, ofType: "json")
        let data = NSData(contentsOfFile: path!, options: nil, error: &error)
        let dic = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as NSDictionary?
        assert(dic != nil && error == nil)
        return dic as [String:AnyObject]
    }
}