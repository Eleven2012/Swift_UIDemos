//
//  ViewController.swift
//  kyl_swift_UIDemo
//
//  Created by yulu kong on 2019/7/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var customSwitch: JMCustomSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testSwitch()
    }
    
    private func testSwitch() {
        self.customSwitch = JMCustomSwitch()
        self.view.addSubview(customSwitch)
        customSwitch.center = self.view.center
        customSwitch.bounds = CGRect(x: 0, y: 0, width: 200, height: 60)
        customSwitch.valueChangedHandle = {(isOn) in
            print(isOn)
        }
        
        var config = JMSwitchConfig()
        config.offBgColor = UIColor.red
        customSwitch.config = config
    }


}

