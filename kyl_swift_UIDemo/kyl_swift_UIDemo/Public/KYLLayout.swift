//
//  KYLLayout.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

// 用于代码适配UI布局
// iPhone传入iPhone 6的@2x尺寸、iPad传iPad 768*1024分辨率下的@2x尺寸
// 是基于设备横屏下的适配,即水平方向指长边，垂直方向指短边

import UIKit

/// 通过iPad适配iPhone的尺寸，按照屏幕宽适配
let AdjustScale = Float(1334.0/2048.0)


let SCREEN_WIDTH = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let SCREEN_HEIGHT = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let SCREEN_BOUNDS = UIScreen.main.bounds


func layoutHorizontal65(iPad iPadScale: Float) -> CGFloat {
    return CGFloat(layoutHorizontal(iPhone6: iPadScale*0.65, iPad: iPadScale))
}

func layoutVertical65(iPad iPadScale: Float) -> CGFloat {
    return CGFloat(layoutVertical(iPhone6: iPadScale*0.65, iPad: iPadScale))
}

/// 设备横屏下,水平方向适配·
///
/// - Parameters:
///   - iPhone6Scale: iPhone6 水平方向@2x尺寸
///   - iPadScale: 分辨率比例为768*1024的iPad 水平方向@2x尺寸
/// - Returns: 适配后的尺寸
func layoutHorizontal(iPhone6 iPhone6Scale: Float, iPad iPadScale: Float) -> Float {
    
    let iphoneWidth = iPhone6Scale / 2
    let iPadWidth = iPadScale / 2
    
    var newWidth: Float = 0
    
    switch Device.type() {
    case .iPhone4:
        newWidth = iphoneWidth * (480.0 / 667.0)
    case .iPhone5:
        newWidth = iphoneWidth * (568.0 / 667.0)
    case .iPhone6:
        newWidth = iphoneWidth
    case .iPhone6p:
        newWidth = iphoneWidth * (736.0 / 667.0)
    case .iPhoneX:
        newWidth = iphoneWidth * ((812.0 - 78) / 667.0)
    case .iPhoneXR:
        newWidth = iphoneWidth * ((896.0 - 78) / 667.0)
    case .iPad_768_1024:
        newWidth = iPadWidth
    case .iPad_834_1112:
        newWidth = iPadWidth * (1112.0 / 1024.0)
    case .iPad_1024_1366:
        newWidth = iPadWidth * (1366.0 / 1024.0)
    }
    
    return newWidth
}


/// 设备横屏下,垂直方向适配
///
/// - Parameters:
///   - iPhone6Scale: iPhone6 垂直方向@2x尺寸
///   - iPadScale: 分辨率比例为768*1024的iPad 垂直方向@2x尺寸
/// - Returns: 适配后的尺寸
func layoutVertical(iPhone6 iPhone6Scale: Float, iPad iPadScale: Float) -> Float {
    
    let iphoneHeight = iPhone6Scale / 2
    let iPadHeight = iPadScale / 2
    
    var newHeight: Float = 0
    
    switch Device.type() {
    case .iPhone4:
        newHeight = iphoneHeight * (320.0 / 375.0)
    case .iPhone5:
        newHeight = iphoneHeight * (320.0 / 375.0)
    case .iPhone6:
        newHeight = iphoneHeight
    case .iPhone6p:
        newHeight = iphoneHeight * (414.0 / 375.0)
    case .iPhoneX:
        newHeight = iphoneHeight * (375.0 / 375.0)
    case .iPhoneXR:
        newHeight = iphoneHeight * (414.0 / 375.0)
    case .iPad_768_1024:
        newHeight = iPadHeight
    case .iPad_834_1112:
        newHeight = iPadHeight * (834.0 / 768.0)
    case .iPad_1024_1366:
        newHeight = iPadHeight * (1024.0 / 768.0)
    }
    
    return newHeight
}


/// 获取设备型号
enum Device {
    
