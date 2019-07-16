//
//  CAShapeLayer+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    
    /// 切圆角
    ///
    /// - Parameters:
    ///   - rect: 需要切圆角的控件bounds
    ///   - corners: 需要切的上、下、左、右圆角
    ///   - cornerRadii: 圆角范围
    /// - Returns: 圆角
    class func circleShaperLayer(withRoundedRect rect: CGRect, byRoundingCorners corners: UIRectCorner, cornerRadii: CGSize) -> CAShapeLayer {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
    
}
