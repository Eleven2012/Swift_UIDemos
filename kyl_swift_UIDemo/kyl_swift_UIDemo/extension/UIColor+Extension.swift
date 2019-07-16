//
//  UIColor+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    /// RGB颜色
    ///
    /// - Parameters:
    ///   - red: R
    ///   - green: G
    ///   - blue: B
    ///   - alpha: A
    convenience init(red:Int, green:Int, blue:Int, alpha:CGFloat = 1.0) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    
    /// 16进制颜色
    ///
    /// - Parameters:
    ///   - rgb: RGB Int值
    ///   - alpha: 透明度
    convenience init(hex rgb:Int, alpha:CGFloat = 1.0) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha)
    }
    
    
    /// 随机颜色
    ///
    /// - Parameter randomAlpha: 是否随机透明度,默认false
    /// - Returns: 随机颜色
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
        let randomGreen = CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
        let randomBlue = CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
        let alpha = randomAlpha ? CGFloat(Float(arc4random()) / Float(0xFFFFFFFF)) : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    
    
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
