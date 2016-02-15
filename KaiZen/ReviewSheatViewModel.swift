//
//  ReviewSheatViewModel.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/09.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

protocol ReviewSheatViewModelDelegate {
    func changeTableViewDate()
}

class ReviewSheatViewModel: NSObject, UITableViewDataSource, UITableViewDelegate, ReviewSheatTableViewCellDelegate, ReviewSheatViewDelegate, AddReviewViewDelegate {
    
    let reviewSheetManager: ReviewSheetManager = ReviewSheetManager.sharedInstance
    var reviewSheet: ReviewSheet = ReviewSheet()
    var customDelegate: ReviewSheatViewModelDelegate?
    
    
    //------- delegate method -------
    
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
    
    func tapEdit(callback: () -> Void) {
        print("edit...")
        callback()
    }
    
    func tapAddOfAddView(text: String) {
        let review = Review()
        review.reviewPoint = 0
        review.reviewText = text

        reviewSheet.reviewArray.append(review)
        customDelegate?.changeTableViewDate()
    }
    
    func tapDone() {
        let appendReviewSheet = ReviewSheet()
        
        for review in reviewSheet.reviewArray {
            let appendReview = Review()
            appendReview.reviewPoint = review.reviewPoint
            appendReview.reviewText = review.reviewText
            appendReviewSheet.reviewArray.append(appendReview)
        }
        
        reviewSheetManager.reviewSheetArray.append(appendReviewSheet)
    }
    
    
    
    //---------------tableViewSetting-----------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewSheatTableViewCell") as! ReviewSheatTableViewCell
        cell.customDelegate = self
        
        cell.reviewTextLabel.text = reviewSheet.reviewArray[indexPath.row].reviewText
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewSheet.reviewArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
}
