//
//  ReviewSheetManager.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/01/14.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ReviewSheetManager {
    static let sharedInstance = ReviewSheetManager()
    var reviewSheetArray: [ReviewSheet] = []
        var goal: [String: Int] = [:]
    
    func sumReviewPoint(reviewSheet: ReviewSheet) -> Int {
        var sumPoint = 0
        for i in reviewSheet.reviewArray {
            sumPoint += i.reviewPoint!
        }
        
        return sumPoint
    }
}
