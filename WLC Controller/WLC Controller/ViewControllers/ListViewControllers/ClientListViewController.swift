//
//  ClientListViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit

class ClientListViewController: UICollectionViewController {
    var dataSource: DataSource!
    var clients: [CLIENT] = CLIENT.sampleData
    
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
        let id = clients[indexPath.item].id
        pushDetailViewForClient(withId: id)
        return false
    }
    
    func pushDetailViewForClient(withId id: CLIENT.ID) {
        let client = getClient(withId: id)
        let viewController = ClientViewController(client: client)
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

