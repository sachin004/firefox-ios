//
//  SyncedTabsViewController.swift
//  Client
//
//  Created by sachin irukula on 5/7/15.
//  Copyright (c) 2015 Mozilla. All rights reserved.
//

import UIKit

private let RemoteTabIdentifier = "RemoteTab"

class SyncedTabsViewController: UITableViewController {
    
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(TwoLineHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: RemoteTabIdentifier)
        
        tableView.rowHeight = RemoteTabsPanelUX.RowHeight
        tableView.separatorInset = UIEdgeInsetsZero
        
        view.backgroundColor = AppConstants.PanelBackgroundColor
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: RemoteTabIdentifier)
            let cell = tableView.dequeueReusableCellWithIdentifier(RemoteTabIdentifier, forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel!.text = "Cell item \(indexPath.row)"
            return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return RemoteTabsPanelUX.HeaderHeight
    }

}
