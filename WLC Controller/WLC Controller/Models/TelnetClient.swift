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
    
    func connect(host: String, port: Int) {
        let endpoint = NWEndpoint.hostPort(host: NWEndpoint.Host(host), port: NWEndpoint.Port(rawValue: UInt16(port))!)
        Resources.connection = NWConnection(to: endpoint, using: .tcp)
        
        Resources.connection?.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Connected to \(host):\(port)")
            case .failed(let error):
                print("Connection failed with error: \(error.localizedDescription)")
            default:
                break
            }
        }
        
        Resources.connection?.start(queue: .main)
    }
    
    func sendCommand(command: String) {
        guard let connection = Resources.connection else {
            print("Not connected")
            return
        }
        
        let commandData = command.data(using: .utf8)
        connection.send(content: commandData, completion: .contentProcessed { error in
            if let error = error {
                print("Failed to send command: \(error.localizedDescription)")
            } else {
//                print("Command sent: \(command)")
            }
        })
    }
    
    //Standard telnet data receival
    func login() {
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
                self.login()
            }
        }
    }
    
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
                if receivedString != nil {
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
    
    func disconnect() {
        Resources.connection?.cancel()
        Resources.connection = nil
        print("Disconnected")
    }
}
