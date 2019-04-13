//
//  WorkOrder.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

struct WorkOrderResponse: Codable {
    let workOrders: [WorkOrder]
    
    enum CodingKeys: String, CodingKey {
        case workOrders = "work_orders"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        workOrders = try values.decode([WorkOrder].self, forKey: .workOrders)
    }
    
}

final class WorkOrderClass: NSObject, NSItemProviderWriting, NSItemProviderReading, Codable {

    let id: Int
    let workOrderNumber: Int
    let customerName: String
    let location: String
    let ascRepairStation: String
    let dueDate: String
    let status: Status
    let assignedUser: User
    let salesUser: User
    let workOrderType: WorkOrderType
    let notes: [Note]

    init(workOrder: WorkOrder) {
        id = workOrder.id
        workOrderNumber = workOrder.workOrderNumber
        customerName = workOrder.customerName
        location = workOrder.location
        ascRepairStation = workOrder.ascRepairStation
        dueDate = workOrder.dueDate.iso8601DateString
        status = workOrder.status
        assignedUser = workOrder.assignedUser
        salesUser = workOrder.salesUser
        workOrderType = workOrder.workOrderType
        notes = workOrder.notes
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case workOrderNumber = "work_order_number"
        case customerName = "customer_name"
        case location = "abbreviated_location"
        case ascRepairStation = "asc_repair_station"
        case dueDate = "due_date"
        case status
        case assignedUser = "assigned_user"
        case salesUser = "sales_user"
        case workOrderType = "work_order_type"
        case notes
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        workOrderNumber = try values.decode(Int.self, forKey: .workOrderNumber)
        customerName = try values.decode(String.self, forKey: .customerName)
        location = try values.decode(String.self, forKey: .location)
        ascRepairStation = try values.decode(String.self, forKey: .ascRepairStation)
        dueDate = try values.decode(String.self, forKey: .dueDate)
        status = try values.decode(Status.self, forKey: .status)
        assignedUser = try values.decode(User.self, forKey: .assignedUser)
        salesUser = try values.decode(User.self, forKey: .salesUser)
        workOrderType = try values.decode(WorkOrderType.self, forKey: .workOrderType)
        notes = try values.decode([Note].self, forKey: .notes)
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            let json = String(data: data, encoding: String.Encoding.utf8)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            
            completionHandler(nil, error)
        }
        
        return progress
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
    }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> WorkOrderClass {
        let decoder = JSONDecoder()
        do {
            let workOrderClass = try decoder.decode(WorkOrderClass.self, from: data)
            return workOrderClass
        } catch {
            print(error)
            fatalError("Err")
        }
        
    }
    
}



struct WorkOrder {
    
    let id: Int
    let workOrderNumber: Int
    let customerName: String
    let location: String
    let ascRepairStation: String
    let dueDate: Date
    var status: Status
    let assignedUser: User
    let salesUser: User
    let workOrderType: WorkOrderType
    let notes: [Note]
    
    init(workOrder: WorkOrderClass) {
        id = workOrder.id
        workOrderNumber = workOrder.workOrderNumber
        customerName = workOrder.customerName
        location = workOrder.location
        ascRepairStation = workOrder.ascRepairStation
        dueDate = workOrder.dueDate.date()!
        status = workOrder.status
        assignedUser = workOrder.assignedUser
        salesUser = workOrder.salesUser
        workOrderType = workOrder.workOrderType
        notes = workOrder.notes
    }
}

extension WorkOrder: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case workOrderNumber = "work_order_number"
        case customerName = "customer_name"
        case location = "abbreviated_location"
        case ascRepairStation = "asc_repair_station"
        case dueDate = "due_date"
        case status
        case assignedUser = "assigned_user"
        case salesUser = "sales_user"
        case workOrderType = "work_order_type"
        case notes
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        workOrderNumber = try values.decode(Int.self, forKey: .workOrderNumber)
        customerName = try values.decode(String.self, forKey: .customerName)
        location = try values.decode(String.self, forKey: .location)
        ascRepairStation = try values.decode(String.self, forKey: .ascRepairStation)
        let dueDateString = try values.decode(String.self, forKey: .dueDate)
        dueDate = dueDateString.date()!
        status = try values.decode(Status.self, forKey: .status)
        assignedUser = try values.decode(User.self, forKey: .assignedUser)
        salesUser = try values.decode(User.self, forKey: .salesUser)
        workOrderType = try values.decode(WorkOrderType.self, forKey: .workOrderType)
        notes = try values.decode([Note].self, forKey: .notes)
    }
    
}


// MARK: - Date sortable

extension WorkOrder: DateSortable {
    
    var sortDate: Date {
        return dueDate
    }
    
}


// MARK: - Equatable

extension WorkOrder: Equatable { }

func ==(lhs: WorkOrder, rhs: WorkOrder) -> Bool {
    return lhs.id == rhs.id
}
