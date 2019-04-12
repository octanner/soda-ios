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
    static let baseURLString = "https://development-gateway.api.octanner.net/css/soda/"
}

extension Router {
    
    enum WorkOrder: URLRequestConvertible {
        // Fetches all work orders
        case getWorkOrders(Int?, OrderState, Status?)
        
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
            case let .getWorkOrders(userId, orderState, status):
                var params = Parameters()
                switch orderState {
                case .active:
                    params[Keys.active] = true
                case .inProgress:
                    params[Keys.inProgress] = true
                case .all:
                    break
                }
                if let userId = userId {
                    params[Keys.userId] = userId
                }
                if let status = status {
                    params[Keys.statusId] = status.id
                }
                if !params.isEmpty {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
                }
            }
            return urlRequest
        }
        
    }
    
}
