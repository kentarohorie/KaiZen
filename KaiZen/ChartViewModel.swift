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
    // グラフのX軸の最大個数を返すメソッドを作成
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> NSInteger {

        return reviewSheetManager.reviewSheetArray.count + 1
    }
    
    // Y軸の値を返すメソッドを作成
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: NSInteger) -> CGFloat {
        //何個目のX軸のポイントかはindexで取得できるので、今回はSampleData配列の中にあるindexの要素をそのまま返します
        if index == 0 {
            return 0
        } else {
            return CGFloat(reviewSheetManager.sumReviewPoint(reviewSheetManager.reviewSheetArray[index - 1]))
        }
    }
    
    // X軸のラベルを返すメソッドを作成
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String! {
        return "\(index) 回目"
    }
    
}
