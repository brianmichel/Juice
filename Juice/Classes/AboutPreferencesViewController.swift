//
//  AboutPreferencesViewController.swift
//  Juice
//
//  Created by Brian Michel on 12/18/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Cocoa

class AboutPreferencesViewController: NSViewController {
    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet weak var buildLabel: NSTextField!
    
    override var nibName: String? {
        return "AboutPreferencesViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle.main
        guard let version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String,
            let build = bundle.infoDictionary?["CFBundleVersion"] as? String else {
            versionLabel.stringValue = "Unknown Version"
            buildLabel.stringValue = "Unknown Build"
            return
        }
        
        versionLabel.stringValue = "Version \(version)"
        buildLabel.stringValue = "Build \(build)"
    }
}
