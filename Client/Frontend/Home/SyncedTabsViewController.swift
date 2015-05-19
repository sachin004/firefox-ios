import UIKit
import Storage

private let RemoteTabIdentifier = "RemoteTab"

class SyncedTabsViewController: UITableViewController, ClientSelectedDelegate, HomePanel {
    
    weak var homePanelDelegate: HomePanelDelegate? = nil
    var tabs: [RemoteTab]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = RemoteTabsPanelUX.RowHeight
        tableView.separatorInset = UIEdgeInsetsZero
        //view.backgroundColor = AppConstants.PanelBackgroundColor
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.tabs!.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            tableView.registerClass(TwoLineTableViewCell.self, forCellReuseIdentifier: RemoteTabIdentifier)
            let cell = tableView.dequeueReusableCellWithIdentifier(RemoteTabIdentifier, forIndexPath: indexPath) as! TwoLineTableViewCell
            let tab = tabs?[indexPath.item]
            cell.setLines(tab!.title, detailText: tab!.URL.absoluteString)
            // TODO: Bug 1144765 - Populate image with cached favicons.
            return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return RemoteTabsPanelUX.HeaderHeight
    }
    
    func reloadView() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        if let tab = tabs?[indexPath.item] {
            homePanelDelegate?.homePanel(self, didSelectURL: tab.URL)
        }
    }
}