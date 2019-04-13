//
//  DateHelpers.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func date() -> Date? {
        return Date.ISO8601YearMonthDayFormatter.date(from: self)
    }
    
}

extension Date {
    
    func monthDayYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
    
    func daysUntilColor() -> UIColor {
        let timeRemainingInterval = abs(self.timeIntervalSinceNow)
        if timeRemainingInterval < 2.days {
            return .danger
        } else if timeRemainingInterval < 5.days {
            return .warning
        } else {
            return .safe
        }
    }
    
    /// E.g. "1937-11-23"
    public var iso8601DateString: String {
        return Date.ISO8601YearMonthDayFormatter.string(from: self)
    }
    
}

public extension Date {
    
    static fileprivate let ISO8601MillisecondFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static fileprivate let ISO8601SecondFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static fileprivate let ISO8601YearMonthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static fileprivate let formatters = [ISO8601MillisecondFormatter, ISO8601SecondFormatter, ISO8601YearMonthDayFormatter]
    
    static func fromISO8601(string: String) -> Date? {
        for formatter in formatters {
            if let date = formatter.date(from: string) {
                return date
            }
        }
        return .none
    }
}


// MARK: - Time intervals on Int

public extension Int {
    
    var seconds: TimeInterval {
        return TimeInterval(self)
    }
    
    var minutes: TimeInterval {
        return TimeInterval(self * 60)
    }
    
    var hours: TimeInterval {
        return TimeInterval(minutes * 60)
    }
    
    var days: TimeInterval {
        return TimeInterval(hours * 24)
    }
    
    var weeks: TimeInterval {
        return TimeInterval(days * 7)
    }
    
}
