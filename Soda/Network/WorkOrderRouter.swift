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
        case getWorkOrders(Bool, Int?)
        
        var method: HTTPMethod {
            switch self {
            case .getWorkOrders:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getWorkOrders:
                return "/v1/work_orders"
                
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            var url = try Router.baseURLString.asURL()
            url = url.appendingPathComponent(path)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            
            switch self {
            case let .getWorkOrders(active, userId):
                var params = Parameters()
                if active  {
                    params[Keys.active] = active
                }
                if let userId = userId {
                    params[Keys.userId] = userId
                }
                if !params.isEmpty {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
                }
            }
            return urlRequest
        }
        
    }
    
}
