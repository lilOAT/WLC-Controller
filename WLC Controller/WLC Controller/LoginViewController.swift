//
//  ViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 29/5/2023.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "nc") as! UINavigationController
        present(vc, animated: true)
    }

}

