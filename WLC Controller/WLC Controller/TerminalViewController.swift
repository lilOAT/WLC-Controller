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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        connect(host: "192.168.50.1", port: 23)
        receiveData()
    }
    
    @IBOutlet var label: UITextView!
    @IBOutlet var textLabel: UITextField!
    @IBAction func button(_ sender: Any) {
        sendCommand(command: textLabel.text! + "\n")
        textLabel.text = ""
    }
}
