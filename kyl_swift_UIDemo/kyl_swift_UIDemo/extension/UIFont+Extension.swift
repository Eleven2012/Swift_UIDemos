//
//  UIFont+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

/**
 Family Name: Graviola Soft
 Font Name: GraviolaSoft-Bold
 Font Name: GraviolaSoft-Regular
 **/


/// 内置不同类型的字体类型
enum FontType {
    case smaller
    case small
    case middle
    case large
    case title
    case title1
    case title2
}

extension UIFont {
    
    
    /// 便利构造,内置不同类型的FontType
    convenience init?(type: FontType) {
        
        var size: CGFloat = 0.0
        var name = ""
        
        switch type {
        case .smaller:
            name = "GraviolaSoft-Regular"
            switch Device.type() {
            case .iPhone4, .iPhone5: size = 10.0
            case .iPhone6, .iPhone6p, .iPhoneX, .iPhoneXR: size = 12.0
            case .iPad_768_1024, .iPad_834_1112, .iPad_1024_1366: size = 14.0
            }
        case .small:
            name = "GraviolaSoft-Regular"
            switch Device.type() {
            case .iPhone4, .iPhone5: size = 12.0
            case .iPhone6, .iPhone6p, .iPhoneX, .iPhoneXR: size = 14.0
            case .iPad_768_1024, .iPad_834_1112, .iPad_1024_1366: size = 17.0
            }
        case .middle:
            name = "GraviolaSoft-Regular"
            switch Device.type() {
            case .iPhone4, .iPhone5: size = 14.0
            case .iPhone6, .iPhone6p, .iPhoneX, .iPhoneXR: size = 16.0
            case .iPad_768_1024, .iPad_834_1112, .iPad_1024_1366: size = 19.0
            }
        case .large:
            name = "GraviolaSoft-Regular"
            switch Device.type() {
            case .iPhone4, .iPhone5: size = 16.0
            case .iPhone6, .iPhone6p, .iPhoneX, .iPhoneXR: size = 18.0
            case .iPad_768_1024, .iPad_834_1112, .iPad_1024_1366: size = 24.0
            }
        case .title:
            name = "GraviolaSoft-Bold"
            switch Device.type() {
            case .iPhone4, .iPhone5: size = 18.0
            case .iPhone6, .iPhone6p, .iPhoneX, .iPhoneXR: size = 20.0
            case .iPad_768_1024, .iPad_834_1112, .iPad_1024_1366: size = 30.0
            }
        case .title1:
            name = "GraviolaSoft-Bold"
            switch Device.type() {
            case .iPhone4, .iPhone5: size = 12.0
            case .iPhone6, .iPhone6p, .iPhoneX, .iPhoneXR: size = 14.0
            case .iPad_768_1024, .iPad_834_1112, .iPad_1024_1366: size = 22.0
            }
        case .title2:
            name = "GraviolaSoft-Bold"
            switch Device.type() {
            case .iPhone4, .iPhone5: size = 17.0
            case .iPhone6, .iPhone6p, .iPhoneX, .iPhoneXR: size = 18.0
            case .iPad_768_1024, .iPad_834_1112, .iPad_1024_1366: size = 27.0
            }
        }
        self.init(name: name, size: size)
    }
    
    
    /// 便利构造,regular字体
    convenience init?(regularFontSize: CGFloat) {
        self.init(name: "GraviolaSoft-Regular", size: regularFontSize)
    }
    
    
    /// 便利构造,bold字体
    convenience init?(boldFontSize: CGFloat) {
        self.init(name: "GraviolaSoft-Bold", size: boldFontSize)
    }
}
