//
//  FileManager+Extensions.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation

extension FileManager {
    var applicationSupportDirectory: URL? {
        guard let appName = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String,
            let path = findOrCreate(directory: .applicationSupportDirectory, domain: .userDomainMask, pathComponent: appName) else {
            return nil
        }
        
        return URL(fileURLWithPath: path)
    }
    
    func findOrCreate(directory: FileManager.SearchPathDirectory,
                      domain: FileManager.SearchPathDomainMask,
                      pathComponent: String?) -> String? {
        
        let paths = NSSearchPathForDirectoriesInDomains(directory, domain, true)
        
        guard var firstPath = paths.first else {
            return nil
        }
        
        if let additionalComponent = pathComponent {
            let path = firstPath as NSString
            firstPath = path.appendingPathComponent(additionalComponent)
        }
        
        do {
            try createDirectory(atPath: firstPath,
                                withIntermediateDirectories: true,
                                attributes: nil)
            
            return firstPath
        } catch (_) {
            return nil
        }
    }
}
