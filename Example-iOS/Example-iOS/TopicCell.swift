//
//  TopicCell.swift
//  iOSExample
//
//  Created by Safx Developer on 2014/09/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import TypetalkKit

class TopicCell: UITableViewCell {
    @IBOutlet fileprivate weak var name: UILabel!
    @IBOutlet fileprivate weak var lastUpdate: UILabel!

    var model: TopicWithUserInfo? {
        didSet {
            name.text = model!.topic.name

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = NSLocalizedString("MMM d yyyy", comment:"file date time (this format uses Unicode standard)")
            lastUpdate.text = dateFormatter.string(from: model!.topic.updatedAt)
        }
    }
}
