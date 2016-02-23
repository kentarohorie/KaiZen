//
//  File.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/22.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

extension UIView {
    
    func setAlert(message: String, title: String?) {
        let alertController = UIAlertController(title: message, message: title, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        
        var baseView = UIApplication.sharedApplication().keyWindow?.rootViewController
        while ((baseView?.presentedViewController) != nil)  {
            baseView = baseView?.presentedViewController
        }
        
        baseView?.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

