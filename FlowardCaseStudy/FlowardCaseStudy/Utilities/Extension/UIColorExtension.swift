//
//  UIColorExtension.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 25/08/2021.
//

import UIKit

enum AssetsColor {
   case viewBackgroundColor
   case cellBackgroundColor
}

extension UIColor {

    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .viewBackgroundColor:
            return UIColor(named: "ViewBackground")
        case .cellBackgroundColor:
            return UIColor(named: "CellBackgroundColor")
        }
    }
}
