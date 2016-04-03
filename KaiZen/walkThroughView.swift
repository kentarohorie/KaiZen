//
//  walkThroughView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/04/03.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class walkThroughView: UIView, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    let imageContentArray = ["WT1.png", "WT2.png", "WT3.png", "WT4.png", "launch_screen"]
    
    override func awakeFromNib() {
        setUP()
    }
    
    func setUP() {
        scrollView.delegate = self
        scrollViewSetting()
        
        self.bringSubviewToFront(pageControl)
    }
    
    func scrollViewSetting() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(imageContentArray.count), height: 0)
        
        for i in 0..<imageContentArray.count {
            let imageView = UIImageView()
            imageView.frame.size = self.frame.size
            imageView.frame.origin = CGPoint(x: self.frame.width * CGFloat(i), y: 0)
            imageView.image = UIImage(named: imageContentArray[i])
            scrollView.addSubview(imageView)
        }
        
        makeButton()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
    
    func makeButton() {
        let button = UIButton()
        button.setTitle("START", forState: .Normal)
        button.titleLabel!.font = UIFont.systemFontOfSize(80)
        button.sizeToFit()
        button.center = CGPoint(x: self.frame.width * CGFloat(imageContentArray.count - 1) + (self.frame.width / 2), y: self.frame.height / 2 + 80)
        button.layer.shadowOffset = CGSize(width: 1, height: -1)
        button.layer.shadowOpacity = 0.6
        
        button.addTarget(self, action: "tapStart", forControlEvents: .TouchUpInside)
        scrollView.addSubview(button)
        
    }
    
    func tapStart() {
        self.removeFromSuperview()
    }

    @IBAction func changePageControlValue(sender: UIPageControl) {
        scrollView.contentOffset = CGPoint(x: self.frame.width * CGFloat(sender.currentPage), y: 0)
    }
    
}
