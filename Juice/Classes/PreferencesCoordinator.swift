//
//  PreferencesCoordinator.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import AppKit

final class PreferencesCoordinator: PreferencesWindowControllerDelegate {
    
    private let windowController = PreferencesWindowController(windowNibName: "PreferencesWindowController")
    
    func start() {
        windowController.delegate = self
        windowController.showWindow(self)
    }
    
    //MARK: - PreferencesWindowControllerDelegate
    
    func preferences(windowController: PreferencesWindowController, clickedPreference identifier: String) {
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.3
            switch identifier {
            case PreferencesWindowController.Identifiers.General:
                windowController.contentViewController = GeneralPreferencesViewController()
                windowController.window?.title = "General"
            case PreferencesWindowController.Identifiers.Credits:
                windowController.contentViewController = nil
                windowController.window?.title = "Credits"
            case PreferencesWindowController.Identifiers.Tip:
                windowController.contentViewController = nil
                windowController.window?.title = "Tip"
            default:
                break
            }
        }, completionHandler: nil)

    }
}
