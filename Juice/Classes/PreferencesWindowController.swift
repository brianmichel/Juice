//
//  PreferencesWindowController.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Cocoa

protocol PreferencesWindowControllerDelegate: class {
    func preferences(windowController: PreferencesWindowController, clickedPreference identifier: String)
}

final class PreferencesWindowController: NSWindowController, NSToolbarDelegate {
    
    enum Identifiers {
        static let General = "Preferences-General"
        static let Credits = "Preferences-Credits"
        static let Tip = "Preferences-Tip"
    }

    @IBOutlet weak var toolbar: NSToolbar!
    
    weak var delegate: PreferencesWindowControllerDelegate?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = Int(CGWindowLevelForKey(.floatingWindow))
    }
    
    func customToolbarItem(itemForItemIdentifier itemIdentifier: String, label: String, paletteLabel: String, toolTip: String, target: AnyObject, itemContent: NSImage?, action: Selector?, menu: NSMenu?) -> NSToolbarItem? {
        
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        
        toolbarItem.label = label
        toolbarItem.paletteLabel = paletteLabel
        toolbarItem.toolTip = toolTip
        toolbarItem.target = target
        toolbarItem.action = action
        toolbarItem.image = itemContent
        
        let menuItem: NSMenuItem = NSMenuItem()
        menuItem.submenu = menu
        menuItem.title = label
        toolbarItem.menuFormRepresentation = menuItem
        
        return toolbarItem
    }
    
    //MARK: - NSToolbarDelegate
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return [Identifiers.General,
                Identifiers.Credits,
                NSToolbarFlexibleSpaceItemIdentifier,
                Identifiers.Tip]
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return [Identifiers.General,
                Identifiers.Credits,
                Identifiers.Tip]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case Identifiers.General:
            return customToolbarItem(itemForItemIdentifier: Identifiers.General,
                                     label: "General",
                                     paletteLabel: "General",
                                     toolTip: "General Settings",
                                     target: self,
                                     itemContent: NSImage(named: "General Icon"),
                                     action: #selector(generalToolbarItemClicked),
                                     menu: nil)
        case Identifiers.Credits:
            return customToolbarItem(itemForItemIdentifier: Identifiers.Credits,
                                     label: "Credits",
                                     paletteLabel: "Credits",
                                     toolTip: "Credits for this app",
                                     target: self,
                                     itemContent: NSImage(named: "Credits Icon"),
                                     action: #selector(creditsToolbarItemClicked),
                                     menu: nil)
        case Identifiers.Tip:
            return customToolbarItem(itemForItemIdentifier: Identifiers.Tip,
                                     label: "Tip",
                                     paletteLabel: "Tip",
                                     toolTip: "Tip the author of this app",
                                     target: self,
                                     itemContent: NSImage(named: "Tip Icon"),
                                     action: #selector(tipToolbarItemClicked),
                                     menu: nil)
        case NSToolbarFlexibleSpaceItemIdentifier:
            return NSToolbarItem(itemIdentifier: NSToolbarFlexibleSpaceItemIdentifier)
        default:
            return nil
        }
    }
    
    @objc private func generalToolbarItemClicked() {
        delegate?.preferences(windowController: self, clickedPreference: Identifiers.General)
    }
    
    @objc private func creditsToolbarItemClicked() {
        delegate?.preferences(windowController: self, clickedPreference: Identifiers.Credits)
    }
    
    @objc private func tipToolbarItemClicked() {
        delegate?.preferences(windowController: self, clickedPreference: Identifiers.Tip)
    }
    
}
