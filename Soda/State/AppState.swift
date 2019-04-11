//
//  AppState.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation

enum App {
    
    static var sharedCore = Core(state: AppState(), middlewares: [])
    
}

struct AppState: State {
    
    var workOrderState = WorkOrderState()
    
    mutating func react(to event: Event) {
        switch event {
        default:
            break
        }
        workOrderState.react(to: event)
    }
    
}
