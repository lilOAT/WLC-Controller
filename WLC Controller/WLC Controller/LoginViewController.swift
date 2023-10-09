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
        if(ipAddress.text != "" && username.text != "" && password.text != "") {
            Resources.hostIP = ipAddress.text
            Resources.user = username.text
            Resources.pass = password.text
            Resources.telnetClient = TelnetClient()
            let telnetClient = Resources.telnetClient
            telnetClient?.connect(host: Resources.hostIP, port: 23)
            telnetClient?.login()
            sleep(1)
            telnetClient?.sendCommand(command: Resources.user + "\n")
            telnetClient?.sendCommand(command: Resources.pass + "\n")
            telnetClient?.sendCommand(command: "arp -a\n")
            let vc = storyboard?.instantiateViewController(identifier: "nc") as! UINavigationController
            present(vc, animated: true)
        }
    }
}

