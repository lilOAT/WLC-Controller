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
    
    @IBOutlet var ipAddress: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBAction func didTapButton() {
        Resources.hostIP = ipAddress.text
        Resources.user = username.text
        Resources.pass = password.text
//        let vc2 = TerminalViewController()
//        vc2.hostIP = ipAddress.text
        let vc = storyboard?.instantiateViewController(identifier: "nc") as! UINavigationController
        present(vc, animated: true)
    }

}

