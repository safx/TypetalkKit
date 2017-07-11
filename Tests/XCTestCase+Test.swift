//
//  TestUtil.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/14.
//  Copyright (c) 2014年 Safx. All rights reserved.
//

import Foundation
import XCTest
@testable import TypetalkKit

extension XCTestCase {
    func path(_ name: String) -> String {
        let bundle = Bundle(for: ClientAPITests.self)
        return bundle.path(forResource: name, ofType: "json")!
    }

    func json(_ name: String) -> [String:AnyObject] {
        let data = try? Data(contentsOf: URL(fileURLWithPath: path(name)), options: [])
        assert(data != nil)

        do {
            let dic = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
            //assert(dic != nil && error == nil)
            return dic as! [String:AnyObject]
        } catch {

        }
        fatalError()
    }

    func streaming_json(_ name: String) -> [String:AnyObject] {
        let j = json("streaming-\(name)")
        let data: AnyObject? = j["data"]
        return data as! [String:AnyObject]!
    }
}
