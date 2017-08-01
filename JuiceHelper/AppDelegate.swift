//
//  AppDelegate.swift
//  JuiceHelper
//
//  Created by Brian Michel on 12/20/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard NSWorkspace.shared().runningApplications.filter({ $0.bundleIdentifier == "com.bsm.macos.Juice" }).count == 0 else {
            return
        }
        
        NSWorkspace.shared().launchApplication(withBundleIdentifier: "com.bsm.macos.Juice",
                                               options: .async,
                                               additionalEventParamDescriptor: nil,
                                               launchIdentifier: nil)
    }
}

