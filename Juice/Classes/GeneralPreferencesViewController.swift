//
//  GeneralPreferencesViewController.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Cocoa

class GeneralPreferencesViewController: NSViewController {
    private let preferences = PreferencesStorage.shared
    
    @IBOutlet weak var statusBarStylePopUp: NSPopUpButton!
    
    override var nibName: String? {
        return "GeneralPreferencesViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStylePopUp.target = self
        statusBarStylePopUp.action = #selector(statusBarStyleChanged)
        
        preferences.scales.forEach({ statusBarStylePopUp.addItem(withTitle: $0.title) })
    }
    
    @objc private func statusBarStyleChanged() {
        let selectedScale = preferences.scales[statusBarStylePopUp.indexOfSelectedItem]
        preferences.set(chargeDisplayScale: selectedScale)
    }
}
