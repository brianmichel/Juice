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
    
    private let scanQueue = OperationQueue()
    
    let chargeDisplayScale: Variable<ChargeScaleDisplay>
    
    let scales: Variable<[ChargeScaleDisplay]> = Variable(FileBackedChargeScaleDisplay.makeApplicationDefaults())
    
    init() {
        scanQueue.name = "com.bsm.macos.storage.scan"
        chargeDisplayScale = Variable(FileBackedChargeScaleDisplay.makeEmojiScale())
        scanApplicationSupportForFiles()
    }
    
    func set(chargeDisplayScale: ChargeScaleDisplay) {
        self.chargeDisplayScale.value = chargeDisplayScale
    }
    
    func scanApplicationSupportForFiles() {
        scanQueue.addOperation { [weak self] in
            let fileManager = FileManager()
            guard let applicationSupport = fileManager.applicationSupportDirectory else {
                return
            }
            
            do {
                let paths = try fileManager.contentsOfDirectory(atPath: applicationSupport.relativePath)
                var localScales = paths.map({ URL(fileURLWithPath: $0, relativeTo: applicationSupport) }).flatMap({ FileBackedChargeScaleDisplay(fileURL: $0) })
                localScales.append(contentsOf: FileBackedChargeScaleDisplay.makeApplicationDefaults())
                
                self?.scales.value = localScales
            } catch (let error) {
                print(NSLocalizedString("ERROR_SCAN", comment: "Error scanning application support directory") + ": \(error)")
            }
        }
    }
}
