//
//  StatusSectionCell.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import UIKit

class StatusSectionCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var workOrders = [WorkOrder]()
    
    func config(with statusName: Status.Name, workOrders: [WorkOrder]) {
        self.workOrders = workOrders
        statusLabel.text = "\(statusName.rawValue) (\(workOrders.count))"
        collectionView.reloadData()
    }
    
}

extension StatusSectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as WorkOrderCell
        let workOrder = workOrders[indexPath.row]
        cell.config(with: workOrder)
        return cell
    }
    
    
    
}
