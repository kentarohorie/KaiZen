//
//  ShowChartViewController.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/08.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ShowChartViewController: UIViewController {
    
    var chartView: ChartView?
    let chartViewModel = ChartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if !(self.view.subviews.isEmpty) {
            self.view.subviews[0].removeFromSuperview()
        }
        
        guard chartViewModel.isNoData() else {
            setNoDataView()
            return
        }
        
        chartViewSetUP()
        //ここのロジックは収納すべき？できる？
    }
    
    func chartViewSetUP() {
        chartView = UINib(nibName: "ChartView", bundle: nil).instantiateWithOwner(self, options: nil).first as? ChartView
        chartView!.graphView.delegate = chartViewModel
        chartView!.graphView.dataSource = chartViewModel
        
        self.view.addSubview(chartView!)
    }
    
    func setNoDataView() {
        let noGraphDataView = UINib(nibName: "NoGraphDataView", bundle: nil).instantiateWithOwner(self, options: nil).first as? NoGraphDataView
        self.view.addSubview(noGraphDataView!)
    }
    
}
