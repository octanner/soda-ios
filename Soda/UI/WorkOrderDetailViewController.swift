//
//  WorkOrderDetailViewController.swift
//  Soda
//
//  Created by Scott Sorensen on 3/5/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import UIKit

class WorkOrderDetailViewController: UIViewController {

    var core = App.sharedCore
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        core.add(subscriber: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        core.remove(subscriber: self)
    }
}


// MARK: - Subscriber

extension WorkOrderDetailViewController: Subscriber {
    
    func update(with state: AppState) {
        if let workOrderNumber = state.workOrderState.selectedWorkOrder?.workOrderNumber {
            title = "\(workOrderNumber)"
        }
    }
    
}
