//
//  APListViewController+DataSource.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//

import UIKit

extension APListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, AP.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, AP.ID>
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(aps.map {$0.id})
        dataSource.apply(snapshot)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: AP.ID) {
        let ap = getAp(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = ap.apName
        cell.contentConfiguration = contentConfiguration
    }
    
    //Returns corresponding wlan from APs array
    func getAp(withId id: AP.ID) -> AP {
        let index = aps.indexOfAP(withId: id)
        return aps[index]
    }
}
