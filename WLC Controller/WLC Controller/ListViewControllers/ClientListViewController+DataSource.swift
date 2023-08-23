//
//  ClientListViewController+DataSource.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//

import UIKit

extension ClientListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CLIENT.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CLIENT.ID>
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(clients.map {$0.id})
        dataSource.apply(snapshot)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: CLIENT.ID) {
        let client = getClient(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = client.mac
        cell.contentConfiguration = contentConfiguration
    }
    
    //Returns corresponding wlan from APs array
    func getClient(withId id: CLIENT.ID) -> CLIENT {
        let index = clients.indexOfCLIENT(withId: id)
        return clients[index]
    }
}
