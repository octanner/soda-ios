//
//  SortByDate.swift
//  Soda
//
//  Created by Derik Flanary on 4/12/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation

public protocol DateSortable {
    var sortDate: Date { get }
}


// MARK: - Sorting functions

public extension Collection where Self.Iterator.Element: DateSortable {
    
    public func sortedByDate(ascending: Bool = true) -> [Self.Iterator.Element] {
        return self.sorted(by: ascending ? sortAscending : sortDescending)
    }
    
    fileprivate func sortAscending(_ first: DateSortable, _ second: DateSortable) -> Bool {
        return (first.sortDate as NSDate).earlierDate(second.sortDate) == first.sortDate
    }
    
    fileprivate func sortDescending(_ first: DateSortable, _ second: DateSortable) -> Bool {
        return (first.sortDate as NSDate).laterDate(second.sortDate) == first.sortDate
    }
    
}
