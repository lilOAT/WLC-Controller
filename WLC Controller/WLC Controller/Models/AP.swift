//
//  AP.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//
//  Access Point Object Class

import Foundation


struct AP: Identifiable {
    var id: String = UUID().uuidString
    var apName: String
    var apModel: String
    var mac: String
    var ipAdress: String
    var clientCount: String

}
extension [AP] {
    func indexOfAP(withId id: AP.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

#if DEBUG
extension AP {
    static var sampleData = [
        AP(
            apName: "AP01",
            apModel: "AIR-LAP1252AG-N-K9",
            mac: "AB-CD-EF-GH-IJ-KL",
            ipAdress: "10.1.1.1",
            clientCount: "2"),
        AP(
            apName: "AP02",
            apModel: "AIR-LAP1252AG-N-K9",
            mac: "12-34-56-78-90-12",
            ipAdress: "192.168.0.1",
            clientCount: "7"),
        AP(
            apName: "AP03",
            apModel: "AIR-LAP1252AG-N-K8",
            mac: "AB-CD-EF-GH-IJ-K8",
            ipAdress: "10.1.1.8",
            clientCount: "8"),
    ]
}
#endif
