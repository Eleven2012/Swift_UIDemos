//
//  UIButton+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

extension UIButton{
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if self.shadowColor == nil, let currentShadowColor = self.layer.shadowColor {
            self.shadowColor = UIColor(cgColor: currentShadowColor)
        }
        self.layer.shadowColor = UIColor.clear.cgColor
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let storageColor = self.shadowColor {
            self.layer.shadowColor = storageColor.cgColor
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if let storageColor = self.shadowColor {
            self.layer.shadowColor = storageColor.cgColor
        }
    }
    
    fileprivate struct AssociatedKeys {
        static var shadowColor = UIColor.clear
    }
    
    public var shadowColor: UIColor? {
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.shadowColor) as? UIColor else {
                return nil
            }
            return color
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shadowColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
