//
//  SideMenuView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/17.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol SideMenuViewDelegate {
    optional func sideMenuDidRemoveSelf()
}

class SideMenuView: UIView {

    var baseView: UIView!
    weak var customDelegate: SideMenuViewDelegate?
    var coverView: UIView = UIView()
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.yellowColor()
        selfSetting()
    }
    
    func selfSetting() {
        self.hidden = true
        coverView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: "removeSideMenu")
        coverView.addGestureRecognizer(tapGestureRecog)
    }
    
    func framingFromSuperView(baseView: UIView) {
        self.baseView = baseView
        
        self.frame.size = CGSize(width: baseView.frame.width / 5 * 3, height: baseView.frame.height)
        self.frame.origin = CGPoint(x: -(baseView.frame.width), y: 0)
        
        coverView.frame.size = CGSize(width: 0, height: baseView.frame.height)
        coverView.frame.origin = CGPoint(x: self.frame.origin.x + self.frame.width, y: 0)
                coverView.frame.width
        baseView.addSubview(coverView)
    }
    
    func appearSideMenu() {
        self.hidden = false
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.frame.origin.x = 0
            
            self.coverView.frame.origin.x = self.frame.width
            self.coverView.frame.size = CGSize(width: self.baseView.frame.width - self.frame.width, height: self.baseView.frame.height)
            self.coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    func removeSideMenu() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.frame.origin.x = -(self.baseView.frame.width)
            self.coverView.backgroundColor = UIColor.clearColor()
            }) { (bool) -> Void in
                self.removeFromSuperview()
                guard let delegate = self.customDelegate else {
                    return
                }
                delegate.sideMenuDidRemoveSelf!()
        }
    }
    
}
