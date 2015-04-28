/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import XCTest

class RelativeDatesTests: XCTestCase {
    func testRelativeDates() {
        let dateOrig = NSDate()
        var date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        
        XCTAssertTrue(date.toRelativeTimeString() == "Just now")

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-10)
        XCTAssertTrue(date.toRelativeTimeString() == "Just now")

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-60)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        XCTAssertTrue(date.toRelativeTimeString() == ("Today at " + dateFormatter.stringFromDate(date)))

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-60 * 60 * 24)
        XCTAssertTrue(date.toRelativeTimeString() == "Yesterday")

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-60 * 60 * 24 * 2)
        XCTAssertTrue(date.toRelativeTimeString() == "This week")

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-60 * 60 * 24 * 7)
        XCTAssertTrue(date.toRelativeTimeString() == "More than a week ago")

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-60 * 60 * 24 * 7 * 5)
        XCTAssertTrue(date.toRelativeTimeString() == "More than a month ago")

        dateFormatter.dateFormat = "M/d/YY, h:mm a"

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-60 * 60 * 24 * 7 * 5 * 2)
        XCTAssertTrue(date.toRelativeTimeString() == dateFormatter.stringFromDate(date))

        date = NSDate(timeInterval: 0, sinceDate: dateOrig)
        date = date.dateByAddingTimeInterval(-60 * 60 * 24 * 7 * 5 * 12 * 2)
        XCTAssertTrue(date.toRelativeTimeString() == dateFormatter.stringFromDate(date))
    }
}