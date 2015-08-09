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
    @IBOutlet private weak var message: UILabel!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var lastUpdate: UILabel!
    @IBOutlet private weak var accountImage: UIImageView!

    private class var _cache: NSCache {
        struct Static {
            static let instance = NSCache()
        }
        return Static.instance
    }

    var model: Post? {
        didSet {
            message.text = model!.message
            userName.text = model!.account.name

            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = NSLocalizedString("MMM d yyyy", comment:"file date time (this format uses Unicode standard)")
            lastUpdate.text = dateFormatter.stringFromDate(model!.updatedAt)

            let url = model!.account.imageUrl.absoluteString
            let data = MessageCell._cache.objectForKey(url) as? NSData
            if data != nil {
                self.accountImage.image = UIImage(data: data!)
            } else {
                Alamofire.request(.GET, url)
                         .response { (request, response, data, error) in
                            if let data = data {
                                MessageCell._cache.setObject(data, forKey: url)
                                self.accountImage.image = UIImage(data: data)
                            }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
