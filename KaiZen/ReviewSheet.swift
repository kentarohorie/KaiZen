//
//  File.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/01/14.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class ReviewSheet {
    var title: String?
    var reviewArray: [Review] = []
    var pointRatioArray: [Float] = []
    
    func appendPointRatio(reviewArray: [Review]) {
        var reviewPointSum = 0
        for review in reviewArray {
            reviewPointSum += review.reviewPoint!
        }
        
        let ratio = Float(reviewPointSum) / Float(reviewArray.count * 2)
        pointRatioArray.append(ratio)
    }
    
}
