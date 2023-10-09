//
//  Resources.swift
//  WLC Controller
//
//  Created by Joel Pita on 8/10/2023.
//

import Foundation
import Network

struct Resources {
    static var telnetClient: TelnetClient!
    static var hostIP: String!
    static var user: String!
    static var pass: String!
    static var connection: NWConnection!
    static var clientsString = ""
    static var clients: [CLIENT] = []
}
