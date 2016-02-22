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
        
        textField.delegate = self
    }
    
    // ---- method ----
    
    func closeAnimation() {
        (self.superview as? ReviewSheatView)?.isDisplayAddView = false
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.center.y = -(self.frame.height)
            }) { (bool) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func setAlert() {
        let alertController = UIAlertController(title: "Missing!", message: "テキストを入力してください。", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        
        
        var baseView = UIApplication.sharedApplication().keyWindow?.rootViewController
        while ((baseView?.presentedViewController) != nil)  {
            baseView = baseView?.presentedViewController
        }
        
        baseView?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //----- receive event ------------

    @IBAction func tapAdd(sender: UIButton) {
        guard textField.text! != "" else {
            setAlert()
            return
        }

        self.customDelegate?.tapAddOfAddView!(textField.text!)
        closeAnimation()
        textField.resignFirstResponder()
    }
    
    @IBAction func tapClose(sender: UIButton) {
        closeAnimation()
    }
    
    
    // --------- send event ------------
    

    
}
