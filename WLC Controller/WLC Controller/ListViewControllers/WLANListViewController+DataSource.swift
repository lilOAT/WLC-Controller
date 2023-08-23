//
//  WLANListViewController+DataSource.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//

import UIKit

extension WLANListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, WLAN.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, WLAN.ID>
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(wlans.map {$0.id})
        dataSource.apply(snapshot)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: WLAN.ID) {
        let wlan = getWlan(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = wlan.ssid
        cell.contentConfiguration = contentConfiguration
    }
    
    //Returns corresponding wlan from wlans array
    func getWlan(withId id: WLAN.ID) -> WLAN {
        let index = wlans.indexOfWLAN(withId: id)
        return wlans[index]
    }
    
    //Updates corresponding wlan. NOT SURE IF NEEDED <<<<<<-------- DELETE
    func updateWlan(_ wlan: WLAN) {
        let index = wlans.indexOfWLAN(withId: wlan.id)
        wlans[index] = wlan
    }
}
