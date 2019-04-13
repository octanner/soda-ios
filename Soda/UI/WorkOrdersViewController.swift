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
    
    var core = App.sharedCore
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        collectionView.register(StatusSectionCell.nib(), forCellWithReuseIdentifier: StatusSectionCell.reuseIdentifier)
        core.fire(command: FetchWorkOrders(for: 28, orderState: .active, status: nil, completion: { workOrders in
            DispatchQueue.main.async {
                self.dataSource.workOrders = workOrders
                self.collectionView.reloadData()
            }
        }))
        title = "Work Orders"
        navigationItem.leftBarButtonItem?.customView = activityIndicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
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
        if self.splitViewController?.preferredPrimaryColumnWidthFraction == 0.75 {
            hideDetail()
        } else {
            showDetail()
        }
    }
    
    func showDetail() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.75
        }, completion: nil)
    }
    
    func hideDetail() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.splitViewController?.preferredPrimaryColumnWidthFraction = 1.0
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
        if state.workOrderState.workOrdersLoaded {
            activityIndicator.stopAnimating()
        }
        if state.workOrderState.shouldShowDetail {
            showDetail()
        } else {
            hideDetail()
        }
    }
    
}
