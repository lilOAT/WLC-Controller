//
//  WLAN.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//
//  WLAN Object Class

import Foundation


struct WLAN: Identifiable {
    var id: String = UUID().uuidString
    var wlanId: String
    var ssid: String
    var status: String

}
extension [WLAN] {
    func indexOfWLAN(withId id: WLAN.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

#if DEBUG
extension WLAN {
    static var sampleData = [
        WLAN(
            wlanId: "1",
            ssid: "test1",
            status: "Enabled"),
        WLAN(
            wlanId: "2",
            ssid: "test2",
            status: "Enabled")
    ]
}
#endif
