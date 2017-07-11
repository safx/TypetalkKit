//
//  MessageCell.swift
//  iOSExample
//
//  Created by Safx Developer on 2014/09/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import TypetalkKit
import Alamofire
import APIKit

class MessageCell: UITableViewCell {
    @IBOutlet fileprivate weak var message: UILabel!
    @IBOutlet fileprivate weak var userName: UILabel!
    @IBOutlet fileprivate weak var lastUpdate: UILabel!
    @IBOutlet fileprivate weak var accountImage: UIImageView!

    fileprivate class var _cache: NSCache<NSString, UIImage> {
        struct Static {
            static let instance = NSCache<NSString, UIImage>()
        }
        return Static.instance
    }

    var model: Post? {
        didSet {
            message.text = model!.message
            userName.text = model!.account.name

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = NSLocalizedString("MMM d yyyy", comment:"file date time (this format uses Unicode standard)")
            lastUpdate.text = dateFormatter.string(from: model!.updatedAt)

            let url = model!.account.imageUrl.absoluteString
            if let image = MessageCell._cache.object(forKey: url as NSString) {
                self.accountImage.image = image
            } else {
                Alamofire.request(url)
                         .response { response in
                            if let data = response.data, let image = UIImage(data: data) {
                                MessageCell._cache.setObject(image, forKey: url as NSString)
                                self.accountImage.image = image
                            }
                }
            }
        }
    }
}
