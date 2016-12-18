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
    
    override var contentViewController: NSViewController? {
        get {
            return super.contentViewController
        }
        set {
            guard let window = window,
                let contentView = window.contentView,
                let value = newValue,
                let newView = newValue?.view else {
                super.contentViewController = newValue
                return
            }
            
            let preferredOrigin = window.frame.origin
            let heightDelta = newView.frame.height - contentView.frame.height
            
            value.preferredScreenOrigin = window.frame.origin
            super.contentViewController = value
            
            var windowFrame = window.frame
            windowFrame.size = NSSize(width: windowFrame.size.width, height: windowFrame.size.height + heightDelta)
            windowFrame.origin = NSPoint(x: preferredOrigin.x, y: preferredOrigin.y - heightDelta)
    
            window.setFrameOrigin(windowFrame.origin)
        }
    }
    
    override var windowNibName: String? {
        return "PreferencesWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = Int(CGWindowLevelForKey(.floatingWindow))
        
        toolbar.selectedItemIdentifier = Identifiers.General
        generalToolbarItemClicked()
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
                NSToolbarFlexibleSpaceItemIdentifier,
                Identifiers.Tip]
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return [Identifiers.General,
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
                                     label: "About",
                                     paletteLabel: "About",
                                     toolTip: "Version Information",
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
