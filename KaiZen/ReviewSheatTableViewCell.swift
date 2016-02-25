//
//  ReviewSheatTableViewCell.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/09.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol ReviewSheatTableViewCellDelegate {
    func changeSegConValue(sender: UISegmentedControl)
}

class ReviewSheatTableViewCell: UITableViewCell {

    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    weak var customDelegate: ReviewSheatTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUP()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // ------ set view -------------
    
    func setUP() {
        self.selectionStyle = .None
        coverView.layer.cornerRadius = self.frame.width / 30
        self.layer.shadowOffset = CGSize(width: 1, height: -1)
        self.layer.shadowOpacity = 0.2
        
        gradeSegmentedControl.addTarget(self, action: "changeSegConValue:", forControlEvents: .ValueChanged)
    }
    
    // -------- receive event ----------
    
    func changeSegConValue(sender: UISegmentedControl) {
        customDelegate?.changeSegConValue(sender)
    }
    
}
