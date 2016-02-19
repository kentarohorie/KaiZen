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

    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var baseView: UIView!
    weak var customDelegate: SideMenuViewDelegate?
    let coverView: UIView = UIView()
    let sideMenuViewModel: SideMenuViewModel = SideMenuViewModel()
    
    override func awakeFromNib() {
        selfSetting()
    }
    
    func selfSetting() {
        self.hidden = true
        coverView.backgroundColor = UIColor.clearColor()
        
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: "removeSideMenu")
        coverView.addGestureRecognizer(tapGestureRecog)
        
        let swipeLeftGestureRecog = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
        swipeLeftGestureRecog.direction = .Left
        self.addGestureRecognizer(swipeLeftGestureRecog)
        
        tableViewSetting()
    }
    
    func tableViewSetting() {
        sideMenuTableView.registerNib(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideMenuCell")
        sideMenuTableView.delegate = sideMenuViewModel
        sideMenuTableView.dataSource = sideMenuViewModel
        
        sideMenuTableView.backgroundColor = self.backgroundColor
        
    }
    
    func buttonSetting() {
        plusButton.layer.borderColor = UIColor.whiteColor().CGColor
        plusButton.layer.borderWidth = 0.6
        
        minusButton.layer.borderColor = UIColor.whiteColor().CGColor
        minusButton.layer.borderWidth = 0.6
        
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
            self.coverView.frame.origin = CGPoint(x: self.frame.width - self.baseView.frame.width, y: 0)
            self.coverView.backgroundColor = UIColor.clearColor()
            }) { (bool) -> Void in
                self.removeFromSuperview()
                guard let delegate = self.customDelegate else {
                    return
                }
                delegate.sideMenuDidRemoveSelf!()
        }
    }
    
    func swipeLeft() {
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
