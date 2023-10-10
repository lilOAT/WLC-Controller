//
//  TelnetClient.swift
//  TelnetTest
//
//  Created by Joel Pita on 13/9/2023.
//

import Foundation
import Network
import UIKit

class TelnetClient {
    
    //====================================
    //MARK: connect
    func connect(host: String, port: Int, vc: LoginViewController) {
        let endpoint = NWEndpoint.hostPort(host: NWEndpoint.Host(host), port: NWEndpoint.Port(rawValue: UInt16(port))!)
        Resources.connection = NWConnection(to: endpoint, using: .tcp)
        Resources.connection?.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Connected to \(host):\(port)")
                Resources.telnetClient.login(vc: vc)
                Resources.telnetClient.sendCommand(command: Resources.user + "\n")
                Resources.telnetClient.sendCommand(command: Resources.pass + "\n")
            case .failed(let error):
                print("Connection failed with error: \(error.localizedDescription)")
                vc.displayAlert(title: "Error", message: "Failed to connect to: " + Resources.hostIP)
            default:
                break
            }
        }
        Resources.connection?.start(queue: .main)
    }
    
    //====================================
    //MARK: sendCommand
    func sendCommand(command: String) {
        guard let connection = Resources.connection else {
            print("Not connected")
            return
        }
        let commandData = command.data(using: .utf8)
        connection.send(content: commandData, completion: .contentProcessed { error in
            if let error = error {
                print("Failed to send command: \(error.localizedDescription)")
            }
        })
    }
    
    //====================================
    //MARK: login
    //Standard telnet data receival
    func login(vc: LoginViewController) {
        guard let connection = Resources.connection else {
            print("Not connected")
            return
        }
        var receivedString: String!
        //Maximum TCP packet length = 65535
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, context, isComplete, error) in
            if let data1 = data, !data1.isEmpty {
                receivedString = String(data: data1, encoding: .utf8)
                if receivedString != nil {
                    Resources.loginString += receivedString
                }
            }
            if let error = error {
                print("Failed to receive data: \(error.localizedDescription)")
            } else if isComplete {
                print("Connection closed by remote host")
                self.disconnect()
            } else {
                //Only iterate if login is incomplete
                if !Resources.loginString.contains("@") { //@ = login success
                    self.login(vc: vc)
                } else {
                    vc.connected = true //This triggers didSet connected to trigger launch()
                    print("escaped login")
                }
            }
        }
    }
    
    //====================================
    //MARK: receiveClientList
    func receiveClientList(vc: MenuViewController) {
        guard let connection = Resources.connection else {
            print("Not connected")
            return
        }
        var receivedString: String!
        //Maximum TCP packet length = 65535
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, context, isComplete, error) in
            if let data = data, !data.isEmpty {
                receivedString = String(data: data, encoding: .utf8)
                if receivedString != nil {
                    Resources.clientsString += receivedString
                }
            }
            if let error = error {
                print("Failed to receive data: \(error.localizedDescription)")
            } else if isComplete {
                print("Connection closed by remote host")
                self.disconnect()
            } else {
                //Only iterate if login is incomplete
                if !Resources.clientsString.contains("@") {
                    self.receiveClientList(vc: vc)
                } else {
                    vc.clientsGathered = true //This triggers didSet clientsGathered to trigger launchClientList()
                }
            }
        }
    }
    
    //====================================
    //MARK: receiveData
    func receiveData(vc: TerminalViewController) {
        guard let connection = Resources.connection else {
            print("Not connected")
            return
        }
        var receivedString: String!
        //Maximum TCP packet length = 65535
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, context, isComplete, error) in
            if let data = data, !data.isEmpty {
                receivedString = String(data: data, encoding: .utf8)
                if receivedString != nil && vc.terminalReady {
                    print("receivedString: " + receivedString + " ?end")
                    // Append reply to textview
                    vc.label.text! += receivedString
                    //Scroll the textview down to always show last line
                    //--https://developer.apple.com/forums/thread/126549
                    let range = NSMakeRange(vc.label.text.count - 1, 0)
                    vc.label.scrollRangeToVisible(range)
                }
                receivedString = ""
            }
            if let error = error {
                print("Failed to receive data: \(error.localizedDescription)")
            } else if isComplete {
                print("Connection closed by remote host")
                self.disconnect()
            } else {
                self.receiveData(vc: vc)
            }
        }
    }
    
    //====================================
    //MARK: disconnect
    func disconnect() {
        Resources.connection?.cancel()
        Resources.connection = nil
        print("Disconnected")
    }
}
