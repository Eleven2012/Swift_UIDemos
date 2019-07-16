//
//  KYLHintView.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SnapKit

class KYLHintView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        
        addSubview(leftLabel)
        addSubview(titleLabel)
        addSubview(rightLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 + Device.safeAreaInsets.left)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(20 + Device.safeAreaInsets.right)
            make.centerY.equalToSuperview()
        }
    }
    
    override var isHidden: Bool {
        willSet {
            if newValue == false {
                self.superview?.bringSubviewToFront(self)
            }
        }
    }
    
    //控件名称 + 当前速度
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: 0x596F80, alpha: 1.0)
        lbl.font = UIFont(regularFontSize: isPad ? 24 : 18)
        return lbl
    }()
    
    //起始角度/最小角度
    lazy var leftLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: 0x92A7B6, alpha: 1.0)
        lbl.font = UIFont(regularFontSize: isPad ? 18 : 12)
        return lbl
    }()
    
    //发射角度/最大角度
    lazy var rightLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: 0x92A7B6, alpha: 1.0)
        lbl.font = UIFont(regularFontSize: isPad ? 18 : 12)
        return lbl
    }()
}
