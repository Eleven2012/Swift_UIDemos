//
//  String+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import ObjectiveC
import CommonCrypto
import UIKit

extension String{
    func md5() ->String!{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        //result.deinitialize()
        return String(format: hash as String)
    }
    
    /** 去除首尾空格 */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /** url编码 */
    func urlEncode() -> String {
        if let encodeString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return encodeString
        }
        return self
    }
    /** url解码 */
    func urlDecode() -> String {
        if let decodeString = self.removingPercentEncoding {
            return decodeString
        }
        return self
    }
    
    /** 是否是数字 */
    func isNumber() -> Bool {
        var result = false
        
        if !self.isEmpty {
            let regex = "^[0-9]*$"
            let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
            result = predicate.evaluate(with: self)
        }
        
        return result
    }
    
    /** 是否是邮箱地址 */
    func isEmail() -> Bool {
        var result = false
        
        if !self.isEmpty {
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
            result = predicate.evaluate(with: self)
        }
        
        return result
    }
    
    
    /// NSRange 转换 Range
    ///
    /// - Parameter range:
    /// - Returns:
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    
    
    /// 是否包含emoji
    var containsEmoji: Bool {
        //九宫格 汉字 获取到的是圈123这样的
        //要可以输入
        let grid = ["➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒"]
        if grid.contains(self) {
            return false
        }
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, 0x1D000...0x1F77F, 0x2100...0x27BF, 0xFE00...0xFE0F, 0x1F900...0x1F9FF:
                //            0x00A0...0x00AF,
                //            0x2030...0x204F,
                //            0x2120...0x213F,
                //            0x2190...0x21AF,
                //            0x2310...0x329F,
                //            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    /// 判断输入是否包含特殊字符
    ///
    /// - Parameter pattern: 输入的字符串
    /// - Returns: 是否包含
    var regex: Bool {
        if self.count == 0 {
            return false
        }
        
        do {
            // 非字母，数字，下划线，基本语言文字
            //let astring = "/[^\\w\\u0000-\\u1FFF\\u2C00-\\uD7FF]/g";
            // 标点符号
            let bstring = "/[`~!@#$%^&*()+=|{}':;',\\[\\].<>~！@#￥¥％……&*（）——+|{}【】‘；：”“'。，、？]";
            //定义正则表达式
            let regular = try NSRegularExpression(pattern: self, options:.caseInsensitive)
            //输出截取结果//bstring.characters.count
            //let resultas = regular.matches(in: astring, options: .reportProgress , range: NSMakeRange(0, astring.characters.count))
            let resultbs = regular.matches(in: bstring, options: .reportProgress , range: NSMakeRange(0, bstring.count))
            if resultbs.count == 0 {
                return false
            }
        } catch {
            print(error)
        }
        
        return true
    }
    
    /** 移除emoji */
    func removeEmoji() -> String {
        if !self.isEmpty {
            do {
                let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
                let regular = try NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
                let result = regular.stringByReplacingMatches(in: self, options: .reportProgress, range: NSMakeRange(0, self.count), withTemplate: "")
                if result != self {
                    return result
                }
            } catch {}
        }
        return self
    }
    
    /** 移除特殊字符 */
    func removeSpecialChars() -> String {
        if !self.isEmpty {
            let pattern = "/`~!?@#$%^&*()+=|{}'\":;,\\[].<>~！￥……（）——【】‘；：”“。，、？"
            let set = CharacterSet.init(charactersIn: pattern)
            let array = self.components(separatedBy: set) as NSArray
            if array.count > 0 {
                return array.componentsJoined(by: "")
            }
        }
        return self
    }
    
    func fiterSpecialChars() -> String{
        if !self.isEmpty {
            let pattern = "/`~!?@#$%^&*()+=|{}'\":\\[]<>~！￥……（）——【】‘：”“？"
            let set = CharacterSet.init(charactersIn: pattern)
            let array = self.components(separatedBy: set) as NSArray
            if array.count > 0 {
                return array.componentsJoined(by: "")
            }
        }
        return self
    }
    
    
    struct RuntimeKey {
        static let jkKey = UnsafeRawPointer.init(bitPattern: "JKKey".hashValue)
    }
    
//    var identifier: String? {
//        set {
//            objc_setAssociatedObject(self, UIImage.RuntimeKey.jkKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//
//        get {
//            return  objc_getAssociatedObject(self, UIImage.RuntimeKey.jkKey!) as? String
//        }
//    }
    
    
    func calculateSize(_ size: CGSize, font: UIFont) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        //        paragraphStyle.lineSpacing = 7
        paragraphStyle.lineBreakMode = .byCharWrapping
        let attributes = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        let expectedLabelSize = (self as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil).size
        return expectedLabelSize
    }
    
    
    func getWidth(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font : font]
        return (self as NSString).boundingRect(with: CGSize.zero, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size.width
    }
    
    
    /// 时间戳描述
    var timeIntervalDescription: String {
        guard let late = TimeInterval(self) else {
            return ""
        }
        let now = Date().timeIntervalSince1970
        var timeString = ""
        let cha = now-late/1000
        if (cha/60 < 1) {
            timeString = String(format: "%@ \(KYLLocalizedString("Just now"))", "")
        } else if (cha/3600 < 1) {
            timeString = String(format: "%f", cha/60)
            timeString = (timeString as NSString).substring(to: timeString.count-7)
            timeString = KYLLocalizedReplacingPlaceholder(localizedString: KYLLocalizedString("Five minutes ago"), replace: timeString)
        } else if (cha/3600 > 1 && cha/86400 < 1) {
            timeString = String(format: "%f", cha/3600)
            timeString = (timeString as NSString).substring(to: timeString.count-7)
            timeString = KYLLocalizedReplacingPlaceholder(localizedString: KYLLocalizedString("Five hours ago"), replace: timeString)
        } else if (cha/86400 > 1) {
            timeString = String(format: "%f", cha/86400)
            timeString = (timeString as NSString).substring(to: timeString.count-7)
            timeString = KYLLocalizedReplacingPlaceholder(localizedString: KYLLocalizedString("Five days ago"), replace: timeString)
        } else {
            let createdDate = Date(timeIntervalSince1970: late)
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm"
            timeString = formatter.string(from: createdDate)
        }
        return timeString
    }
    
    var dateString: String? {
        guard let late = TimeInterval(self) else {
            return nil
        }
        let createdDate = Date(timeIntervalSince1970: late/1000)
        let formatter = DateFormatter()
        if KYLLanguagesUtilities.languageCodeToService() == .ChineseSimplified {
            formatter.dateFormat = "YYYY年MM月dd日"
        } else {
            formatter.dateFormat = "YYYY-MM-dd"
        }
        return formatter.string(from: createdDate)
    }
    
    var sqlString: String {
        var sqlText = ""
        if self.count > 0 {
            sqlText = replacingOccurrences(of: "'", with: "''")
            //            sqlText = sqlText.replacingOccurrences(of: "/", with: "//")
            //            sqlText = sqlText.replacingOccurrences(of: "[", with: "/[")
            //            sqlText = sqlText.replacingOccurrences(of: "]", with: "/]")
            //            sqlText = sqlText.replacingOccurrences(of: "%", with: "/%")
            //            sqlText = sqlText.replacingOccurrences(of: "&", with: "/&")
            //            sqlText = sqlText.replacingOccurrences(of: "_", with: "/_")
            //            sqlText = sqlText.replacingOccurrences(of: "(", with: "/(")
            //            sqlText = sqlText.replacingOccurrences(of: ")", with: "/)")
        }
        return sqlText
    }
}


extension String {
    
    static var chars: [Character] = {
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".map({$0})
    }()
    
    static func random(length: Int) -> String {
        var partial: [Character] = []
        
        for _ in 0..<length {
            let rand = Int(arc4random_uniform(UInt32(chars.count)))
            partial.append(chars[rand])
        }
        
        return String(partial)
    }
}
