//
//  testTelnet.swift
//  WLC Controller
//
//  Created by Joel Pita on 3/10/2023.
//

import Foundation

// Define a structure to hold the libtelnet session
struct TelnetSession {
    var session: UnsafeMutablePointer<telnet_t>!
}

// Callback function to handle telnet events
func telnetEventHandler(telnet: telnet_t?, event: telnet_event_t?, userData: UnsafeMutableRawPointer?) {
    guard let session = userData?.assumingMemoryBound(to: TelnetSession.self).pointee else { return }
    
    // Handle the telnet event here
    // You can add code to handle different events such as receiving data, sending data, etc.
}

// Function to create a telnet connection
func createTelnetConnection(host: String, port: UInt16) -> TelnetSession? {
    let session = TelnetSession(session: telnet_init(telnetEventHandler, 0, nil))
    
    // Connect to the remote host
    let result = telnet_connect(session.session, host, port)
    if result != TELNET_EOK {
        print("Failed to connect to \(host):\(port)")
        return nil
    }
    
    // Set telnet options if needed
    // telnet_negotiate_xxx(session.session)
    
    return session
}

//// Example usage
//if let telnetSession = createTelnetConnection(host: "example.com", port: 23) {
//    // Perform telnet operations here
//    
//    // Clean up the telnet session when done
//    telnet_free(telnetSession.session)
//}
