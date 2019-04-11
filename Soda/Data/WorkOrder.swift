//
//  WorkOrder.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation
import UIKit

struct WorkOrder: Codable {
    
    
    let id: Int
    let workOrderNumber: Int
    let customerName: String
    let location: String
    let ascRepairStation: String
    let dueDate: String
    let createdAt: String
    let status: Status
    let assignedUser: User
    let salesUser: User
    let workOrderType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case workOrderNumber = "work_order_number"
        case customerName = "customer_name"
        case location
        case ascRepairStation = "asc_repair_station"
        case dueDate = "due_date"
        case createdAt = "created_at"
        case status
        case assignedUser = "assigned_user"
        case salesUser = "sales_user"
        case workOrderType = "work_order_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        workOrderNumber = try values.decode(Int.self, forKey: .workOrderNumber)
        customerName = try values.decode(String.self, forKey: .customerName)
        location = try values.decode(String.self, forKey: .location)
        ascRepairStation = try values.decode(String.self, forKey: .ascRepairStation)
        dueDate = try values.decode(String.self, forKey: .dueDate)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        status = try values.decode(Status.self, forKey: .status)
        assignedUser = try values.decode(User.self, forKey: .assignedUser)
        salesUser = try values.decode(User.self, forKey: .salesUser)
        workOrderType = try values.decode(String.self, forKey: .workOrderType)
    }
    
}
