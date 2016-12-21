//
//  GeneralPreferencesViewController.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Cocoa
import RxSwift

extension StartOnLaunchController {
    static func juiceStartOnLaunchController() -> StartOnLaunchController {
        return StartOnLaunchController(bundleIdentifier: "com.bsm.macos.JuiceHelper")
    }
}


class GeneralPreferencesViewController: NSViewController {
    private let preferences = PreferencesStorage.shared
    
    private lazy var scalesChangeObservable: Observable<[ChargeScaleDisplay]> = {
        return self.preferences.scales.asObservable()
    }()
    
    private let disposableBag = DisposeBag()
    private let startOnLaunchController = StartOnLaunchController.juiceStartOnLaunchController()

    @IBOutlet weak var statusBarStylePopUp: NSPopUpButton!
    @IBOutlet weak var addNewScaleButton: NSButton!
    @IBOutlet weak var triggerRescanButton: NSButton!
    @IBOutlet weak var scalesFoundLabel: NSTextField!
    @IBOutlet weak var launchOnLoginButton: NSButton!
    
    override var nibName: String? {
        return "GeneralPreferencesViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStylePopUp.target = self
        statusBarStylePopUp.action = #selector(statusBarStyleChanged)
        launchOnLoginButton.target = self
        launchOnLoginButton.action = #selector(toggleStartOnLaunchButton)
        
        updatePreferencePopUp(for: preferences.scales.value)
        
        scalesChangeObservable.subscribe { (event) in
            switch event {
            case .next(let scales):
                self.updatePreferencePopUp(for: scales)
            default:
                return
            }
        }.addDisposableTo(disposableBag)
        
        launchOnLoginButton.state = startOnLaunchController.startsOnLaunch ? NSOnState : NSOffState
    }
    
    @objc private func statusBarStyleChanged() {
        let selectedScale = preferences.scales.value[statusBarStylePopUp.indexOfSelectedItem]
        preferences.set(chargeDisplayScale: selectedScale)
    }
    
    private func updatePreferencePopUp(`for` scales: [ChargeScaleDisplay]) {
        statusBarStylePopUp.removeAllItems()
        scales.forEach({ statusBarStylePopUp.addItem(withTitle: $0.title) })
        
        statusBarStylePopUp.selectItem(withTitle: preferences.chargeDisplayScale.value.title)
        
        scalesFoundLabel.stringValue = "\(scales.count) Scales Found"
    }
    
    @IBAction func addNewScale(_ sender: Any) {
        let identifier = UUID().uuidString
        let newScale = FileBackedChargeScaleDisplay.makeNewScaleTemplateScale(id: identifier)
        guard let filePath = newScale.filePath else {
            return
        }
        
        newScale.save()
        
        NSWorkspace.shared().open(filePath)
    }
    
    @IBAction func triggerRescan(_ sender: Any) {
        preferences.scanApplicationSupportForFiles()
    }
    
    @IBAction func toggleStartOnLaunchButton(_ sender: Any) {
        let isSet = launchOnLoginButton.state == NSOnState
        _ = startOnLaunchController.toggle(startOnLaunch: isSet)

    }
}
