//
//  APListViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit

class APListViewController: UICollectionViewController {
    var dataSource: DataSource!
    var aps: [AP] = AP.sampleData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        // Grab snapshot of data
        updateSnapshot()
        
        collectionView.dataSource = dataSource
        
    }
    
    override func collectionView(
        _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let id = aps[indexPath.item].id
        pushDetailViewForAp(withId: id)
        return false
    }
    
    func pushDetailViewForAp(withId id: AP.ID) {
        let ap = getAp(withId: id)
        let viewController = APViewController(ap: ap)
        //navigationController?.pushViewController(viewController, animated: true)
        present(viewController, animated: true)
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .systemGray
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

