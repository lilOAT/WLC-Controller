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
//    public var hostIP: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        print("From Terminal: host = " + Resources.hostIP)
        connect(host: Resources.hostIP, port: 23)
        sendCommand(command: Resources.user + "\n")
        sendCommand(command: Resources.pass + "\n")
        receiveData()
    }
    
    @IBOutlet var label: UITextView!
    @IBOutlet var textLabel: UITextField!
    @IBAction func button(_ sender: Any) {
        sendCommand(command: textLabel.text! + "\n")
        textLabel.text = ""
    }
}
