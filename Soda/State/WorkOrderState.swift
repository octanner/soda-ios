//
//  WorkOrderState.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation

struct WorkOrderState: State {
    
    var workOrders = [WorkOrder]()
    
    mutating func react(to event: Event) {
        switch event {
        default:
            break
        }
    }
    
}
