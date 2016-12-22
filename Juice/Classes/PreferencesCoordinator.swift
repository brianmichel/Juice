//
//  PreferencesCoordinator.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import AppKit
import Cocoa

final class PreferencesCoordinator: PreferencesWindowControllerDelegate {
    
    private let windowController = PreferencesWindowController()
    
    func start() {
        windowController.delegate = self
        windowController.showWindow(self)
    }
    
    //MARK: - PreferencesWindowControllerDelegate
    
    func preferences(windowController: PreferencesWindowController, clickedPreference identifier: String) {
        switch identifier {
            
        case PreferencesWindowController.Identifiers.General:
            windowController.contentViewController = GeneralPreferencesViewController()
            windowController.window?.title = NSLocalizedString("General", comment: "General")
        case PreferencesWindowController.Identifiers.Credits:
            windowController.contentViewController = CreditsPreferencesViewController()
            windowController.window?.title = NSLocalizedString("Credits", comment: "Credits")
        case PreferencesWindowController.Identifiers.Tip:
            windowController.contentViewController = AboutPreferencesViewController()
            windowController.window?.title = NSLocalizedString("About", comment: "About")
        default:
            break
        }
    }
}
