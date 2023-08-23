//
//  APViewController+Row.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//

import UIKit

extension APViewController {
    enum Row: Hashable {
            case apName
            case apModel
            case mac
            case ipAdress
            case clientCount
        
        var textStyle: UIFont.TextStyle {
            return .body
        }
    }
}
