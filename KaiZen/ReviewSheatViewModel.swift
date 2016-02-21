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
    
    func tapEdit(tableView: UITableView, callback: () -> Void) {
        if isTapEdit {
            tableView.setEditing(true, animated: true)
            isTapEdit = false
        } else {
            tableView.setEditing(false, animated: true)
            isTapEdit = true
        }
        callback()
    }
    
    func tapAddOfAddView(text: String) {
        let review = Review()
        review.set(text, reviewPoint: 0)

        reviewSheetTmp.reviewArray.append(review)
        customDelegate?.changeTableViewDate()
//        ReviewSheetManager.saveForDevise()///////////
    }
    
    func tapDone(tableView: UITableView) {
//        ReviewSheetManager.saveForDevise()//////////
        guard reviewSheetTmp.reviewArray.count != 0 else {
            customDelegate?.isDataAlert(false)
            return
        }
        
        reviewSheetTmp.appendPointRatio(reviewSheetTmp.reviewArray)
        tableView.reloadData()
        customDelegate?.isDataAlert(true)
    }
    
//    func viewDidLoad(callback: () -> Void) {
//        ReviewSheetManager.fetchFromDevise { () -> Void in
//            if self.reviewSheetManager.reviewSheetArray.count != 0 {
//                for modelReview in (self.reviewSheetManager.reviewSheetArray.last?.reviewArray)! {
//                    let review = Review()
//                    review.reviewText = modelReview.reviewText
//                    
//                    self.reviewSheet.reviewArray.append(review)
//                }
//            }
//            
//            callback()
//        }
//    }
    
    func edgeSwipeRight(superView: UIView) -> SideMenuView {
        let sideMenuView = UINib(nibName: "SideMenuView", bundle: nil).instantiateWithOwner(self, options: nil).first as! SideMenuView
        sideMenuView.framingFromSuperView(superView)
        sideMenuView.customDelegate = self
        
        return sideMenuView
    }
    
    
    //------------ OPERATE FOR SIDEMENU ---------------
    
    func sideMenuDidPlus(sheetName: String) {
        let reviewSheet = ReviewSheet()
        reviewSheet.title = sheetName
        
        reviewSheetManager.reviewSheetArray.append(reviewSheet)
    }
    
    func sideMenuDidMinus() {

    }
    
    func sideMenuCellDidSelect(row: Int) {
        reviewSheetTmp = reviewSheetManager.reviewSheetArray[row]
        customDelegate?.changeTableViewDate()
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
    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            for reviewSheet in reviewSheetManager.reviewSheetArray {
                reviewSheet.reviewArray.removeAtIndex(indexPath.row)
            }
            reviewSheetTmp.reviewArray.removeAtIndex(indexPath.row)
            tableView.reloadData()
            ReviewSheetManager.saveForDevise()
        }
    }
    
    
}
