//
//  WorkOrderCell.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import UIKit

class WorkOrderCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    var core = App.sharedCore
    var workOrder: WorkOrder?
    
    var tapped: Bool = false {
        didSet {
           overlayView.alpha = tapped ? 0.2 : 0.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        core.add(subscriber: self)
        layer.cornerRadius = 4
        clipsToBounds = true
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func config(with workOrder: WorkOrder) {
        self.workOrder = workOrder
        orderNumberLabel.text = "\(workOrder.workOrderNumber)"
        dueDateLabel.text = workOrder.dueDate.monthDayYearString()
        coloredView.backgroundColor = workOrder.workOrderType.name.color
        customerNameLabel.text = workOrder.customerName
        locationLabel.text = workOrder.location
        dueDateLabel.textColor = workOrder.dueDate.daysUntilColor()
    }
    
}


// MARK: - Subscriber

extension WorkOrderCell: Subscriber {
    
    func update(with state: AppState) {
        tapped = workOrder == state.workOrderState.selectedWorkOrder
    }
    
}
