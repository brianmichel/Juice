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
        static let General = NSToolbarItem.Identifier(rawValue: "Preferences-General")
        static let Credits = NSToolbarItem.Identifier(rawValue: "Preferences-Credits")
        static let Tip = NSToolbarItem.Identifier(rawValue: "Preferences-Tip")
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
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "PreferencesWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.floatingWindow)))
        
        toolbar.selectedItemIdentifier = Identifiers.General
        generalToolbarItemClicked()
    }
    
    func customToolbarItem(itemForItemIdentifier itemIdentifier: String, label: String, paletteLabel: String, toolTip: String, target: AnyObject, itemContent: NSImage?, action: Selector?, menu: NSMenu?) -> NSToolbarItem? {
        
        let toolbarItem = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: itemIdentifier))
        
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
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [Identifiers.General,
                NSToolbarItem.Identifier.flexibleSpace,
                Identifiers.Tip]
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [Identifiers.General,
                Identifiers.Tip]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case Identifiers.General:
            return customToolbarItem(itemForItemIdentifier: Identifiers.General.rawValue,
                                     label: NSLocalizedString("General", comment: "General"),
                                     paletteLabel: NSLocalizedString("General", comment: "General"),
                                     toolTip: NSLocalizedString("General Settings", comment: "General Settings"),
                                     target: self,
                                     itemContent: NSImage(named: NSImage.Name(rawValue: "General Icon")),
                                     action: #selector(generalToolbarItemClicked),
                                     menu: nil)
        case Identifiers.Credits:
            return customToolbarItem(itemForItemIdentifier: Identifiers.Credits.rawValue,
                                     label: NSLocalizedString("Credits", comment: "Credits"),
                                     paletteLabel: NSLocalizedString("Credits", comment: "Credits"),
                                     toolTip: NSLocalizedString("Credits for this app", comment: "Credits for this app"),
                                     target: self,
                                     itemContent: NSImage(named: NSImage.Name(rawValue: "Credits Icon")),
                                     action: #selector(creditsToolbarItemClicked),
                                     menu: nil)
        case Identifiers.Tip:
            return customToolbarItem(itemForItemIdentifier: Identifiers.Tip.rawValue,
                                     label: NSLocalizedString("About", comment: "About"),
                                     paletteLabel: NSLocalizedString("About", comment: "About"),
                                     toolTip: NSLocalizedString("Version Information", comment: "Version Information"),
                                     target: self,
                                     itemContent: NSImage(named: NSImage.Name(rawValue: "Tip Icon")),
                                     action: #selector(tipToolbarItemClicked),
                                     menu: nil)
        case NSToolbarItem.Identifier.flexibleSpace:
            return NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier.flexibleSpace)
        default:
            return nil
        }
    }
    
    @objc private func generalToolbarItemClicked() {
        delegate?.preferences(windowController: self, clickedPreference: Identifiers.General.rawValue)
    }
    
    @objc private func creditsToolbarItemClicked() {
        delegate?.preferences(windowController: self, clickedPreference: Identifiers.Credits.rawValue)
    }
    
    @objc private func tipToolbarItemClicked() {
        delegate?.preferences(windowController: self, clickedPreference: Identifiers.Tip.rawValue)
    }
    
}
