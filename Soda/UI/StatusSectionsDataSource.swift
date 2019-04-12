//
//  StatusSectionsDataSource.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import UIKit

class StatusSectionsDataSource: NSObject {

    let sections: [Status.Name] = [.estimate, .toBeOrdered, .design, .casting, .assembly, .receiving, .customerService]
    var workOrders = [WorkOrder]()
    
    func workOrders(for section: Status.Name) -> [WorkOrder] {
        return workOrders.filter { $0.status.name == section }
    }
    
}

extension StatusSectionsDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as StatusSectionCell
        let section = sections[indexPath.section]
        let orders = workOrders(for: sections[indexPath.section])
        cell.config(with: section, workOrders: orders)
        return cell
    }
    
}
