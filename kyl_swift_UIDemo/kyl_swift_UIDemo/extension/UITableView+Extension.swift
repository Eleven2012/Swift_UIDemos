//
//  UITableView+Extension.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setTableHeaderView(headerView: UIView, height: Float) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableHeaderView = headerView
        headerView.snp.makeConstraints { (make) in
            make.top.width.centerX.equalTo(self)
            make.height.equalTo(height)
        }
    }
    
    func shouldUpdateHeaderViewFrame() -> Bool {
        guard let headerView = self.tableHeaderView else {
            return false
        }
        
        let oldSize = headerView.bounds.size
        // Update the size
        headerView.layoutIfNeeded()
        let newSize = headerView.bounds.size
        return oldSize != newSize
    }
}
