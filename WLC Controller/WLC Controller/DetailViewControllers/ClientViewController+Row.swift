//
//  ClientViewController+Row.swift
//  WLC Controller
//
//  Created by Joel Pita on 23/8/2023.
//

import UIKit

extension ClientViewController {
    enum Row: Hashable {
            case ip
            case mac
            case interface
        
        var textStyle: UIFont.TextStyle {
            return .body
        }
    }
}
