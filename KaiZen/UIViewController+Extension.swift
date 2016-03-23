//
//  UIViewController+Extension.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/03/23.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

func isFirstRun() -> Bool {
    let defaults = NSUserDefaults.standardUserDefaults()
    guard let date = defaults.objectForKey("firstRunDate") else {
        let date = NSDate()
        defaults.setObject(date, forKey: "firstRunDate")
        return true
    }
    print(date)
    return false
}
