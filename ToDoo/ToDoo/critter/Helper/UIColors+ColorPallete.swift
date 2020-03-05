//
//  UIColors+ColorPallete.swift
//  LoginCritter
//
//  Created by Christopher Goldsby on 3/30/18.
//  Copyright © 2018 Christopher Goldsby. All rights reserved.
//

import UIKit

// MARK: - Color Pallete

extension UIColor {
    static let light = #colorLiteral(red: 0.768627451, green: 1, blue: 0.9764705882, alpha: 1)
    static let dark = #colorLiteral(red: 0.3450980392, green: 0.7882352941, blue: 0.7254901961, alpha: 1)
    static let text = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    static let disabledText = UIColor.text.withAlphaComponent(0.8)
}
