//
//  WorkOrderType.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation
import UIKit

struct WorkOrderType: Codable {
    
    let id: Int
    let name: Name
    
    enum Name: String, Codable {
        case repair
        case custom
        case signature
        case stock
        case stockSignature = "stock signature"
        
        var color: UIColor {
            switch self {
            case .repair:
                return UIColor.repair
            case .custom:
                return UIColor.custom
            case .signature:
                return UIColor.signature
            case .stock:
                return UIColor.stock
            case .stockSignature:
                return UIColor.stockSignature
            }
        }
        
    }
    
}
