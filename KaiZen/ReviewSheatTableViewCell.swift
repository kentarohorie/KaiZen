//
//  ReviewSheatTableViewCell.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/09.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

protocol ReviewSheatTableViewCellDelegate {
    func changeSegConValue(sender: UISegmentedControl)
}

class ReviewSheatTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    var customDelegate: ReviewSheatTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUP()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //------ set view -------------
    
    func setUP() {
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        self.selectionStyle = .None
        
        gradeSegmentedControl.addTarget(self, action: "changeSegConValue:", forControlEvents: .ValueChanged)
    }
    
    //-------- event ----------
    
    func changeSegConValue(sender: UISegmentedControl) {
        customDelegate?.changeSegConValue(sender)
    }
    
}
