//
//  CLIENT.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//
//  CLient Object Class

import Foundation


struct CLIENT: Identifiable {
    var id: String = UUID().uuidString
    var ip: String
    var mac: String
    var interface: String
}
extension [CLIENT] {
    func indexOfCLIENT(withId id: CLIENT.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

#if DEBUG
extension CLIENT {
    static var sampleData = [
        CLIENT(
            ip: "192.168.1.2",
            mac: "12-12-12-12-12-12",
            interface: "test1"),
        CLIENT(
            ip: "192.168.1.3",
            mac: "34-34-34-34-34-34",
            interface: "test2"),
        CLIENT(
            ip: "192.168.1.4",
            mac: "56-56-56-56-56-56",
            interface: "test3"),
        CLIENT(
            ip: "192.168.1.5",
            mac: "78-78-78-78-78-78",
            interface: "test4"),
    ]
}
#endif
