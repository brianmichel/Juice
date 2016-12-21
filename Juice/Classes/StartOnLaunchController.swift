//
//  StartOnLaunchController.swift
//  Juice
//
//  Created by Brian Michel on 12/20/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation
import ServiceManagement

final class StartOnLaunchController {
    let bundleIdentifier: String
    
    private(set) var startsOnLaunch: Bool = false
    
    private var bundleIdentifierStartsOnLaunchKey: String {
        return "\(bundleIdentifier)-startsOnLaunch"
    }
    
    init(bundleIdentifier: String) {
        self.bundleIdentifier = bundleIdentifier
        startsOnLaunch = getStartsOnLaunchFromDisk() ?? false
    }
    
    func toggle(startOnLaunch start: Bool) -> Bool {
        let success = SMLoginItemSetEnabled(self.bundleIdentifier as CFString, start)
        
        if success {
            set(startsOnLaunch: start)
        }
        
        return success
    }
    
    private func set(startsOnLaunch starts: Bool) {
        startsOnLaunch = starts
        UserDefaults.standard.set(startsOnLaunch, forKey: bundleIdentifierStartsOnLaunchKey)
    }
    
    private func getStartsOnLaunchFromDisk() -> Bool? {
        return UserDefaults.standard.bool(forKey: bundleIdentifierStartsOnLaunchKey)
    }
}
