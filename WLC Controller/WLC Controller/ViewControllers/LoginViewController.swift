//
//  ViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 29/5/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var hostAddress: UITextField!
    @IBOutlet var user: UITextField!
    @IBOutlet var password: UITextField!
    
    let client = TelnetClient()
    let hostEntry = HostEntry()
//    let delegate = Telnet
//    var presenter: TelnetPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapButton() {
        if hostAddress.text != "" && user.text != "" && password.text != "" {
//            hostEntry.host = hostAddress.text
//            hostEntry.username = user.text
//            hostEntry.password = password.text
//            hostEntry.port = "23"
            
//            let gateway = TelnetGatewayImplementation()
//            gateway.connect(toHost: hostAddress.text!)
//            gateway.write(command: "admin")
//            gateway.didReceiveMessage("hello")
            
//            gateway.write(command: "password")
//            client.delegate = gateway
            client.setup(hostEntry)
            client.writeMessage("admin")
            
            
            let vc = storyboard?.instantiateViewController(identifier: "nc") as! UINavigationController
            present(vc, animated: true)
        }
    }
    
    
}
