//
//  MessageCell.swift
//  TypetalkSample-OSX
//
//  Created by Safx Developer on 2015/01/31.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Cocoa
import Alamofire
import TypetalkKit
import APIKit

class MessageCell: NSTableCellView {
    
    @IBOutlet weak var accountImage: NSImageView!
    @IBOutlet weak var accountName: NSTextField!
    
    var model: Post? {
        didSet {
            textField?.stringValue = model!.message
            accountName.stringValue = model!.account.name
            
            let url = model!.account.imageUrl.absoluteString
             Alamofire.request(.GET, url)
                .response { (request, response, data, error) in
                    if let d = data {
                        self.accountImage.image = NSImage(data: d)
                    }
                }
        }
    }
}
