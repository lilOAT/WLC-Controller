//
//  WLANViewController+Row.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//

import UIKit

extension WLANViewController {
    enum Row: Hashable {
            case wlanId
            case ssid
            case status
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .wlanId: return .headline
            default: return .subheadline
            }
        }
    }
}
