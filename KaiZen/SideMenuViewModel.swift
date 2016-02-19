//
//  SideMenuViewModel.swift
//  KaiZen
//
//  Created by 堀江健太朗 on 2016/02/19.
//  Copyright © 2016年 kentaro. All rights reserved.
//

import UIKit

class SideMenuViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //------------- tableview setting -------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sideMenuCell") as! SideMenuTableViewCell
        
        return cell
    }
}
