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
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var lastUpdate: UILabel!

    var model: TopicWithUserInfo? {
        didSet {
            name.text = model!.topic.name

            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = NSLocalizedString("MMM d yyyy", comment:"file date time (this format uses Unicode standard)")
            lastUpdate.text = dateFormatter.stringFromDate(model!.topic.updatedAt)
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
