//
//  ReviewSheatView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/09.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol ReviewSheatViewDelegate {
    optional func tapEdit(tableView: UITableView, callback: () -> Void)
    optional func tapAddReview() -> AddReviewView
    optional func tapDone(tableView: UITableView)
    optional func edgeSwipeRight(superView: UIView) -> SideMenuView
}

class ReviewSheatView: UIView, ReviewSheatViewModelDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    weak var customDelegate: ReviewSheatViewDelegate?
    var addReviewView: AddReviewView?
    var sideMenuView: SideMenuView?
    
    override func awakeFromNib() {
        setUP()
    }
    
    //-------- set view -----------------------------
    
    func setUP() {
        tableViewSetUP()
        setGesture()
        
        self.bringSubviewToFront(doneButton)
        doneButton.layer.borderWidth = 0.6
        doneButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        doneButton.layer.cornerRadius = doneButton.frame.width / 5
    }
    
    func tableViewSetUP() {
        tableView.registerNib(UINib(nibName: "ReviewSheatTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewSheatTableViewCell")
        tableView.layer.borderWidth = 0.6
        tableView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        tableView.layer.cornerRadius = tableView.frame.width / 30
    }
    
    func setGesture() {
        let edgePanGestureRecog = UIScreenEdgePanGestureRecognizer(target: self, action: "edgeSwipeRight:")
        edgePanGestureRecog.edges = .Left
        edgePanGestureRecog.delegate = self
        self.addGestureRecognizer(edgePanGestureRecog)
    }
    
    //---------receive event ------------------------
    
    @IBAction func tapEdit(sender: UIButton) {
        customDelegate?.tapEdit!(tableView, callback: { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    @IBAction func tapAddReview(sender: UIButton) {
        addReviewView = customDelegate?.tapAddReview!()
        addReviewView?.center = CGPoint(x: self.center.x, y: -(addReviewView!.frame.height))
        
        UIView.animateWithDuration(0.8) { () -> Void in
            self.addReviewView?.center.y = self.center.y
        }
        
        self.addSubview(addReviewView!)
    }
    
    @IBAction func tapDone(sender: UIButton) {
        customDelegate?.tapDone!(tableView)
        setDoneAlert()
    }
    
    func edgeSwipeRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Began {
            (self.superview?.superview as? UIScrollView)?.scrollEnabled = false
            UIApplication.sharedApplication().statusBarHidden = true
            
            
            sideMenuView = customDelegate?.edgeSwipeRight!(self)
            self.addSubview(sideMenuView!)
            sideMenuView?.appearSideMenu()
        }
    }
        
    //----- send event ------------
    
    func changeTableViewDate() {
        tableView.reloadData()
    }
    
    func setDoneAlert() {
        let alertController = UIAlertController(title: "反省完了!", message: nil, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        
        var baseView = UIApplication.sharedApplication().keyWindow?.rootViewController
        while ((baseView?.presentedViewController) != nil)  {
            baseView = baseView?.presentedViewController
        }
        
        baseView?.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
