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
        setDoneShadow()

        self.frame = UIScreen.mainScreen().bounds
        self.bringSubviewToFront(doneButton)
        self.subviews[0].layer.cornerRadius = self.frame.width / 40
        self.subviews[0].layer.shadowOffset = CGSize(width: 4, height: -4)
        self.subviews[0].layer.shadowOpacity = 1
        self.subviews[0].layer.shadowColor = UIColor.blackColor().CGColor
    }
    
    func tableViewSetUP() {
        tableView.registerNib(UINib(nibName: "ReviewSheatTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewSheatTableViewCell")
        tableView.separatorColor = UIColor.clearColor()
        tableView.layer.cornerRadius = tableView.frame.width / 30
        
        tableView.backgroundColor = UIColor.clearColor()
    }
    
    func setGesture() {
        let edgePanGestureRecog = UIScreenEdgePanGestureRecognizer(target: self, action: "edgeSwipeRight:")
        edgePanGestureRecog.edges = .Left
        edgePanGestureRecog.delegate = self
        self.addGestureRecognizer(edgePanGestureRecog)
    }
    
    func setDoneShadow() {
        doneButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        doneButton.layer.shadowOpacity = 0.4
    }
    
    //--------- method -------
    
    func setAddView(addView: AddReviewView) {
        print(self.frame)
        addView.frame.size = CGSize(width: self.frame.width / 5 * 4, height: self.frame.height / 100 * 24)
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
                self.setAlert("シートの設定、レビューの追加をしてください", title: nil)
                return
            }
            self.tableView.reloadData()
        })
    }
    
    @IBAction func tapAddReview(sender: UIButton) {
        guard let addView = customDelegate?.tapAddReview?() else {
            setAlert("まずシートを作りましょう", title: nil)
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
    
    @IBAction func tapMenu(sender: UIButton) {
        
    }
    
    @IBAction func tapLeft(sender: UIButton) {
        var baseView = UIApplication.sharedApplication().keyWindow?.rootViewController
        while ((baseView?.presentedViewController) != nil)  {
            baseView = baseView?.presentedViewController
        }
        let mainBoardViewController = baseView as? MainBoardViewController
        let secondViewController = ShowChartViewController()
        mainBoardViewController?.pageViewController.setViewControllers([secondViewController], direction: .Forward, animated: true, completion: nil)
        
            mainBoardViewController?.generalViewModel.isSecond = true
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
            
            setAlert("反省完了！", title: nil)
        } else {
            setAlert("レビューを追加してください", title: nil)
        }
    }
    
    func changeSheetTitle(title: String) {
        self.sheetTitleLabel.text = title
    }
    
    func reviewSheetWillDisplay() {
        customDelegate?.reviewSheetViewWillDisplay!()
    }

}
