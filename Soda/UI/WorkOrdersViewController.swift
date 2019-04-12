//
//  WorkOrdersTableViewController.swift
//  Soda
//
//  Created by Scott Sorensen on 3/5/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import UIKit

class WorkOrdersViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var dataSource: StatusSectionsDataSource!
    @IBOutlet weak var displayButton: UIBarButtonItem!
    
    var core = App.sharedCore
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        collectionView.register(StatusSectionCell.nib(), forCellWithReuseIdentifier: StatusSectionCell.reuseIdentifier)
        core.fire(command: FetchWorkOrders(for: 28, orderState: .active))
        title = "Work Orders"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        core.add(subscriber: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        core.remove(subscriber: self)
    }
    
    
    // MARK: - Actions
    
    @IBAction func displayButtonTapped(_ sender: Any) {
        animateDetail()
    }
    
}


// MARK: - Private

private extension WorkOrdersViewController {
    
    func animateDetail() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            if self.splitViewController?.preferredPrimaryColumnWidthFraction == 0.75 {
                self.splitViewController?.preferredPrimaryColumnWidthFraction = 1.0
            } else {
                self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.75
            }
        }, completion: nil)
    }
    
}


// MARK: - FlowLayout Delegate

extension WorkOrdersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.height)
    }
    
    
}



// MARK: - Subscriber

extension WorkOrdersViewController: Subscriber {
    
    func update(with state: AppState) {
        dataSource.workOrders = state.workOrderState.workOrders
        collectionView.reloadData()
        displayButton.isEnabled = state.workOrderState.selectedWorkOrder != nil
        if state.workOrderState.shouldShowDetail {
            animateDetail()
        }
    }
    
}
