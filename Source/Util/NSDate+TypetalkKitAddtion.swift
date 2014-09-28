//
//  NSDate+TypetalkKitAddtion.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

extension NSDate {
    
    public func humanReadableTimeInterval(#sinceDate: NSDate) -> String {
        let i = Int(self.timeIntervalSinceDate(sinceDate))
        if i < 3600 {
            let min = i / 60
            if min < 2 {
                return NSLocalizedString("1 minute ago", comment:"time interval: 1 min")
            }
            return NSLocalizedString("\(min) minutes ago", comment:"time interval: min")
        } else if i < 86400 {
            let hour = i / 3600
            if hour < 2 {
                return NSLocalizedString("1 hour ago", comment:"time interval: 1 hour")
            }
            return NSLocalizedString("\(hour) hours ago", comment:"time interval: hour")
        } else if i < 14 * 86400 {
            let day = i / 86400
            if day < 2 {
                return NSLocalizedString("1 day ago", comment:"time interval: 1 day")
            }
            return NSLocalizedString("\(day) days ago", comment:"time interval: day")
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSLocalizedString("MMM d yyyy", comment:"file date time (this format uses Unicode standard)")
        return dateFormatter.stringFromDate(sinceDate)
    }
    
}