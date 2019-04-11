//
//  WorkOrdersTableViewController.swift
//  Soda
//
//  Created by Scott Sorensen on 3/5/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import UIKit

class WorkOrdersViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var dataSource: StatusSectionsDataSource!
    
    override func viewDidLoad() {
        updateCollectionViewCellSize(for: collectionView.bounds.size)
    }
    
    func updateCollectionViewCellSize(for size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: size.width * 0.25, height: size.height)
    }
    
}


extension WorkOrdersViewController: Subscriber {
    
    func update(with state: AppState) {
        
    }
    
}
