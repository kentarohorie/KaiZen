//
//  ShowReviewViewController.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/01/14.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol ShowReviewViewControllerDelegate {
    optional func viewDidLoad(callback: () -> Void)
}

class ShowReviewViewController: UIViewController {
    
    var reviewSheatView: ReviewSheatView!
    let reviewSheatViewModel: ReviewSheatViewModel = ReviewSheatViewModel()
    weak var customDelegate: ShowReviewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customDelegate = reviewSheatViewModel
        customDelegate?.viewDidLoad!({ () -> Void in
            self.reviewSheatViewSetUP()

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reviewSheatViewSetUP() {
        reviewSheatView = UINib(nibName: "ReviewSheatView", bundle: nil).instantiateWithOwner(self, options: nil).first as! ReviewSheatView
        
        reviewSheatView.tableView.dataSource = reviewSheatViewModel
        reviewSheatView.customDelegate = reviewSheatViewModel
        reviewSheatView.tableView.delegate = reviewSheatViewModel
        reviewSheatViewModel.customDelegate = reviewSheatView
//        reviewSheatView.sideMenuView?.customDelegate = reviewSheatViewModel
        
        self.view = reviewSheatView
    }
    
}
