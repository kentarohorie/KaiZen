//
//  ShowChartViewController.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/08.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ShowChartViewController: UIViewController {
    
    var chartView: ChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartViewSetUP()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func chartViewSetUP() {
        chartView = UINib(nibName: "ChartView", bundle: nil).instantiateWithOwner(self, options: nil).first as! ChartView
        
        self.view = chartView
    }
    
}
