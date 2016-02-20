//
//  SideMenuTableViewCell.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/19.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isSelectView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selfSetting()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func selfSetting() {
        self.backgroundColor = UIColor.clearColor()
    }
    
}
