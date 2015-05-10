//
//  SyncedTabsViewController.swift
//  Client
//
//  Created by sachin irukula on 5/7/15.
//  Copyright (c) 2015 Mozilla. All rights reserved.
//

import UIKit

class SyncedTabsViewController: UITableViewController {
    
    var selectedIndex = -1
    let CellIdentifier = "CellIdentifier"
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel!.text = "Cell item \(indexPath.row)"
            return cell
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

}
