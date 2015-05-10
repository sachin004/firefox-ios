//
//  ClientsViewController.swift
//  Client
//
//  Created by sachin irukula on 5/7/15.
//  Copyright (c) 2015 Mozilla. All rights reserved.
//

import UIKit
import Account
import Shared
import Snap
import Storage
import Sync
import XCGLogger

private let RemoteClientIdentifier = "RemoteClient"

// TODO: same comment as for SyncAuthState.swift!
private let log = XCGLogger.defaultInstance()


class ClientsViewController: UITableViewController {
    var tabsViewController: SyncedTabsViewController!
    var profile: Profile!
    private var clientAndTabs: [ClientAndTabs]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(TwoLineHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: RemoteClientIdentifier)
        
        tableView.rowHeight = RemoteTabsPanelUX.RowHeight
        tableView.separatorInset = UIEdgeInsetsZero
        
        view.backgroundColor = AppConstants.PanelBackgroundColor
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "SELrefresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.SELrefresh()
    }
    
    @objc private func SELrefresh() {
        self.refreshControl?.beginRefreshing()
        
        self.profile.getClientsAndTabs().upon({ tabs in
            if let tabs = tabs.successValue {
                log.info("\(tabs.count) tabs fetched.")
                self.clientAndTabs = tabs
                
                // Maybe show a background view.
                let tableView = self.tableView
                if tabs.isEmpty {
                    // TODO: Bug 1144760 - Populate background view with UX-approved content.
                    tableView.backgroundView = UIView()
                    tableView.backgroundView?.frame = tableView.frame
                    tableView.backgroundView?.backgroundColor = UIColor.redColor()
                    
                    // Hide dividing lines.
                    tableView.separatorStyle = UITableViewCellSeparatorStyle.None
                } else {
                    tableView.backgroundView = nil
                    // Show dividing lines.
                    tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                }
                tableView.reloadData()
            } else {
                log.error("Failed to fetch tabs.")
            }
            
            // Always end refreshing, even if we failed!
            self.refreshControl?.endRefreshing()
        })
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.clientAndTabs?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        if let clientTabs = self.clientAndTabs?[indexPath.item] {
            let client = clientTabs.client
            let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(RemoteClientIdentifier) as! TwoLineHeaderFooterView
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: RemoteTabsPanelUX.HeaderHeight)
            view.textLabel.text = client.name
            view.contentView.backgroundColor = RemoteTabsPanelUX.HeaderBackgroundColor
            
            // TODO: Bug 1154088 - Convert timestamp to locale-relative timestring.
            
            /*
            * A note on timestamps.
            * We have access to two timestamps here: the timestamp of the remote client record,
            * and the set of timestamps of the client's tabs.
            * Neither is "last synced". The client record timestamp changes whenever the remote
            * client uploads its record (i.e., infrequently), but also whenever another device
            * sends a command to that client -- which can be much later than when that client
            * last synced.
            * The client's tabs haven't necessarily changed, but it can still have synced.
            * Ideally, we should save and use the modified time of the tabs record itself.
            * This will be the real time that the other client uploaded tabs.
            */
            let timestamp = clientTabs.approximateLastSyncTime()
            let label = NSLocalizedString("Last synced: %@", comment: "Remote tabs last synced time")
            view.detailTextLabel.text = String(format: label, String(timestamp))
            let image: UIImage?
            if client.type == "desktop" {
                image = UIImage(named: "deviceTypeDesktop")
                image?.accessibilityLabel = NSLocalizedString("computer", comment: "Accessibility label for Desktop Computer (PC) image in remote tabs list")
            } else {
                image = UIImage(named: "deviceTypeMobile")
                image?.accessibilityLabel = NSLocalizedString("mobile device", comment: "Accessibility label for Mobile Device image in remote tabs list")
            }
            view.imageView.image = image
            view.mergeAccessibilityLabels()
        }
        cell.addSubview(view)
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return RemoteTabsPanelUX.HeaderHeight
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


