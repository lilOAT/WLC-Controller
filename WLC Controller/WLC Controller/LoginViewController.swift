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
        if validateCredentials(ip: ipAddress.text!, user: username.text!, pass: password.text!)  {
            Resources.hostIP = ipAddress.text
            Resources.user = username.text
            Resources.pass = password.text
            Resources.telnetClient = TelnetClient()
            let telnetClient = Resources.telnetClient
            telnetClient?.connect(host: Resources.hostIP, port: 23)
            telnetClient?.login()
            sleep(1) //Essential to allow receiver to ready itself before commands
            telnetClient?.sendCommand(command: Resources.user + "\n")
            telnetClient?.sendCommand(command: Resources.pass + "\n")
            telnetClient?.sendCommand(command: "arp -a\n")
            let vc = storyboard?.instantiateViewController(identifier: "nc") as! UINavigationController
            present(vc, animated: true)
        }
    }
    
    func validateCredentials(ip: String, user: String, pass: String) -> Bool {
        var pass = true
        if ipAddress.text != "" && username.text != "" && password.text != "" {
            let scanner = Scanner.init(string: ip)
            guard
                let octet1 = scanner.scanInt(),
                let _ = scanner.scanString("."),
                let octet2 = scanner.scanInt(),
                let _ = scanner.scanString("."),
                let octet3 = scanner.scanInt(),
                let _ = scanner.scanString("."),
                let octet4 = scanner.scanInt()
            else {
                displayAlert(title: "Invalid", message: "Bad IP address")
                return false
            }

            if 0...255 ~= octet1 && 0...255 ~= octet2 && 0...255 ~= octet3 && 0...255 ~= octet4 {} else {
                displayAlert(title: "Invalid", message: "Bad IP address")
                pass = false
            }

        } else {
            displayAlert(title: "Invalid", message: "All fields must be filled")
            pass = false
        }
                
        return pass
    }
    
    func displayAlert(title: String, message: String) {
        // Declare alert message
        // https://developer.apple.com/documentation/uikit/uialertcontroller
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

