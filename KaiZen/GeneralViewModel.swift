//
//  GeneralViewModel.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/11.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class GeneralViewModel: NSObject, UIPageViewControllerDataSource {
        
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
