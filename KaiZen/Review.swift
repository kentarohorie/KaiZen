//
//  Review.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/01/14.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class Review {
    var reviewText: String?
    var reviewPoint: Int?
    
    func set(reviewText: String, reviewPoint: Int) {
        self.reviewText = reviewText
        self.reviewPoint = reviewPoint
    }
}
