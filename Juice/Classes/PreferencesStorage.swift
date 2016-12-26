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
    private enum Constants {
        static let PreferredScaleKey = "PreferredScaleKey"
    }

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
        setPreferredScale(scale: chargeDisplayScale)
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

                let preferredScaleTitle = UserDefaults.standard.string(forKey: Constants.PreferredScaleKey)

                if let title = preferredScaleTitle,
                    let scale = localScales.filter({ $0.title == title }).first {
                    self?.chargeDisplayScale.value = scale
                }
            } catch (let error) {
                print("Error scanning application support directory: \(error)")
            }
        }
    }

    private func setPreferredScale(scale: ChargeScaleDisplay) {
        UserDefaults.standard.set(scale.title, forKey: Constants.PreferredScaleKey)
    }
}