    case iPhone4            /// 4/4s          320*480  @2x
    case iPhone5            /// 5/5C/5S/SE    320*568  @2x
    case iPhone6            /// 6/6S/7/8      375*667  @2x
    case iPhone6p           /// 6P/6SP/7P/8P  414*736  @3x
    case iPhoneX            /// X             375*812   @3x
    //    case iPhoneXS           /// XS            375*812   @3x (同X)
    case iPhoneXR           /// XR            414*896   @2x (放大模式下为 375*812)
    //    case iPhoneXSMAX        /// XSMAX         414*896   @3x (同XR)
    
    
    case iPad_768_1024      /// iPad(5th generation)/iPad Air/iPad Air2/iPad pro(9.7)  768*1024  @2x
    case iPad_834_1112      /// iPad pro(10.5)  834*1112   @2x
    case iPad_1024_1366     /// iPad pro(12.9)  1024*1366  @2x
    
    
    /// 判断具体设备
    ///
    /// - Returns: 具体设备名
    static func type() -> Device {
        
        switch SCREEN_WIDTH {
        case 480.0:
            return .iPhone4
        case 568.0:
            return .iPhone5
        case 667.0:
            return .iPhone6
        case 736.0:
            return .iPhone6p
        case 812.0:
            return .iPhoneX
        case 896.0:
            return .iPhoneXR
        case 1024.0:
            return .iPad_768_1024
        case 1112.0:
            return .iPad_834_1112
        case 1366.0:
            return .iPad_1024_1366
        default:
            return .iPad_768_1024
        }
    }
    
    /// 判断是否为iPad
    ///
    /// - Returns: true 是, false 否
    static func isIPad() -> Bool  {
        //        print("() = \(self.type())")
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
    }
    
    static func isIPhone5() -> Bool {
        return Device.type() == Device.iPhone5 ? true : false
    }
    
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
        }
        return .zero
    }
    
    static var safeScreenWidth: CGFloat {
        return UIScreen.main.bounds.width-safeAreaInsets.left-safeAreaInsets.right
    }
    
    static var safeScreenHeight: CGFloat {
        return UIScreen.main.bounds.height-safeAreaInsets.top-safeAreaInsets.bottom
    }
    
}

let isPad    = (UI_USER_INTERFACE_IDIOM() == .pad)
let IS_iPhoneX = (Device.type() == .iPhoneX || Device.type() == .iPhoneXR)
let IS_iPhone5 = Device.type() == .iPhone5
let IS_iPhone6 = Device.type() == .iPhone6
let IS_iPhoneXR = Device.type() == .iPhoneXR

let StatusBarHeight = IS_iPhoneX ? 44 : 20
let TabbarSafeBottomMargin = IS_iPhoneX ? 34 : 0
let TabbarHeight = TabbarSafeBottomMargin + 49
let StatusBarAndNavigationBarHeight = StatusBarHeight + 44
let NAVIGATION_HEIGHT: CGFloat = Device.isIPad() ? 66 : 44


extension Double {
    // ui设计稿给的是750x1334,iPhone6
    var scaledFontSize: CGFloat {
        var newSize: CGFloat = 0
        
        switch Device.type() {
        case .iPhone4:
            newSize = CGFloat(self)
        case .iPhone5:
            newSize = CGFloat(self)
        case .iPhone6:
            newSize = CGFloat(self)
        case .iPhone6p:
            newSize = CGFloat(self) * 1.5
        case .iPhoneX:
            newSize = CGFloat(self) * 1.6
        case .iPhoneXR:
            newSize = CGFloat(self) * 1.6
        case .iPad_768_1024:
            newSize = CGFloat(self) * 2
        case .iPad_834_1112:
            newSize = CGFloat(self) * 2 * (834.0 / 768.0)
        case .iPad_1024_1366:
            newSize = CGFloat(self) * 2 * (1024.0 / 768.0)
        }
        
        return newSize
    }
}

