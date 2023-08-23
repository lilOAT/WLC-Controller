//
//  WLANListViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit

class WLANListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>

       var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let wlan = WLAN_List.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = wlan.ssid
            cell.contentConfiguration = contentConfiguration
        }
        
        dataSource = DataSource(collectionView: collectionView) {
                    (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
                    return collectionView.dequeueConfiguredReusableCell(
                        using: cellRegistration, for: indexPath, item: itemIdentifier)
                }
        
        // Grab snapshot of data
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        var wlanTitles = [String]()
        for wlan in WLAN_List.sampleData {      //THIS IS WHERE THE DATASOURCE IS POPULATED
            wlanTitles.append(wlan.ssid)
        }
        snapshot.appendItems(wlanTitles)
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
        
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
            var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
            listConfiguration.showsSeparators = true
            listConfiguration.backgroundColor = .systemGray
            return UICollectionViewCompositionalLayout.list(using: listConfiguration)
        }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "wlanhome_vc") as! WLANHomeViewController
        present(vc, animated: true)
        
    }

}
