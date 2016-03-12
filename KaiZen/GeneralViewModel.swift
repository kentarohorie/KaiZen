//
//  GeneralViewModel.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/11.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class GeneralViewModel: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    
    //--------- scroll setting --------------
    
    var isSecond = false
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }
        if NSStringFromClass(previousViewControllers[0].dynamicType).componentsSeparatedByString(".").last! == "ShowChartViewController" {
                isSecond = false

        } else {
                isSecond = true
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let panTranslation = scrollView.panGestureRecognizer.translationInView(scrollView.superview).x
        
        if scrollView.panGestureRecognizer.numberOfTouches() >= 2 {
            scrollView.scrollEnabled = false
        } else {
            scrollView.scrollEnabled = true
        }
        
        if panTranslation > 0 && scrollView.contentOffset.x <= scrollView.frame.width + 25 && !(isSecond) {
            scrollView.contentOffset.x = scrollView.frame.width
        } else if panTranslation < 0 && scrollView.contentOffset.x >= scrollView.frame.width - 25 && isSecond {
            scrollView.contentOffset.x = scrollView.frame.width
        }
    }
    
    //--------- pageviewcontroller data --------------
    
    
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
