import Foundation


struct WLAN_List {
    var wlanID: String
    var ssid: String

}


#if DEBUG
extension WLAN_List {
    static var sampleData = [
        WLAN_List(
            wlanID: "1",
            ssid: "test1"),
        WLAN_List(
            wlanID: "2",
            ssid: "test2")
    ]
}
#endif
