/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation

public typealias Timestamp = UInt64

public let OneMonthInMilliseconds = 30 * OneDayInMilliseconds
public let OneWeekInMilliseconds = 7 * OneDayInMilliseconds
public let OneDayInMilliseconds = 24 * OneHourInMilliseconds
public let OneHourInMilliseconds = 60 * OneMinuteInMilliseconds
public let OneMinuteInMilliseconds: Timestamp = 60 * 1000

extension NSDate {
    public class func now() -> Timestamp {
        return UInt64(1000 * NSDate().timeIntervalSince1970)
    }
    
    public func toRelativeTimeString() -> String {
        
        let now = NSDate()
        
        let units = NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitHour
        
        let components = NSCalendar.currentCalendar().components(units, fromDate: self, toDate: now, options: NSCalendarOptions.allZeros)

        let formatter = NSDateFormatter()
        
        if components.year > 0 {
            return String(format: NSLocalizedString("%@", comment: "relative time"), NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle))
        } else if components.month > 0 {
            if components.month == 1 {
                return String(format: NSLocalizedString("More than a month ago", comment: "relative time"))
            }
            else
            {
                return String(format: NSLocalizedString("%@", comment: "relative time"), NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle))
            }
        } else if components.weekOfYear > 0 {
            return String(format: NSLocalizedString("More than a week ago", comment: "relative time"))
        } else if components.day > 0 {
            if components.day > 1 {
                return String(format: NSLocalizedString("This week", comment: "relative time"), String(components.day))
            } else if components.day == 1 {
                return String(format: NSLocalizedString("Yesterday", comment: "relative time"))
            }
        } else if components.hour > 0 || components.minute > 0{
            formatter.timeStyle = .ShortStyle
            return String(format: NSLocalizedString("Today at %@", comment: "relative time"), formatter.stringFromDate(self))
        }

        return String(format: NSLocalizedString("Just now", comment: "relative time"))
    }
}

public func decimalSecondsStringToTimestamp(input: String) -> Timestamp? {
    if let double = NSScanner(string: input).scanDouble() {
        return Timestamp(double * 1000)
    }
    return nil
}

public func millisecondsToDecimalSeconds(input: Timestamp) -> String {
    let val: Double = Double(input) / 1000
    return String(format: "%.2F", val)
}

extension Timestamp {
    public func toNSDate() -> NSDate {
        return NSDate(timeIntervalSince1970: NSTimeInterval(self / 1000))
    }
}
