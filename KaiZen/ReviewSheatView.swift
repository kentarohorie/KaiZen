//
//  ReviewSheatView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/09.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol ReviewSheatViewDelegate {
    optional func tapEdit(callback: () -> Void)
    optional func tapAddReview() -> AddReviewView
    optional func tapDone()
}

class ReviewSheatView: UIView, ReviewSheatViewModelDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var customDelegate: ReviewSheatViewDelegate?
    var addReviewView: AddReviewView?
    
    override func awakeFromNib() {
        
        setUP()
    }
    
    //-------- set view -----------------------------
    
    func setUP() {
        tableViewSetUP()
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
    
    //---------get event ------------------------
    
    @IBAction func tapEdit(sender: UIButton) {
        customDelegate?.tapEdit!({ () -> Void in
            self.tableView.reloadData()
        })
    }
    
    @IBAction func tapAddReview(sender: UIButton) {
        addReviewView = customDelegate?.tapAddReview!()
        addReviewView?.center = CGPoint(x: self.center.x, y: -(addReviewView!.frame.height))
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.addReviewView?.center.y = self.center.y
        }
        
        self.addSubview(addReviewView!)
    }
    
    @IBAction func tapDone(sender: UIButton) {
        customDelegate?.tapDone!()
    }
    
    //----- send event ------------
    
    func changeTableViewDate() {
        tableView.reloadData()
    }
}
