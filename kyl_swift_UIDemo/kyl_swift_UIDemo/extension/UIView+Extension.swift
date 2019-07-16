//
//  UIView+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

extension UIView{
    public var left: CGFloat{
        get{
            return frame.minX
        }
        set{
            centerX = left + width / 2
        }
    }
    public var right: CGFloat{
        get{
            return frame.maxX
        }
        set{
            centerX = right - width / 2
        }
    }
    public var top: CGFloat{
        get{
            return frame.minY
        }
        set{
            centerY = top + height / 2
        }
    }
    public var bottom: CGFloat{
        get{
            return frame.maxY
        }
        set{
            centerY = bottom - height / 2
        }
    }
    public var width: CGFloat{
        get{
            return bounds.width
        }
        set{
            size = CGSize(width: newValue, height: height)
        }
    }
    public var height: CGFloat{
        get{
            return bounds.height
        }
        set{
            size = CGSize(width: width, height: newValue)
        }
    }
    public var size: CGSize{
        get{
            return bounds.size
        }
        set{
            frame = CGRect(x: left, y: top, width: newValue.width, height: newValue.height)
        }
    }
    public var origin: CGPoint{
        get{
            return frame.origin
        }
        set{
            center = CGPoint(x: newValue.x + width / 2, y: newValue.y + height / 2)
        }
    }
    public var centerX: CGFloat{
        get{
            return center.x
        }
        set{
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    public var centerY: CGFloat{
        get{
            return center.y
        }
        set{
            center = CGPoint(x: center.x, y: newValue)
        }
    }
}

extension UIView{
    public func resizeToSuperview(){
        NSLayoutConstraint.addConstraints("|[self]|", views: ["self": self])
        NSLayoutConstraint.addConstraints("V:|[self]|", views: ["self": self])
    }
}

extension UINib{
    public static func view(_ name: String, owner: AnyObject? = nil)-> UIView?{
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: owner).first as? UIView
    }
}

extension NSLayoutConstraint{
    public static func addConstraints(_ format: String, views: [String : UIView], options: NSLayoutConstraint.FormatOptions = [], metrics: [String : Int]? = nil){
        let c = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: views)
        NSLayoutConstraint.activate(c)
    }
}


extension UIView {
    public func clip(corners: UIRectCorner, radius: CGSize) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radius)
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = maskPath.cgPath
        self.layer.mask = layer
    }
}
