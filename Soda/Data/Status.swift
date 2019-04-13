//
//  Status.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation

struct Status: Codable {
   
    let id: Int
    let name: Name
    
    enum Name: String, Codable {
        case estimate = "Estimate/Customer Approval"
        case toBeOrdered = "Items To Be Ordered"
        case design = "CAD/Design"
        case casting = "Casting"
        case assembly = "Assembly/Setting"
        case receiving = "Receiving/Appraisal"
        case customerService = "Customer Service/Pickup"
        case sold = "Sold"
        case closed = "Closed"
    }
    
}
