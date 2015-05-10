/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import Account

public struct RemoteTabsPanelUX {
    static let HeaderHeight: CGFloat = SiteTableViewControllerUX.RowHeight // Not HeaderHeight!
    static let RowHeight: CGFloat = SiteTableViewControllerUX.RowHeight
    static let HeaderBackgroundColor = UIColor(rgb: 0xf8f8f8)
}

/**
 * Display a tree hierarchy of remote clients and tabs, like:
 * client
 *   tab
 *   tab
 * client
 *   tab
 *   tab
 * This is not a SiteTableViewController because it is inherently tree-like and not list-like;
 * a technical detail is that STVC is backed by a Cursor and this is backed by a richer data
 * structure.  However, the styling here should agree with STVC where possible.
 */
class RemoteTabsPanel: UIViewController, HomePanel {
    weak var homePanelDelegate: HomePanelDelegate? = nil
    var profile: Profile!
    private var splitView = RemoteTabsPanelViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitView.clients = ClientsViewController()
        splitView.clients.profile = profile
        splitView.syncedTabs = SyncedTabsViewController()
        view.addSubview(splitView.view)
    }
}
