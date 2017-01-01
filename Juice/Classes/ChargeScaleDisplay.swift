//
//  ChargeScaleDisplay.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation
import Cocoa

protocol ChargeScaleDisplay {
    var title: String { get }
    var defaultDetentString: String { get }
    var detents: [Int: String] { get }
    var fileName: String { get }
    
    func displayString(`for` detent: Int) -> String
}

enum SerializableChargeScaleDisplayConstants {
    static let title = NSLocalizedString("title", comment: "title")
    static let detents = NSLocalizedString("detents", comment: "detents")
    static let defaultDetentString = NSLocalizedString("default", comment: "default")
}

protocol SerializableChargeScaleDisplay {
    init?(fileURL: URL)
    func save()
}

extension SerializableChargeScaleDisplay where Self: ChargeScaleDisplay {
    func save() {
        guard let applicationSupportDirectory = FileManager.default.applicationSupportDirectory else {
            return
        }
        
        var transformedDetents = [String: String]()
        
        detents.forEach { (key, value) in
            transformedDetents[String(key)] = value
        }
        
        let plistValues = [
            SerializableChargeScaleDisplayConstants.title: title,
            SerializableChargeScaleDisplayConstants.defaultDetentString: defaultDetentString,
            SerializableChargeScaleDisplayConstants.detents: transformedDetents
            ] as NSDictionary
        
        let completeFilePath = applicationSupportDirectory.appendingPathComponent(fileName)
        
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: plistValues, format: .xml, options: .allZeros)
            try data.write(to: completeFilePath, options: .atomicWrite)
        } catch (let error) {
            print(NSLocalizedString("Error serializing scale", comment: "Error serializing scale") + ": \(error)")
        }
    }
}
