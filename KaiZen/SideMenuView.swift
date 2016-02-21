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
    optional func sideMenuDidPlus()
    optional func sideMenuDidMinus()
}

class SideMenuView: UIView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    let reviewSheetManager = ReviewSheetManager.sharedInstance
    
    var baseView: UIView!
    weak var customDelegate: SideMenuViewDelegate?
    let coverView: UIView = UIView()
    
    override func awakeFromNib() {
        selfSetting()
    }
    
    func selfSetting() {
        self.hidden = true
        coverView.backgroundColor = UIColor.clearColor()
        
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: "removeSideMenu")
        coverView.addGestureRecognizer(tapGestureRecog)
        let coverViewSwileLeftGestureRecog = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
        coverViewSwileLeftGestureRecog.direction = .Left
        coverView.addGestureRecognizer(coverViewSwileLeftGestureRecog)

        
        let swipeLeftGestureRecog = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
        swipeLeftGestureRecog.direction = .Left
        self.addGestureRecognizer(swipeLeftGestureRecog)
        
        tableViewSetting()
    }
    
    func tableViewSetting() {
        sideMenuTableView.registerNib(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideMenuCell")
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        
        sideMenuTableView.backgroundColor = UIColor.clearColor()
        
    }
    
    func buttonSetting() {
        plusButton.layer.borderColor = UIColor.whiteColor().CGColor
        plusButton.layer.borderWidth = 0.6
        
        minusButton.layer.borderColor = UIColor.whiteColor().CGColor
        minusButton.layer.borderWidth = 0.6
        
    }
    
    //------------ action -----------------
    
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
            self.coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
    }
    
    func removeSideMenu() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.frame.origin.x = -(self.baseView.frame.width)
            self.coverView.frame.origin = CGPoint(x: self.frame.width - self.baseView.frame.width, y: 0)
            self.coverView.backgroundColor = UIColor.clearColor()
            }) { (bool) -> Void in
                (self.superview?.superview?.superview as? UIScrollView)?.scrollEnabled = true
                UIApplication.sharedApplication().statusBarHidden = false

                self.removeFromSuperview()
                guard let delegate = self.customDelegate else {
                    return
                }
//                delegate.sideMenuDidRemoveSelf!())
        }
    }
    
    func swipeLeft() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.frame.origin.x = -(self.baseView.frame.width)
            self.coverView.frame.origin = CGPoint(x: self.frame.width - self.baseView.frame.width, y: 0)
            self.coverView.backgroundColor = UIColor.clearColor()
            }) { (bool) -> Void in
                (self.superview?.superview?.superview as? UIScrollView)?.scrollEnabled = true
                UIApplication.sharedApplication().statusBarHidden = false
                
                self.removeFromSuperview()
                guard let delegate = self.customDelegate else {
                    return
                }
                
//                delegate.sideMenuDidRemoveSelf!()


        }
    }
    
    @IBAction func tapPlusButton(sender: UIButton) {
        guard let delegate = customDelegate else {
            return
        }
        delegate.sideMenuDidPlus!()
    }
    
    @IBAction func tapMinusButton(sender: UIButton) {
        guard let delegate = customDelegate else {
            return
        }
        delegate.sideMenuDidMinus!()
    }
    
    //----------- tableView datasource --------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewSheetManager.reviewSheetArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sideMenuCell") as! SideMenuTableViewCell
        
        cell.selectionStyle = .None
        cell.isSelectView.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    //------------ tableView delegate --------------
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let didSelectCell = tableView.cellForRowAtIndexPath(indexPath) as! SideMenuTableViewCell
        UIView.animateWithDuration(0.2) { () -> Void in
            didSelectCell.isSelectView.backgroundColor = UIColor.clearColor()
        }
        

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! SideMenuTableViewCell
        UIView.animateWithDuration(0.2) { () -> Void in
            selectedCell.isSelectView.backgroundColor = UIColor(red: 2/255, green: 168/255, blue: 243/255, alpha: 1)
        }
    }
    
}
