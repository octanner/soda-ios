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
    var workOrdersLoaded = false
    
    mutating func react(to event: Event) {
        switch event {
        case let event as Loaded<[WorkOrder]>:
            workOrders = event.item
            workOrdersLoaded = true
        case let event as Selected<WorkOrder>:
            selectedWorkOrder = event.item
            shouldShowDetail = true
        case let event as Updated<WorkOrder>:
            guard let index = workOrders.firstIndex(of: event.item) else { break }
            workOrders[index] = event.item
        case _ as Reset<WorkOrder>:
            selectedWorkOrder = nil
            shouldShowDetail = false
        case _ as DisplayedDetail:
            shouldShowDetail = false
        default:
            break
        }
    }
    
}
