//
//  DateHelpers.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation

extension String {
    
    func date() -> Date? {
        return Date.ISO8601YearMonthDayFormatter.date(from: self)
    }
    
}

extension Date {
    
    func monthDayYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd, yyyy"
        return formatter.string(from: self)
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
