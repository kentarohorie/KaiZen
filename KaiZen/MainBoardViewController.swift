//
//  MainBoardViewController.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/08.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class MainBoardViewController: UIViewController, UIScrollViewDelegate {
    
    let generalViewModel: GeneralViewModel = GeneralViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewControllerSetting()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //---------------pageviewcontroller---------------------

    func pageViewControllerSetting() {
        let pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController.dataSource = generalViewModel
        pageViewController.delegate = generalViewModel
        
        let startingViewController = ShowReviewViewController()
        let viewControllers = [startingViewController]
        pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        pageViewController.view.frame = self.view.frame
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view!)
        pageViewController.didMoveToParentViewController(self)
        
        for i in pageViewController.view.subviews {
            if i.isKindOfClass(UIScrollView) {
                (i as! UIScrollView).delegate = generalViewModel
            }
        }
    }
    

}
