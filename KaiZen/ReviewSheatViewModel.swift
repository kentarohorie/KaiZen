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
}

class ReviewSheatViewModel: NSObject, UITableViewDataSource, UITableViewDelegate, ReviewSheatTableViewCellDelegate, ReviewSheatViewDelegate, AddReviewViewDelegate, ShowReviewViewControllerDelegate, SideMenuViewDelegate {
    
    let reviewSheetManager: ReviewSheetManager = ReviewSheetManager.sharedInstance
    var reviewSheet: ReviewSheet = ReviewSheet()
    weak var customDelegate: ReviewSheatViewModelDelegate?
    var isTapEdit: Bool = true
    
    //------- receive and send data ----------
    
    func changeSegConValue(sender: UISegmentedControl) {
        let cell = sender.superview?.superview as! UITableViewCell
        let tableView = cell.superview?.superview as! UITableView
        let row = tableView.indexPathForCell(cell)?.row
        
        reviewSheet.reviewArray[row!].reviewPoint = sender.selectedSegmentIndex
    }
    
    func tapAddReview() -> AddReviewView {
        let addReviewView = UINib(nibName: "AddReviewView", bundle: nil).instantiateWithOwner(self, options: nil).first as! AddReviewView
        addReviewView.customDelegate = self
        
        return addReviewView
    }
    
    func tapEdit(tableView: UITableView, callback: () -> Void) {
        print("edit...")
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
        review.reviewPoint = 0
        review.reviewText = text

        reviewSheet.reviewArray.append(review)
        customDelegate?.changeTableViewDate()
        ReviewSheetManager.saveForDevise()///////////
    }
    
    func tapDone(tableView: UITableView) {
        let appendReviewSheet = ReviewSheet()
        
        for review in reviewSheet.reviewArray {
            let appendReview = Review()
            appendReview.reviewPoint = review.reviewPoint
            appendReview.reviewText = review.reviewText
            appendReviewSheet.reviewArray.append(appendReview)
        }
        
        reviewSheetManager.reviewSheetArray.append(appendReviewSheet)
        ReviewSheetManager.saveForDevise()//////////
        tableView.reloadData()
    }
    
    func viewDidLoad(callback: () -> Void) {
        ReviewSheetManager.fetchFromDevise { () -> Void in
            if self.reviewSheetManager.reviewSheetArray.count != 0 {
                for modelReview in (self.reviewSheetManager.reviewSheetArray.last?.reviewArray)! {
                    let review = Review()
                    review.reviewText = modelReview.reviewText
                    
                    self.reviewSheet.reviewArray.append(review)
                }
            }
            
            callback()
        }
    }
    
    func edgeSwipeRight(superView: UIView) -> SideMenuView {
        let sideMenuView = UINib(nibName: "SideMenuView", bundle: nil).instantiateWithOwner(self, options: nil).first as! SideMenuView
        sideMenuView.framingFromSuperView(superView)
        sideMenuView.customDelegate = self
        
        return sideMenuView
    }
    
    
    //------------ OPERATE FOR SIDEMENU ---------------
    
    func sideMenuDidPlus() {
        let reviewSheet = ReviewSheet()
        
    }
    
    func sideMenuDidMinus() {

    }
    
    
    //--------------- tableViewSetting -----------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewSheatTableViewCell") as! ReviewSheatTableViewCell
        cell.customDelegate = self
        cell.reviewTextLabel.text = reviewSheet.reviewArray[indexPath.row].reviewText
        cell.gradeSegmentedControl.selectedSegmentIndex = 0
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewSheet.reviewArray.count
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
            reviewSheet.reviewArray.removeAtIndex(indexPath.row)
            tableView.reloadData()
            ReviewSheetManager.saveForDevise()
        }
    }
    
    
}
