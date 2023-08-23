//
//  WLANListViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit

class WLANListViewController: UICollectionViewController {
    var dataSource: DataSource!
    var wlans: [WLAN] = WLAN.sampleData
    
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
        let id = wlans[indexPath.item].id
        pushDetailViewForWlan(withId: id)
        return false
    }
    
    func pushDetailViewForWlan(withId id: WLAN.ID) {
        let wlan = getWlan(withId: id)
        let viewController = WLANViewController(wlan: wlan)
        //navigationController?.pushViewController(viewController, animated: true)
        present(viewController, animated: true)
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
            var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
            listConfiguration.showsSeparators = true
            listConfiguration.backgroundColor = .systemGray
            return UICollectionViewCompositionalLayout.list(using: listConfiguration)
        }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "wlanhome_vc") as! WLANViewController
        present(vc, animated: true)
        
    }

}
