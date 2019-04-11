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
    
}

extension StatusSectionsDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as StatusSectionCell
        
        return cell
    }
    
}
