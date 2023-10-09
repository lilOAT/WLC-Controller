//
//  MenuViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit
import Foundation

class MenuViewController: UIViewController {

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
        print(Resources.clientsString)
        if(!Resources.clients.isEmpty){
            Resources.clients = []
        }
        //Parse clientsString into CLIENT objects
        let scanner = Scanner.init(string: Resources.clientsString)
        while scanner.currentIndex != Resources.clientsString.endIndex {
          guard
            let _ = scanner.scanUpToString("("),
            let _ = scanner.scanString("("),
            let ip = scanner.scanUpToString(")"),
            let _ = scanner.scanString(") at "),
            let mac = scanner.scanUpToString("on "),
//            let _ = scanner.scanUpToString("on "),
            let _ = scanner.scanString("on "),
            let interface = scanner.scanUpToString("?")
            else {
              print("error in parsing client list")
              break
          }

            if scanner.currentIndex != Resources.clientsString.endIndex {
                //Remove tail of last CLIENTs interface
            }
            print("IP: " + ip + " MAC: " + mac + " Interface: " + interface)
            Resources.clients.append(CLIENT(ip: ip, mac: mac, interface: interface))
        }

        let vc = storyboard?.instantiateViewController(identifier: "clientlist_vc") as! UICollectionViewController
        present(vc, animated: true)
    }
    
    @IBAction func didTapButton_terminal() {
        guard let vc = storyboard?.instantiateViewController(identifier: "terminal_vc") else { return } //as! UIViewController
        present(vc, animated: true)
    }
}
