//
//  MainBoardViewController.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/08.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class MainBoardViewController: UIViewController, UIPageViewControllerDataSource {

    var isFirst: Bool = true

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
        pageViewController.dataSource = self
        
        let startingViewController = ShowReviewViewController()
        let viewControllers = [startingViewController]
        pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        pageViewController.view.frame = self.view.frame
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view!)
        pageViewController.didMoveToParentViewController(self)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let className = NSStringFromClass(viewController.dynamicType).componentsSeparatedByString(".").last!
        if className == "ShowChartViewController" {
            let showReviewController = ShowReviewViewController()
            return showReviewController
        } else if className == "ShowReviewViewController" {
            return nil
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let className = NSStringFromClass(viewController.dynamicType).componentsSeparatedByString(".").last!
        
        if className == "ShowReviewViewController" {
            let showChartViewController = ShowChartViewController()

            return showChartViewController
        } else if className == "ShowChartViewController" {
            return nil
        } else {
            return nil
        }
    }

}
