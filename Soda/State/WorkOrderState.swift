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
    var selectedWorkOrder: WorkOrder?
    var shouldShowDetail = false
    
    mutating func react(to event: Event) {
        switch event {
        case let event as Loaded<[WorkOrder]>:
            workOrders = event.item
        case let event as Selected<WorkOrder>:
            selectedWorkOrder = event.item
            shouldShowDetail = true
        case _ as Reset<WorkOrder>:
            selectedWorkOrder = nil
        case _ as DisplayedDetail:
            shouldShowDetail = false
        default:
            break
        }
    }
    
}
