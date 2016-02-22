//
//  ReviewSheatView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/09.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol ReviewSheatViewDelegate {
    optional func tapEdit(tableView: UITableView, callback: (isEdit: Bool) -> Void)
    optional func tapAddReview() -> AddReviewView?
    optional func tapDone(tableView: UITableView)
    optional func edgeSwipeRight(superView: UIView) -> SideMenuView
    optional func reviewSheetViewWillDisplay()
}



class ReviewSheatView: UIView, ReviewSheatViewModelDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var sheetTitleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    weak var customDelegate: ReviewSheatViewDelegate?
    var addReviewView: AddReviewView?
    var sideMenuView: SideMenuView?
    var isDisplaySideMenu: Bool = false
    var isDisplayAddView: Bool = false
    
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
    
    //--------- method -------
    
    func setAlert(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        
        var baseView = UIApplication.sharedApplication().keyWindow?.rootViewController
        while ((baseView?.presentedViewController) != nil)  {
            baseView = baseView?.presentedViewController
        }
        
        baseView?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setAddView(addView: AddReviewView) {
        addView.center = CGPoint(x: self.center.x, y: -(addView.frame.height))
        
        UIView.animateWithDuration(0.8) { () -> Void in
            addView.center.y = self.center.y
        }
        
        self.addSubview(addView)
    }

    
    //---------receive event ------------------------
    
    @IBAction func tapEdit(sender: UIButton) {
        customDelegate?.tapEdit!(tableView, callback: { (bool) -> Void in
            guard bool else {
                self.setAlert("シートの設定、レビューの追加をしてください")
                return
            }
            self.tableView.reloadData()
        })
    }
    
    @IBAction func tapAddReview(sender: UIButton) {
        guard let addView = customDelegate?.tapAddReview?() else {
            setAlert("まずシートを作りましょう")
            return
        }
        
        if !(isDisplayAddView) {
            setAddView(addView)
            isDisplayAddView = true
        }
        
    }
    
    @IBAction func tapDone(sender: UIButton) {
        customDelegate?.tapDone!(tableView)
        
    }
    
    func edgeSwipeRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Began && !(isDisplaySideMenu) {
            (self.superview?.superview as? UIScrollView)?.scrollEnabled = false
            UIApplication.sharedApplication().statusBarHidden = true
            
            
            sideMenuView = customDelegate?.edgeSwipeRight!(self)
            self.addSubview(sideMenuView!)
            sideMenuView?.appearSideMenu()
            isDisplaySideMenu = true
        }
    }
        
    //----- send event ------------
    
    func changeTableViewDate() {
        tableView.reloadData()
    }
    
    func isDataAlert(bool: Bool) {
        if bool {
            setAlert("反省完了！")
        } else {
            setAlert("レビューを追加してください")
        }
    }
    
    func changeSheetTitle(title: String) {
        self.sheetTitleLabel.text = title
    }
    
    func reviewSheetWillDisplay() {
        customDelegate?.reviewSheetViewWillDisplay!()
    }

}
