//
//  UIColor.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/7.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

private enum VOTColor: String {

    // swiftlint:disable identifier_name
    case MainGreen

    case CreamyWhite

    case DarkGary

    case Orange

    case DarkGreen
}

extension UIColor {

    static let G1 = VOTColor(.MainGreen)

    static let W1 = VOTColor(.CreamyWhite)

    static let DG = VOTColor(.DarkGary)

    static let O1 = VOTColor(.Orange)

    static let G2 = VOTColor(.DarkGreen)
    
    // swiftlint:enable identifier_name
    
    private static func VOTColor(_ color: VOTColor) -> UIColor? {

        return UIColor(named: color.rawValue)
    }
}
