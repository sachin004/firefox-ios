//
//  SyncedTabsViewController.swift
//  Client
//
//  Created by sachin irukula on 5/7/15.
//  Copyright (c) 2015 Mozilla. All rights reserved.
//

import UIKit

class SyncedTabsViewController: UIViewController {
    
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selectionText: String
        if selectedIndex >= 0 {
            selectionText = "Selected item \(selectedIndex)"
        } else {
            selectionText = "Nothing selected!"
        }
        
        if splitViewController?.respondsToSelector("displayModeButtonItem") == true {
            navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            navigationItem.leftItemsSupplementBackButton = true
        }
    }
}
