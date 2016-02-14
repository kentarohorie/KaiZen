//
//  ChartViewModel.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/10.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ChartViewModel: NSObject, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource {
    
    let reviewSheetManager: ReviewSheetManager = ReviewSheetManager.sharedInstance

    // dataが２個以上じゃないとview事態が崩れる
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> NSInteger {

        return reviewSheetManager.reviewSheetArray.count + 1
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: NSInteger) -> CGFloat {
        if index == 0 {
            return 0
        } else {
            return CGFloat(reviewSheetManager.sumReviewPoint(reviewSheetManager.reviewSheetArray[index - 1]))
        }
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String! {
        return Optional("\(index) 反省目")
    }
    
}
