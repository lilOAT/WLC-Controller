//
//  MenuViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton_wlanList() {
        let vc = storyboard?.instantiateViewController(identifier: "wlanlist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
    
    @IBAction func didTapButton_apList() {
        let vc = storyboard?.instantiateViewController(identifier: "aplist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
    
    @IBAction func didTapButton_clientList() {
        let vc = storyboard?.instantiateViewController(identifier: "clientlist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
    
//    @IBAction func didTapButton_terminal() {
//        let vc = storyboard?.instantiateViewController(identifier: "terminal_vc") as! UICollectionViewController
//        present(vc, animated: true)
//    }
}
