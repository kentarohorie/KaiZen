//
//  SideMenuView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/17.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol SideMenuViewDelegate {
    optional func sideMenuDidPlus(sheetName: String)
    optional func sideMenuDidMinus()
    optional func sideMenuCellDidSelect(row: Int)
}




class SideMenuView: UIView, UITableViewDataSource, UITableViewDelegate, AddReviewViewDelegate {

    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    var addSheetView: AddReviewView?
    var baseView: UIView!
    weak var customDelegate: SideMenuViewDelegate?
    let coverView: UIView = UIView()
    
    let reviewSheetManager = ReviewSheetManager.sharedInstance
    
    override func awakeFromNib() {
        selfSetting()
    }
    
    // ----- view setting -----------
    
    func selfSetting() {
        self.hidden = true
        coverView.backgroundColor = UIColor.clearColor()

        tableViewSetting()
        buttonSetting()
        setGesture()
    }
    
    func tableViewSetting() {
        sideMenuTableView.registerNib(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideMenuCell")
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        
        sideMenuTableView.backgroundColor = UIColor.clearColor()
        
    }
    
    func setGesture() {
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: "removeSideMenu")
        coverView.addGestureRecognizer(tapGestureRecog)
        
        let coverViewSwileLeftGestureRecog = UISwipeGestureRecognizer(target: self, action: "removeSideMenu")
        coverViewSwileLeftGestureRecog.direction = .Left
        coverView.addGestureRecognizer(coverViewSwileLeftGestureRecog)
        
        
        let swipeLeftGestureRecog = UISwipeGestureRecognizer(target: self, action: "removeSideMenu")
        swipeLeftGestureRecog.direction = .Left
        self.addGestureRecognizer(swipeLeftGestureRecog)

    }
    
    func buttonSetting() {
//        plusButton.layer.borderColor = UIColor.whiteColor().CGColor
//        plusButton.layer.borderWidth = 0.3
//        
//        minusButton.layer.borderColor = UIColor.whiteColor().CGColor
//        minusButton.layer.borderWidth = 0.3
        
    }
    
    //------------ method -----------------
    
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
        }
    }
    
    func setAddView() {
        addSheetView = UINib(nibName: "AddReviewView", bundle: nil).instantiateWithOwner(self, options: nil).first as? AddReviewView
        addSheetView!.customDelegate = self
        addSheetView?.center = CGPoint(x: self.superview!.center.x, y: -(addSheetView!.frame.height))
        
        UIView.animateWithDuration(0.8) { () -> Void in
            self.addSheetView?.center.y = self.center.y
        }
        
        self.addSubview(addSheetView!)
    }
    
    // ----- receive event --------
    
    @IBAction func tapPlusButton(sender: UIButton) {
        setAddView()
    }
    
    @IBAction func tapMinusButton(sender: UIButton) {
//        if sender.selected {
//            sideMenuTableView.setEditing(true, animated: true)
//        } else {
//            sideMenuTableView.setEditing(false, animated: true)
//        }
        
        guard let delegate = customDelegate else {
            return
        }
        delegate.sideMenuDidMinus!()
    }
    
    func tapAddOfAddView(text: String) {
        guard let delegate = customDelegate else {
            return
        }
        delegate.sideMenuDidPlus!(text)
        sideMenuTableView.reloadData() //callbackで
    }
    
    
    
    
    
    
    
    
    
    
    //--------- likely modelview... ------------->>>
    
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
        
        cell.titleLabel.text = reviewSheetManager.reviewSheetArray[indexPath.row].title
        
        return cell
    }
    
    //------------ tableView delegate --------------
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        let didSelectCell = tableView.cellForRowAtIndexPath(indexPath) as! SideMenuTableViewCell
//        UIView.animateWithDuration(0.2) { () -> Void in
//            didSelectCell.isSelectView.backgroundColor = UIColor.clearColor()
//        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! SideMenuTableViewCell
//        UIView.animateWithDuration(0.2) { () -> Void in
//            selectedCell.isSelectView.backgroundColor = UIColor(red: 2/255, green: 168/255, blue: 243/255, alpha: 1)
//        }
        guard let delegate = customDelegate else {
            return
        }
        delegate.sideMenuCellDidSelect!(indexPath.row)
        self.removeSideMenu()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            reviewSheetManager.reviewSheetArray.removeAtIndex(indexPath.row)
            tableView.reloadData()
            //            ReviewSheetManager.saveForDevise() ///////
        }
    }
    
}
