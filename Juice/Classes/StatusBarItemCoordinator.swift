//
//  StatusBarItemCoordinator.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import AppKit
import RxSwift

final class StatusBarItemCoordinator: StatusMenuItemDelegate {
    private let preferencesCoordinator = PreferencesCoordinator()
    
    private let statusBarItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    private let statusBarItemMenu = StatusMenuItem(title: "Juice")
    private let disposableBag = DisposeBag()
    private let powerSourcesObservable: Observable<[PowerSource]>
    private let powerSourceDisplayTransformer = PowerSourceDisplayTransformer()
    
    init() {
        powerSourcesObservable = Observable.create({ (observer) -> Disposable in
            let watcher = PowerSourceWatcher(callback: { (sources) in
                observer.on(.next(sources))
            })
            
            watcher.start()
            
            let disposable = Disposables.create {
                watcher.stop()
            }
            
            return disposable
        })
        
        statusBarItem.menu = statusBarItemMenu
        statusBarItemMenu.statusMenuItemDelegate = self
    }
    
    func start() {
        powerSourcesObservable.subscribe(onNext: { (sources) in
            guard let source = sources.first else {
                return
            }
            
            self.updateLabel(source: source)
        }).addDisposableTo(disposableBag)
    }
    
    private func updateLabel(source: PowerSource) {
        statusBarItem.button?.title = powerSourceDisplayTransformer.display(for: source)
        statusBarItemMenu.update(from: source)
    }
    
    //MARK: - StatusMenuItemDelegate
    
    func status(didClickPreferences menuItem: StatusMenuItem) {
        preferencesCoordinator.start()
    }
}
