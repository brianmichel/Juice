//
//  LowPowerCoordinator.swift
//  Juice
//
//  Created by Brian Michel on 1/2/17.
//  Copyright © 2017 Brian Michel. All rights reserved.
//

import AppKit
import RxSwift

final class LowPowerCoordinator {
    private enum Constants {
        //TODO: Could probably make this a user preference
        static let lowPowerNotificationPercentage = 10
        static let lowPowerNotificationIdentifier = "com.bsm.macos.juice.low-power-notification"
    }
    private let powerSourceObservable: Observable<[PowerSource]>
    private let notificationCenter = NSUserNotificationCenter.default
    private let disposeBag = DisposeBag()
    private var lastPowerState: PowerSourceState = .unknown
    
    private var notificationHasBeenDelivered: Bool {
        return notificationCenter.deliveredNotifications.filter({ $0.identifier == Constants.lowPowerNotificationIdentifier }).count > 0
    }
    
    init(observable: Observable<[PowerSource]>) {
        powerSourceObservable = observable
    }
    
    func start() {
        powerSourceObservable.shareReplay(1).subscribe { (event) in
            switch event {
            case .next(let sources):
                guard let source = sources.first else {
                    return
                }
                self.checkForNotificationDismissal(powerSource: source)
                self.checkForWarning(powerSource: source)
            case .error(let error):
                print("Error: \(error)")
            case .completed:
                break
            }
        }.addDisposableTo(disposeBag)
    }
    
    private func checkForNotificationDismissal(powerSource: PowerSource) {
        if lastPowerState == .battery
            && powerSource.state == .ac {
            clearDeliveredNotification()
        }
        
        lastPowerState = powerSource.state
    }
    
    private func checkForWarning(powerSource: PowerSource) {
        if powerSource.chargedPercentage <= Constants.lowPowerNotificationPercentage
            && powerSource.state == .battery
            && !notificationHasBeenDelivered {
            let userNotification = NSUserNotification()
            userNotification.title = NSLocalizedString("Low Power", comment: "Title of notification shown to user when their battery is very low.")
            userNotification.informativeText = NSLocalizedString("Your Mac will sleep soon unless plugged into a power outlet.", comment: "Body of notification shown to user when their battery is very low.")
            userNotification.hasActionButton = false
            userNotification.identifier = Constants.lowPowerNotificationIdentifier
            
            notificationCenter.deliver(userNotification)
        }
    }
    
    private func clearDeliveredNotification() {
        let userNotification = NSUserNotification()
        userNotification.identifier = Constants.lowPowerNotificationIdentifier
        notificationCenter.removeDeliveredNotification(userNotification)
    }
}
