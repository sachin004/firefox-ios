//
//  ClientsViewController.swift
//  Client
//
//  Created by sachin irukula on 5/7/15.
//  Copyright (c) 2015 Mozilla. All rights reserved.
//

import UIKit

class ClientsViewController: UITableViewController {
    let CellIdentifier = "CellIdentifier"
    let DetailSegueIdentifier = "DetailSegueIdentifier"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailSegueIdentifier {
            var dest: SyncedTabsViewController
            if let nav = segue.destinationViewController as? UINavigationController {
                dest = nav.topViewController as! SyncedTabsViewController
            } else {
                dest = segue.destinationViewController as! SyncedTabsViewController
            }
            
            if let path = tableView.indexPathForSelectedRow() {
                dest.selectedIndex = path.row
            }
        }
    }
    
    //MARK: UITableViewDataSource
    
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


