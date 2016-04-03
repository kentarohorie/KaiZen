//
//  NoGraphDataView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/14.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class NoGraphDataView: UIView {

    @IBOutlet weak var noDataLabel: UILabel!
    
    override func awakeFromNib() {
        self.frame = UIScreen.mainScreen().bounds
        noDataLabel.adjustsFontSizeToFitWidth = true
    }

}
