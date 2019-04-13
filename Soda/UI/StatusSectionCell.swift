//
//  StatusSectionCell.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import UIKit
import MobileCoreServices

class StatusSectionCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var core = App.sharedCore
    
    var workOrders = [WorkOrder]() {
        didSet {
            collectionView.backgroundColor = workOrders.isEmpty ? .grayTwo : .clear
            if let statusName = statusName {
                statusLabel.text = "\(statusName.rawValue) (\(workOrders.count))"
            }
            status = workOrders.first?.status
        }
    }
    var statusName: Status.Name? {
        didSet {
            statusLabel.text = "\(statusName?.rawValue ?? "") (\(workOrders.count))"
        }
    }
    
    var status: Status?
    
    
    // MARK: - Cell config
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WorkOrderCell.nib(), forCellWithReuseIdentifier: WorkOrderCell.reuseIdentifier)
        collectionView.layer.cornerRadius = 4
        collectionView.clipsToBounds = true
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
    
    func config(with statusName: Status.Name, workOrders: [WorkOrder]) {
        self.workOrders = workOrders
        self.statusName = statusName
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


// MARK: - CollectionView Delegate

extension StatusSectionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let workOrder = workOrders[indexPath.row]
        guard let cell = collectionView.cellForItem(at: indexPath) as? WorkOrderCell else { return }
        if cell.tapped {
            core.fire(event: Reset<WorkOrder>())
        } else {
            core.fire(event: Selected(item: workOrder))
        }
    }
    
}


// MARK: - FlowLayout Delegate

extension StatusSectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 98)
    }
    
    
}


extension StatusSectionCell: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let workOrder = workOrders[indexPath.row]
        let itemProvider = NSItemProvider(object: WorkOrderClass(workOrder: workOrder))
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (self)
        return [dragItem]
    }
    
    
}

extension StatusSectionCell: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        for item in coordinator.items {
            item.dragItem.itemProvider.loadObject(ofClass: WorkOrderClass.self) { (workOrderClass, error) in
                if let workOrderClass = workOrderClass as? WorkOrderClass {
                    var workOrder = WorkOrder(workOrder: workOrderClass)
                    DispatchQueue.main.async {
                        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
                        guard let sourceCell = coordinator.session.localDragSession?.localContext as? StatusSectionCell else { return }
                        self.collectionView.performBatchUpdates({
                            self.workOrders.insert(workOrder, at: destinationIndexPath.row)
                            self.collectionView.insertItems(at: [destinationIndexPath])
                            if let index = sourceCell.workOrders.firstIndex(of: workOrder) {
                                sourceCell.workOrders.remove(at: index)
                                let indexPath = IndexPath(row: index, section: 0)
                                sourceCell.collectionView.deleteItems(at: [indexPath])
                            }
                            if let status = self.status {
                                workOrder.status = status
                                self.core.fire(event: Updated(item: workOrder))
                            }
                        }, completion: { _ in })
                        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                    }
                }
            }
        }
    }

}
