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
    var currentReviewSheet: ReviewSheet?
//    var goal: [String: Int] = [:]
    

    
    //------------- save & fetch Devise --------------------
    
    class func saveForDevise() {
        let saveReviewSheetArray = convertForSave()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(saveReviewSheetArray, forKey: "reviewSheetArray")
    }
    
    class func fetchFromDevise(callback: () -> Void ) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        guard let fetchReviewSheetArray = defaults.objectForKey("reviewSheetArray") as? Array<Array<Dictionary<String, AnyObject>>> else {
            print("fetch error")
            
            callback()
            return
        }
        
        convertForFetch(fetchReviewSheetArray)
        callback()
    }
    
    //-------------------- convertData --------------
    
    class func convertForSave() -> Array<Array<Dictionary<String, AnyObject>>> {
        var saveReviewSheetArray: Array<Array<Dictionary<String, AnyObject>>> = []
        
        for reviewSheet in sharedInstance.reviewSheetArray {
            var reviewDicArray: Array<Dictionary<String, AnyObject>> = []
            
            for review in reviewSheet.reviewArray {
                var dic: Dictionary<String, AnyObject> = [:]
                
                dic["reviewText"] = review.reviewText
                dic["reviewPoint"] = review.reviewPoint
                
                reviewDicArray.append(dic)
            }
            
            saveReviewSheetArray.append(reviewDicArray)
        }
        
        return saveReviewSheetArray
    }
    
    class func convertForFetch(fetchData: Array<Array<Dictionary<String, AnyObject>>>) {
        for dicArray in fetchData {
            let reviewSheet = ReviewSheet()
            
            for dic in dicArray {
                let review = Review()
                
                review.reviewText = dic["reviewText"] as? String
                review.reviewPoint = dic["reviewPoint"] as? Int
                
                reviewSheet.reviewArray.append(review)
            }
            
            sharedInstance.reviewSheetArray.append(reviewSheet)
        }
    }
}
