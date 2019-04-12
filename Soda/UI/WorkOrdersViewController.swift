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
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        collectionView.register(StatusSectionCell.nib(), forCellWithReuseIdentifier: StatusSectionCell.reuseIdentifier)
        updateCollectionViewCellSize(for: collectionView.bounds.size)
        core.fire(command: FetchWorkOrders(for: 28, active: true))
    }
    
    
    // MARK: - Actions
    
    @IBAction func displayButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            if self.splitViewController?.preferredPrimaryColumnWidthFraction == 0.75 {
                self.splitViewController?.preferredPrimaryColumnWidthFraction = 1.0
            } else {
                self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.75
            }
        }, completion: nil)
    }
    
}


// MARK: - Private

private extension WorkOrdersViewController {
    
    func updateCollectionViewCellSize(for size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: size.width * 0.25, height: size.height * 0.95)
    }
    
}


// MARK: - Subscriber

extension WorkOrdersViewController: Subscriber {
    
    func update(with state: AppState) {
        
    }
    
}
