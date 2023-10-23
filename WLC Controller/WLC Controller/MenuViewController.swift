//
//  MenuViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit
import Foundation

class MenuViewController: UIViewController {
    public var clientsGathered: Bool = false {
        didSet {
            launchClientList()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton_wlanList() {
        let vc = storyboard?.instantiateViewController(identifier: "wlanlist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
    
    @IBAction func didTapButton_apList() {
        let vc = storyboard?.instantiateViewController(identifier: "aplist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
    
    @IBAction func didTapButton_clientList() {
        Resources.telnetClient.receiveClientList(vc: self)
        Resources.telnetClient.sendCommand(command: "arp -a\n")
        //receiveClient() will trigger didSet clientsGathered, which triggers launchClientList()
    }
    
    @IBAction func didTapButton_terminal() {
        guard let vc = storyboard?.instantiateViewController(identifier: "terminal_vc") else { return } //as! UIViewController
        present(vc, animated: true)
    }
    
    //====================================
    //MARK: parseClientList
    // https://swiftpackageindex.com/pointfreeco/swift-parsing
    func parseClientList() {
        print("clientsString:\n" + Resources.clientsString)
        if(!Resources.clients.isEmpty){
            Resources.clients = []
        }
        //Parse clientsString into CLIENT objects
        // INSERT URL
        let scanner = Scanner.init(string: Resources.clientsString)
        while scanner.currentIndex != Resources.clientsString.endIndex {
          guard
            let _ = scanner.scanUpToString("("),
            let _ = scanner.scanString("("),
            let ip = scanner.scanUpToString(")"),
            let _ = scanner.scanString(") at "),
            let mac = scanner.scanUpToString("on "),
            let _ = scanner.scanString("on "),
            let interface = scanner.scanUpToString("\r\n")
            else {
              print("error in parsing client list")
              break
          }
            if !mac.contains("<incomplete>") {
                Resources.clients.append(CLIENT(ip: ip, mac: mac, interface: interface))
            }
            else {print("Invalid arp entry at ip: " + ip)}
        }
    }
    
    //====================================
    //MARK: launchClientList
    func launchClientList() {
        parseClientList()
        Resources.clientsString = ""
        let vc = storyboard?.instantiateViewController(identifier: "clientlist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
}
