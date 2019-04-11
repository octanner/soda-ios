//
//  WorkOrderRouter.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation
import Alamofire

enum Router {
    static let baseURLString = "http://soda-api.dev.octanner.net"
}

extension Router {
    
    enum WorkOrder: URLRequestConvertible {
        // Fetches all work orders
        case getAllWorkOrders
        
        var method: HTTPMethod {
            switch self {
            case .getAllWorkOrders:
                return .get
            }
        }
        
        var path: String {
            switch self {
            // /v1/feedback-requests
            case .getAllWorkOrders:
                return "/v1/work_orders"
                
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            var url = try Router.baseURLString.asURL()
            url = url.appendingPathComponent(path)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            
            switch self {
            case .getAllWorkOrders:
                break
            }
            return urlRequest
        }
        
    }
    
}
