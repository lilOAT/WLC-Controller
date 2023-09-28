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
    var mac: String
    var apName: String
    var wlan: String
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
            mac: "12-12-12-12-12",
            apName: "AP01",
            wlan: "test1"),
        CLIENT(
            mac: "34-34-34-34-34-34",
            apName: "AP02",
            wlan: "test2"),
        CLIENT(
            mac: "56-56-56-56-56-56",
            apName: "AP03",
            wlan: "test3"),
        CLIENT(
            mac: "78-78-78-78-78-78",
            apName: "AP04",
            wlan: "test4"),
    ]
}
#endif
