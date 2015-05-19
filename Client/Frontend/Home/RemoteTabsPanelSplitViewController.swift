//
//  RemoteTabsPanelViewController.swift
//  Client
//
//  Created by sachin irukula on 5/9/15.
//  Copyright (c) 2015 Mozilla. All rights reserved.
//

import UIKit

class RemoteTabsPanelSplitViewController: UISplitViewController {
    
    var clients: ClientsViewController!
    var syncedTabs: SyncedTabsViewController!
    override func viewDidLoad() {
        clients.delegate = syncedTabs
        super.viewDidLoad()
    }

    func refreshView()
    {
        clients.refreshView()
    }
}