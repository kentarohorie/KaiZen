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
        graphView = BEMSimpleLineGraphView(frame: self.frame)
        
        graphView.enableReferenceAxisFrame = true
        graphView.enableReferenceXAxisLines = true
        graphView.enableXAxisLabel = true
        graphView.enableBezierCurve = true
        graphView.autoScaleYAxis = true
        graphView.animationGraphEntranceTime = 3
        
        self.addSubview(graphView)
    }
    
//    func xAxisLabelWithText(text: String, index: Int) -> UILabel
//    
//    [4:42]
//    let center = CGPointMake(positionOnXAxis, self.frame.size.height - lRect.size.height + 5)
    
}
