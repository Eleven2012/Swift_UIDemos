//
//  UIImage+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import ObjectiveC

enum UIImageGradientType {
    /// 从上到小
    case TopToBottom
    /// 从左到右
    case LeftToRight
    /// 左上到右下
    case UpleftToLowright
    
    /// 右上到左下
    case UprightToLowleft
}

//var IDENTIFIER: String

extension UIImage {
    
    /// 创建渐变色图片
    ///
    /// - Parameters:
    ///   - colors: 渐变颜色数组
    ///   - gradientType: 渐变类型
    ///   - imgSize: 图片大小
    /// - Returns: 渐变颜色图片
    static func gradientColorImage(fromColors colors: [UIColor], gradientType: UIImageGradientType, imgSize: CGSize) -> UIImage {
        var ar = [AnyHashable]()
        for c: UIColor in colors {
            ar.append(c.cgColor)
        }
        UIGraphicsBeginImageContextWithOptions(imgSize, true, 1)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let colorSpace = colors.last?.cgColor.colorSpace
        let gradient = CGGradient(colorsSpace: colorSpace, colors: ar as CFArray, locations: nil)
        let start: CGPoint
        let end: CGPoint
        switch gradientType {
        case .TopToBottom:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: 0.0, y: imgSize.height)
        case .LeftToRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: imgSize.width, y: 0.0)
        case .UpleftToLowright:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: imgSize.width, y: imgSize.height)
        case .UprightToLowleft:
            start = CGPoint(x: imgSize.width, y: 0.0)
            end = CGPoint(x: 0.0, y: imgSize.height)
        }
        context?.drawLinearGradient(gradient!, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    
    /// 创建带透明度的图片
    ///
    /// - Parameters:
    ///   - alpha: 透明度
    ///   - image: 原图片
    /// - Returns: 带透明的图片
    static func alphaImage(alpha: CGFloat, image: UIImage?) -> UIImage? {
        guard let image = image else { return UIImage() }
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        guard let ctx = context else { return UIImage() }
        let area = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        ctx.scaleBy(x: 1, y: -1)
        ctx.translateBy(x: 0, y: -area.size.height)
        ctx.setBlendMode(.multiply)
        ctx.setAlpha(alpha)
        ctx.draw(image.cgImage!, in: area)
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    
    /// 通过纯色创建图片
    ///
    /// - Parameter color: 颜色
    /// - Returns: 通过纯颜色创建的图片
    static func createImage(with color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let ctx = UIGraphicsGetCurrentContext()
        guard let context = ctx else { return UIImage() }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let theImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage ?? UIImage()
    }
    
    
    /// 从中间拉伸图片
    ///
    /// - Parameter image: 拉伸之前原始图
    /// - Returns: 拉伸后图片
    static func stretchFromCenter(image: UIImage?) -> UIImage? {
        guard let oriImage = image else {
            return nil
        }
        let result = oriImage.resizableImage(withCapInsets: UIEdgeInsets(top: oriImage.size.height/2, left: oriImage.size.width/2, bottom: oriImage.size.height/2, right: oriImage.size.width/2), resizingMode: .stretch)
        return result
    }
    
    static func imageCompressFitSizeScale(sourceImage: UIImage, size: CGSize) -> UIImage? {
        var newImage: UIImage? = nil
        let imageSize = sourceImage.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth = size.width
        let targetHeight = size.height
        var scaleFactor = CGFloat(0.0)
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint.zero
        
        if !imageSize.equalTo(size) {
            
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            
            if widthFactor > heightFactor {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor
            }
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            } else if widthFactor < heightFactor {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        UIGraphicsBeginImageContext(size)
        
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = .zero
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        sourceImage.draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    /// 从svg文件解析出图片
    ///
    /// - Parameter imageName: svg图片名称
    /// - Parameter size: 图片大小
    /// - Returns: 解析出来的UIImage图片
//    static func svgImage(imageName: String?,size:CGSize) -> UIImage? {
//        
//        guard let svgImage = SVGKImage.init(named: imageName) else {
//            return nil
//        }
//        svgImage.size = size
//        
//        return svgImage.uiImage
//    }
    
    
    struct RuntimeKey {
        static let jkKey = UnsafeRawPointer.init(bitPattern: "JKKey".hashValue)
    }
    
    var identifier: String? {
        set {
            objc_setAssociatedObject(self, UIImage.RuntimeKey.jkKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, UIImage.RuntimeKey.jkKey!) as? String
        }
    }
    
    
//    func compressImageData(maxLength: Int) -> Data?{
//
//        guard let vData = UIImage.jpegData(compressionQuality:1.0) else { return nil }
//        print("压缩前kb: \( Double((vData.count)/1024))")
//        if vData.count < maxLength {
//            return vData
//        }
//        var compress:CGFloat = 0.9
//        guard var data =  UIImageJPEGRepresentation(self, compress) else { return nil }
//        while data.count > maxLength && compress > 0.01 {
//            print("压缩比: \(compress)")
//            compress -= 0.02
//            data = UIImageJPEGRepresentation(self, compress)!
//        }
//        print("压缩后kb: \(Double((data.count)/1024))")
//        return data
//
//    }
    

//    func compressImageAsync(maxLength: Int, feedbackBlock: @escaping (_ newImageData: Data?)->()) {
//
//        //创建一个NSOperationQueue实例并添加operation
//        let queue = OperationQueue()
//        let operation = BlockOperation(block: {
//
//            guard let vData = UIImageJPEGRepresentation(self, 1.0) else { return }
//            print("压缩前kb: \( Double((vData.count)/1024))")
//            if vData.count < maxLength {
//                feedbackBlock(vData)
//            }
//            var compress:CGFloat = 0.9
//            guard var data =  UIImageJPEGRepresentation(self, compress) else { return }
//            while data.count > maxLength && compress > 0.01 {
//                print("压缩比: \(compress)")
//                compress -= 0.02
//                data = UIImageJPEGRepresentation(self, compress)!
//            }
//            print("压缩后kb: \(Double((data.count)/1024))")
//            feedbackBlock(data)
//
//        })
//        queue.addOperation(operation)
//    }
    

//    func kylCompressImageData() -> Data?{
//
//        let originalParm : CGFloat = 0.7
//        let compress:CGFloat = 0.5
//
//        guard var data = UIImageJPEGRepresentation(self, originalParm) else { return nil }
//        let dataSize = Double((data.count)/1024)
//        print("压缩前kb: \(dataSize)")
//        //如果小于1M不压缩
//        if dataSize < 1024 {
//            return data
//        }else{
//            data = UIImageJPEGRepresentation(self, compress)!
//            print("压缩后kb: \(Double((data.count)/1024))")
//        }
//        print("压缩后kb: \(Double((data.count)/1024))")
//        return data
//    }
    
    /**
     *  获得指定size的图片
     *  newSize 指定的size
     *  return 调整后的图片
     */
    func getResizeImage(newSize: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /**
     *  特定的图片大小压缩策略得到的新图片
     *  return 调整后的图片
     */
    func resizeImage() -> UIImage?{
        
        //prepare constants
        let width = self.size.width
        let height = self.size.height
        let scale = width/height
        
        var sizeChange = CGSize()
        
        if width <= 1280 && height <= 1280{ //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
            return self
        }else if width > 1280 || height > 1280 {//b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
            
            if scale <= 2 && scale >= 1 {
                let changedWidth:CGFloat = 1280
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if scale >= 0.5 && scale <= 1 {
                
                let changedheight:CGFloat = 1280
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if width > 1280 && height > 1280 {//宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
                
                if scale > 2 {//高的值比较小
                    
                    let changedheight:CGFloat = 1280
                    let changedWidth:CGFloat = changedheight * scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }else if scale < 0.5{//宽的值比较小
                    
                    let changedWidth:CGFloat = 1280
                    let changedheight:CGFloat = changedWidth / scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }
            }else {//d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
                return self
            }
        }
        
        return self.getResizeImage(newSize: sizeChange)
    }
    
    
//    func kylUploadImageData() -> Data?{
//
//        return resizeImage()?.kylCompressImageData()
//    }
    
    

    
}

