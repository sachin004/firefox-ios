/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import Shared

// TODO: return values?
public protocol Synchronizer {
    init(info: InfoCollections, prefs: Prefs)
    func synchronize()
}

public class ClientsSynchronizer: Synchronizer {
    private let info: InfoCollections
    private let prefs: Prefs

    private let prefix = "clients"
    private let collection = "clients"

    required public init(info: InfoCollections, prefs: Prefs) {
        self.info = info
        self.prefs = prefs
    }

    public func synchronize() {
        if let last = prefs.longForKey(self.prefix + "last") {
            if last == info.modified(self.collection) {
                // Nothing to do.
                return;
            }
        }
    }
}