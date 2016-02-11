//
//  ChartViewModel.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/10.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ChartViewModel: NSObject, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource, ReviewSheatViewModelDelegate {
    
    var SampleLabel: Array<String> = ["ラベルA", "ラベルB", "ラベルD", "ラベルE", "ラベルF"]
    // サンプルデータ
    var SampleData:  Array<Float> = [10.5, 20.8, 5.3, 12.1, 25.9]
    
    override func awakeFromNib() {
        
    }
    
    // グラフのX軸の最大個数を返すメソッドを作成
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> NSInteger {
        return SampleData.count
    }
    
    // Y軸の値を返すメソッドを作成
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: NSInteger) -> CGFloat {
        //何個目のX軸のポイントかはindexで取得できるので、今回はSampleData配列の中にあるindexの要素をそのまま返します
        return CGFloat(SampleData[index])
    }
    
    // X軸のラベルを返すメソッドを作成
    
//    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
//        return SampleLabel[index]
//    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        return SampleLabel[index]
    }
    
    //------- send event ------
    func changeTableViewDate() {
        
    }

    
}
