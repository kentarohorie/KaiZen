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
        let saveReviewSheetArray = convertSheetArrayForSave()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(saveReviewSheetArray, forKey: "reviewSheetArray")
        
        if let currentSheet = sharedInstance.currentReviewSheet {
            let saveCurrentReviewSheet = convertSheetToDic(currentSheet)
            defaults.setObject(saveCurrentReviewSheet, forKey: "currentReviewSheet")
        }
    }
    
    class func fetchFromDevise(callback: () -> Void ) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        guard let fetchReviewSheetArray = defaults.objectForKey("reviewSheetArray") as? [[String: AnyObject]] else {
            print("fetch error")
            callback()
            return
        }
        
        convertForFetch(fetchReviewSheetArray)
        
        if let fetchCurrentReviewSheet = defaults.objectForKey("currentReviewSheet") as? [String: AnyObject] {
            sharedInstance.currentReviewSheet = convertDicToSheet(fetchCurrentReviewSheet)
        }
        
        callback()
    }
    
    //-------------------- convertData --------------
    
    class func convertSheetArrayForSave() -> [[String: AnyObject]] {
        var saveReviewSheetDicArray: [[String: AnyObject]] = []

        for reviewSheet in sharedInstance.reviewSheetArray {
            saveReviewSheetDicArray.append(convertSheetToDic(reviewSheet))
        }

        return saveReviewSheetDicArray
    }
    
    class func convertSheetToDic(reviewSheet: ReviewSheet) -> [String: AnyObject] {
        var sheetDic: Dictionary<String, AnyObject> = [:]
        
        sheetDic["title"] = reviewSheet.title
        sheetDic["pointRatioArray"] = reviewSheet.pointRatioArray
        sheetDic["reviewTextArray"] = reviewSheet.getReviewTextArray()
        
        return sheetDic
    }
    
    class func convertForFetch(fetchData: [[String: AnyObject]]) {
        for dic in fetchData {
            sharedInstance.reviewSheetArray.append(convertDicToSheet(dic))
        }
    }
    
    class func convertDicToSheet(sheetDic: [String: AnyObject]) -> ReviewSheet {
        let reviewSheet = ReviewSheet()
        reviewSheet.title = sheetDic["title"] as? String
        reviewSheet.pointRatioArray = (sheetDic["pointRatioArray"] as? [Float])!
        
        guard let reviewTextArray = sheetDic["reviewTextArray"] as? [String] else {
            print("no review")
            return reviewSheet
        }
        
        reviewSheet.setReviewText(reviewTextArray)
        return reviewSheet
    }
}
