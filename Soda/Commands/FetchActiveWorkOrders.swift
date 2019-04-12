//
//  FetchActiveWorkOrders.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation
import Alamofire

enum OrderState {
    case active
    case inProgress
    case all
}

struct FetchWorkOrders: Command {
    let userId: Int?
    let orderState: OrderState
    let status: Status?
    
    
    init(for userId: Int?, orderState: OrderState, status: Status? = nil) {
        self.userId = userId
        self.orderState = orderState
        self.status = status
    }
    
    func execute(state: AppState, core: Core<AppState>) {
        let urlRequest = Router.WorkOrder.getWorkOrders(userId, orderState, status)
        AF.request(urlRequest).responseData { response in
            guard let jsonData = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let workOrders = try decoder.decode([WorkOrder].self, from: jsonData)
                print(workOrders)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
