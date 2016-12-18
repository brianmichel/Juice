//
//  PreferencesStorage.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation
import RxSwift

final class PreferencesStorage {
    static let shared = PreferencesStorage()
    
    let chargeDisplayScale: Variable<ChargeScaleDisplay>
    
    let scales: [ChargeScaleDisplay] = FileBackedChargeScaleDisplay.makeApplicationDefaults()
    
    init() {
        chargeDisplayScale = Variable(FileBackedChargeScaleDisplay.makeEmojiScale())
    }
    
    func set(chargeDisplayScale: ChargeScaleDisplay) {
        self.chargeDisplayScale.value = chargeDisplayScale
    }
}
