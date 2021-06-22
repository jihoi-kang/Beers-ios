//
//  Extensions.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/22.
//

import Foundation
import UIKit

extension UIColor {
    
    /// HEX 색상 - 투명도 지원합니다(예, 0a투명도 111111 색상 0a111111)
    static func getColor(_ hex: String, alpha: CGFloat = 1.0, defaultColor: UIColor = .black) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha
            )
        } else if ((cString.count) == 8) {
            var argbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&argbValue)
            
            return UIColor(
                red: CGFloat((argbValue & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((argbValue & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(argbValue & 0x000000FF) / 255.0,
                alpha: CGFloat((argbValue & 0xFF000000) >> 24) / 255.0
            )
        } else {
            return defaultColor
        }
    }
    
}
