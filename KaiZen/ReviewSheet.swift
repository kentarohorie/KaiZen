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
    
    func appendPointRatio(reviewAry: [Review]) {
        var reviewPointSum = 0
        for review in reviewAry {
            reviewPointSum += review.reviewPoint
            print("==\(review.reviewPoint)==")
        }
        
        let ratio = Float(reviewPointSum) / Float(reviewAry.count * 2)
        //
        print(reviewPointSum)
        print(reviewAry.count * 2)
        print(ratio)
        //
        pointRatioArray.append(ratio)
    }
    
    func resetReviewPoint() {
        for review in reviewArray {
            review.reviewPoint = 0
        }
    }
    
    func getReviewTextArray() -> [String] {
        var reviewTextArray: [String] = []
        for review in reviewArray {
            reviewTextArray.append(review.reviewText!)
        }
        return reviewTextArray
    }
    
    func setReviewText(textArray: [String]) {
        for text in textArray {
            let review = Review()
            review.reviewText = text
            reviewArray.append(review)
        }
    }
    
}
