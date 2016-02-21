//
//  ChartView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/10.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ChartView: UIView {
    
    var graphView: BEMSimpleLineGraphView!
    
    override func awakeFromNib() {
        
        setUP()
        
        let label = UILabel()
        label.frame.size = CGSize(width: self.frame.width / 13, height: self.frame.height / 7 * 6)
        label.frame.origin = CGPoint(x: 0, y: self.frame.height / 7)
        label.backgroundColor = graphView.colorBottom
        label.text = "改善具合"
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 4
        self.addSubview(label)
    }
    
    func setUP() {
        setGraphView()
        setTitleView()
    }
    
    func setGraphView() {
        graphView = BEMSimpleLineGraphView()
        graphView.frame.size = CGSize(width: self.frame.width / 13 * 12, height: self.frame.height / 7 * 6)
        graphView.frame.origin = CGPoint(x: self.frame.width / 13, y: self.frame.height / 7)
        
//        graphView.enableReferenceAxisFrame = true
        graphView.enableReferenceXAxisLines = true
        graphView.enableXAxisLabel = true
        graphView.enableReferenceYAxisLines = true ////
//        graphView.enableYAxisLabel = true ////
        graphView.colorXaxisLabel = UIColor.whiteColor()
        graphView.colorYaxisLabel = UIColor.whiteColor()
        graphView.enableBezierCurve = true
        graphView.autoScaleYAxis = true
        graphView.animationGraphEntranceTime = 3
        
        self.addSubview(graphView)
    }
    
    func setTitleView() {
        let label = UILabel()
        label.frame.size = CGSize(width: self.frame.width, height: self.frame.height / 7 - 4)
        label.frame.origin = CGPointZero
        label.backgroundColor = graphView.colorBottom
        label.text = "改善曲線"
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        
        self.addSubview(label)
    }
    
}
