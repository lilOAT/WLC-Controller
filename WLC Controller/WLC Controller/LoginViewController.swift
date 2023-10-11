//
//  ViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 29/5/2023.
//

import UIKit

class LoginViewController: UIViewController {
    // connected is changed to true when TCP connection made to router.
    // This triggers the MenuViewController to launch
    public var connected: Bool = false {
        didSet {
            launch()
        }
    }
    
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
            Resources.telnetClient.connect(host: Resources.hostIP, port: 23, vc: self)
        }
    }
    
    //====================================
    // MARK: validateCredentials
    func validateCredentials(ip: String, user: String, pass: String) -> Bool {
        var valid = true
        if ip != "" && user != "" && pass != "" {
            if !user.contains("@") && !pass.contains("@") { // @ is used to verify login with this specific router
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
                    return false }
                if 0...255 ~= octet1 && 0...255 ~= octet2 && 0...255 ~= octet3 && 0...255 ~= octet4 {} else {
                    displayAlert(title: "Invalid", message: "Bad IP address")
                    valid = false }
            } else {
                displayAlert(title: "Invalid Credentials", message: "Must not contain special character @")
                valid = false }
        } else {
            displayAlert(title: "Invalid", message: "All fields must be filled")
            valid = false }

        return valid
    }
    
    //====================================
    //MARK: isAuthorized
    // currently not used. Function is handled in telnetClient.login()
    func isAuthorized() -> Bool {
        let auth = true
        //Parse loginString to check if valid
        return auth
    }
    
    //====================================
    //MARK: displayAlert
    func displayAlert(title: String, message: String) {
        // Declare alert message
        // https://developer.apple.com/documentation/uikit/uialertcontroller
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //====================================
    //MARK: launch
    func launch() {
//        print("loginString:\n" + Resources.loginString)
        if isAuthorized() {
            let vc = storyboard?.instantiateViewController(identifier: "nc") as! UINavigationController
            present(vc, animated: true)
        } else {displayAlert(title: "No Authorization", message: "Credentials failed")}
    }
}

