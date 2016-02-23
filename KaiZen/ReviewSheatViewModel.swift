//
//  ReviewSheatViewModel.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/09.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol ReviewSheatViewModelDelegate {
    func changeTableViewDate()
    func changeSheetTitle(title: String)
    func isDataAlert(bool: Bool)
}

class ReviewSheatViewModel: NSObject, UITableViewDataSource, UITableViewDelegate, ReviewSheatTableViewCellDelegate, ReviewSheatViewDelegate, AddReviewViewDelegate, ShowReviewViewControllerDelegate, SideMenuViewDelegate {
    
    let reviewSheetManager: ReviewSheetManager = ReviewSheetManager.sharedInstance
    var reviewSheetTmp = ReviewSheet()
    weak var customDelegate: ReviewSheatViewModelDelegate?
    var isTapEdit: Bool = true
    
    //------- receive and send data ----------
    
    func changeSegConValue(sender: UISegmentedControl) {
        let cell = sender.superview?.superview as! UITableViewCell
        let tableView = cell.superview?.superview as! UITableView
        let row = tableView.indexPathForCell(cell)?.row
        
        reviewSheetTmp.reviewArray[row!].reviewPoint = sender.selectedSegmentIndex
    }
    
    func tapAddReview() -> AddReviewView? {
        guard reviewSheetManager.currentReviewSheet != nil else {
            return nil
        }
        
        let addReviewView = UINib(nibName: "AddReviewView", bundle: nil).instantiateWithOwner(self, options: nil).first as! AddReviewView
        addReviewView.customDelegate = self
        
        return addReviewView
    }
    
    func tapEdit(tableView: UITableView, callback: (isEdit: Bool) -> Void) {
        guard reviewSheetManager.currentReviewSheet != nil && reviewSheetTmp.reviewArray.count != 0 else {
            callback(isEdit: false)
            return
        }
        if isTapEdit {
            tableView.setEditing(true, animated: true)
            isTapEdit = false
        } else {
            tableView.setEditing(false, animated: true)
            isTapEdit = true
        }
        callback(isEdit: true)
    }
    
    func tapAddOfAddView(text: String) {
        let review = Review()
        review.set(text, reviewPoint: 0)

        reviewSheetTmp.reviewArray.append(review)
        customDelegate?.changeTableViewDate()
        ReviewSheetManager.saveForDevise()
    }
    
    func tapDone(tableView: UITableView) {
        guard reviewSheetTmp.reviewArray.count != 0 else {
            customDelegate?.isDataAlert(false)
            return
        }

        reviewSheetTmp.appendPointRatio(reviewSheetTmp.reviewArray)
        ReviewSheetManager.saveForDevise()
        
        reviewSheetTmp.resetReviewPoint()
        tableView.reloadData()
        customDelegate?.isDataAlert(true)
    }
    
    func viewDidLoad(callback: () -> Void) {
        ReviewSheetManager.fetchFromDevise { () -> Void in
            callback()
        }
    }
    
    func edgeSwipeRight(superView: UIView) -> SideMenuView {
        let sideMenuView = UINib(nibName: "SideMenuView", bundle: nil).instantiateWithOwner(self, options: nil).first as! SideMenuView
        sideMenuView.framingFromSuperView(superView)
        sideMenuView.customDelegate = self
        
        return sideMenuView
    }
    
    
    func reviewSheetViewWillDisplay() {
        guard let currentSheet = reviewSheetManager.currentReviewSheet else {
            return
        }
        reviewSheetTmp = currentSheet
        customDelegate?.changeTableViewDate()
        customDelegate?.changeSheetTitle(reviewSheetTmp.title!)
    }
    //------------ OPERATE FOR SIDEMENU ---------------
    
    func sideMenuDidPlus(sheetName: String) {
        let reviewSheet = ReviewSheet()
        reviewSheet.title = sheetName
        
        reviewSheetManager.reviewSheetArray.append(reviewSheet)
        ReviewSheetManager.saveForDevise()
    }
    
    func sideMenuDidMinus() {

    }
    
    func sideMenuCellDidSelect(row: Int) {
        reviewSheetTmp = reviewSheetManager.reviewSheetArray[row]
        customDelegate?.changeTableViewDate()
        customDelegate?.changeSheetTitle(reviewSheetTmp.title!)
        reviewSheetManager.currentReviewSheet = reviewSheetTmp
    }
    
    
    //--------------- tableViewSetting -----------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewSheatTableViewCell") as! ReviewSheatTableViewCell
        cell.customDelegate = self
        cell.reviewTextLabel.text = reviewSheetTmp.reviewArray[indexPath.row].reviewText
        cell.gradeSegmentedControl.selectedSegmentIndex = 0
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewSheetTmp.reviewArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            reviewSheetTmp.reviewArray.removeAtIndex(indexPath.row)
            tableView.reloadData()
            ReviewSheetManager.saveForDevise()
        }
    }
    
    
}
