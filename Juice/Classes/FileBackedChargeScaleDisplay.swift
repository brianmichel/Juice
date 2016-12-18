//
//  FileBackedChargeScaleDisplay.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation

struct FileBackedChargeScaleDisplay: ChargeScaleDisplay, SerializableChargeScaleDisplay {
    let title: String
    let detents: [Int: String]
    let defaultDetentString: String
    let fileName: String
    
    var filePath: URL? {
        return FileManager.default.applicationSupportDirectory?.appendingPathComponent(fileName)
    }
    
    init(title: String, detents: [Int: String], defaultDetentString: String, fileName: String) {
        self.title = title
        self.detents = detents
        self.defaultDetentString = defaultDetentString
        self.fileName = "\(fileName).plist"
    }
    
    init?(fileURL: URL) {
        guard let dictionary = NSDictionary(contentsOfFile: fileURL.path) as? [String: Any],
            let title = dictionary[SerializableChargeScaleDisplayConstants.title] as? String,
            let map = dictionary[SerializableChargeScaleDisplayConstants.detents] as? [String: String],
            let defaultString = dictionary[SerializableChargeScaleDisplayConstants.defaultDetentString] as? String else {
                return nil
        }
        
        var transformedDetents = [Int: String]()
        
        map.forEach { (key, value) in
            if let integer = Int(key) {
                transformedDetents[integer] = value
            }
        }
        
        self.title = title
        self.detents = transformedDetents
        self.defaultDetentString = defaultString
        self.fileName = fileURL.lastPathComponent
    }
    
    func displayString(for detent: Int) -> String {
        guard let string = detents[detent] else {
            return defaultDetentString
        }
        
        return string
    }
}
