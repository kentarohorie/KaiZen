//
//  AddReviewView.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/10.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

@objc protocol AddReviewViewDelegate {
    optional func tapAddOfAddView(text: String)
}

class AddReviewView: UIView, UITextFieldDelegate {

    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    weak var customDelegate: AddReviewViewDelegate?
 
    override func awakeFromNib() {
        setUP()
    }
    
    //----- set view --------
    
    func setUP() {
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 0.8
        self.layer.cornerRadius = self.frame.width / 40
        self.layer.shadowOffset = CGSize(width: 3, height: -3)
        self.layer.shadowOpacity = 0.5
        
        addReviewButton.layer.cornerRadius = addReviewButton.frame.width / 40
        
        textField.delegate = self
    }
    
    // ---- method ----
    
    func closeAnimation() {
        (self.superview as? ReviewSheatView)?.isDisplayAddView = false
        (self.superview as? SideMenuView)?.isDisplayAddView = false
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.center.y = -(self.frame.height)
            }) { (bool) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //----- receive event ------------

    @IBAction func tapAdd(sender: UIButton) {
        guard textField.text! != "" else {
            setAlert("Missing", title: "テキストを入力してください")
            return
        }

        self.customDelegate?.tapAddOfAddView!(textField.text!)
        closeAnimation()
        textField.resignFirstResponder()
    }
    
    @IBAction func tapClose(sender: UIButton) {
        closeAnimation()
        textField.resignFirstResponder()
    }
    
    
    // --------- send event ------------
    

    
}
