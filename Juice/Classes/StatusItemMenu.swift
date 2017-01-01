//
//  StatusItemMenu.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import AppKit

protocol StatusMenuItemDelegate: class {
    func status(didClickPreferences menuItem: StatusMenuItem)
}

final class StatusMenuItem: NSMenu {
    private let percentageItem = NSMenuItem()
    private let sourceTypeItem = NSMenuItem()
    
    weak var statusMenuItemDelegate: StatusMenuItemDelegate?
    
    override init(title: String) {
        super.init(title: title)
        
        percentageItem.toolTip = NSLocalizedString("Indicates the current battery charge percentage", comment:"Indicates the current battery charge percentage")
        
        addItem(percentageItem)
        addItem(sourceTypeItem)
        addItem(NSMenuItem.separator())
        addItem(withTitle: NSLocalizedString("Preferences", comment:"Preferences"), action: #selector(preferencesClicked), keyEquivalent: "").target = self
        addItem(NSMenuItem.separator())
        addItem(withTitle: NSLocalizedString("Quit Juice", comment:"Quit juice"), action: #selector(quitClicked), keyEquivalent: "q").target = self
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) " + NSLocalizedString("Quit Juice", comment:"Quit juice"))
    }
    
    func update(from source: PowerSource) {
        if source.charging {
            percentageItem.title = "\(source.chargedPercentage)% " + NSLocalizedString("Charged", comment:"Battery charged")
        }
        else {
            percentageItem.title = "\(source.chargedPercentage)% " + NSLocalizedString("Remaining", comment:"Battery Remaining")
        }
        sourceTypeItem.title = NSLocalizedString("Power Source", comment:"Power source")
 + ": \(source.state.displayValue)"
    }
    
    @objc private func preferencesClicked() {
        statusMenuItemDelegate?.status(didClickPreferences: self)
    }
    
    @objc private func quitClicked() {
        NSApp.terminate(self)
    }
}
