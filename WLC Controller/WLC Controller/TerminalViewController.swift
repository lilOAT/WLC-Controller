//
//  TerminalViewController2.swift
//  WLC Controller
//
//  Created by Joel Pita on 3/10/2023.
//

import UIKit
import Foundation
import Network

class TerminalViewController: UIViewController {
    public var connection: NWConnection?
    public var terminalReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        if !terminalReady {
            Resources.telnetClient.receiveData(vc: self)
        }
        Resources.telnetClient.sendCommand(command: "\n")
        terminalReady = true
    }
    
    @IBOutlet var label: UITextView!
    @IBOutlet var textLabel: UITextField!
    @IBAction func button(_ sender: Any) {
        Resources.telnetClient.sendCommand(command: textLabel.text! + "\n")
        textLabel.text = ""
    }
}
