//
//  TelnetClient.swift
//  TelnetTest
//
//  Created by Joel Pita on 13/9/2023.
//

import Foundation
import Network

extension ViewController {
    
    
    func connect(host: String, port: Int) {
        let endpoint = NWEndpoint.hostPort(host: NWEndpoint.Host(host), port: NWEndpoint.Port(rawValue: UInt16(port))!)
        connection = NWConnection(to: endpoint, using: .tcp)
        
        connection?.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Connected to \(host):\(port)")
            case .failed(let error):
                print("Connection failed with error: \(error.localizedDescription)")
            default:
                break
            }
        }
        
        connection?.start(queue: .main)
    }
    
    func sendCommand(command: String) {
        guard let connection = connection else {
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
    
    func receiveData() {
        guard let connection = connection else {
            print("Not connected")
            return
        }
        
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, context, isComplete, error) in
            if let data = data, !data.isEmpty {
                if let receivedString = String(data: data, encoding: .utf8) {
                    self.label.text! += receivedString
                    
                    //Scroll the textview down to always show last line
                    //--https://developer.apple.com/forums/thread/126549
                    let range = NSMakeRange(self.label.text.count - 1, 0)
                    self.label.scrollRangeToVisible(range)
                }
            }
            
            if let error = error {
                print("Failed to receive data: \(error.localizedDescription)")
            } else if isComplete {
                print("Connection closed by remote host")
                self.disconnect()
            } else {
                self.receiveData()
            }
        }
    }
    
    func disconnect() {
        connection?.cancel()
        connection = nil
        print("Disconnected")
    }
}
