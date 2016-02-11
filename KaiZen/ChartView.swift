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
        
        self.addSubview(graphView)
    }
    
}
