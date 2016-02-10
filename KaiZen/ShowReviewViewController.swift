//
//  ShowReviewViewController.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/01/14.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ShowReviewViewController: UIViewController {
    
    var reviewSheatView: ReviewSheatView!
    let reviewSheatViewModel: ReviewSheatViewModel = ReviewSheatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewSheatViewSetUP()
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
        
        self.view = reviewSheatView
    }
    
}
