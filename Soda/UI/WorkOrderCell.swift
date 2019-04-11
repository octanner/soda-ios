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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    func config(with workOrder: WorkOrder) {
        orderNumberLabel.text = "\(workOrder.workOrderNumber)"
        dueDateLabel.text = workOrder.dueDate.date()?.monthDayYearString()
        dueDateLabel.textColor = workOrder.workOrderType.name.color
        customerNameLabel.text = workOrder.customerName
        locationLabel.text = workOrder.location
    }
    
}
