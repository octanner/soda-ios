//
//  FetchActiveWorkOrders.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation
import Alamofire

struct FetchWorkOrders: Command {
    
    let userId: Int
    let active: Bool
    
    init(for userId: Int, active: Bool) {
        self.userId = userId
        self.active = active
    }
    
    func execute(state: AppState, core: Core<AppState>) {
        let urlRequest = Router.WorkOrder.getWorkOrders(active, userId)
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
