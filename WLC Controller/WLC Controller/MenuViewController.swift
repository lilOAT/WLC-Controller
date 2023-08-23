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
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "wlanlist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
}
