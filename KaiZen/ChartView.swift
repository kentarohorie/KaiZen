//
//  ChartView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/10.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ChartView: UIView {
    
    @IBOutlet weak var baseView: UIView!
    var graphView: BEMSimpleLineGraphView!
    
    override func awakeFromNib() {
        
        setUP()
        
        
    }
    
    func setUP() {
        baseView.frame = UIScreen.mainScreen().bounds
        setGraphView()
        setTitleView()
        setYView()
    }
    
    func setGraphView() {
        graphView = BEMSimpleLineGraphView()
        graphView.frame.size = CGSize(width: baseView.frame.width / 13 * 12, height: baseView.frame.height / 7 * 6)
        graphView.frame.origin = CGPoint(x: baseView.frame.width / 13, y: baseView.frame.height / 7)
        graphView.colorBottom = UIColor(red: 64/255, green: 133/255, blue: 174/255, alpha: 1)
        graphView.colorTop = UIColor(red: 64/255, green: 133/255, blue: 174/255, alpha: 1)
        graphView.autoScaleYAxis = true
        graphView.enableXAxisLabel = true
        graphView.enableReferenceYAxisLines = true ////
        graphView.colorXaxisLabel = UIColor.whiteColor()
        graphView.colorYaxisLabel = UIColor.whiteColor()
        graphView.enableBezierCurve = true
        graphView.animationGraphEntranceTime = 3
        graphView.alwaysDisplayDots = true
        graphView.widthLine = 3
        graphView.labelFont = UIFont(name: "Futura-Medium", size: 13)
        self.bringSubviewToFront(graphView)
        
        baseView.addSubview(graphView)
    }
    
    func setTitleView() {
        let label = UILabel()
        label.frame.size = CGSize(width: baseView.frame.width, height: baseView.frame.height / 7 - 4)
        label.frame.origin = CGPointZero
        label.backgroundColor = graphView.colorBottom
        label.text = "Improve"
        label.font = UIFont(name: "Futura-Medium", size: 30)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        
        baseView.addSubview(label)
    }
    
    func setYView() {
        let view = UIView()
        view.frame.size = CGSize(width: baseView.frame.width / 13, height: baseView.frame.height / 7 * 6)
        view.frame.origin = CGPoint(x: 0, y: baseView.frame.height / 7)
        view.backgroundColor = graphView.colorBottom
        baseView.addSubview(view)
        
        view.addSubview(setYLabel("(%)", y: 0))
        view.addSubview(setYLabel("100", y: view.frame.height / 19))
        view.addSubview(setYLabel("50", y: view.frame.height / 100 * 46))
        view.addSubview(setYLabel("0", y: view.frame.height / 100 * 88))
    }
    
    func setYLabel(text: String, y: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame.size = CGSize(width: baseView.frame.width / 13, height: 30)
        label.bounds.origin.x = baseView.frame.width / 13
        label.frame.origin.y = y
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Futura-Medium", size: 13)
        label.textAlignment = NSTextAlignment.Center
        return label

    }
    
}
