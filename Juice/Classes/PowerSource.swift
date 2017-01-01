//
//  PowerSource.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import IOKit.ps
import Cocoa
enum PowerSourceState: String {
    case unknown = "Unknown"
    case offLine = "Off Line"
    case ac = "AC Power"
    case battery = "Battery Power"
    
    var displayValue: String {
        switch self {
        case .unknown:
            return NSLocalizedString("Unknown", comment: "Unknown")
        case .offLine:
            return NSLocalizedString("Off Line", comment: "Off Line")
        case .ac:
            return NSLocalizedString("Power Adapter", comment: "Power Adapter")
        case .battery:
            return NSLocalizedString("Battery", comment: "Battery")
        }
    }
}

enum PowerSourceType: String {
    case unknown = "Unknown"
    case battery = "InternalBattery"
    case ups = "UPS"
    
    var displayValue: String {
        switch self {
        case .unknown:
            return NSLocalizedString("Unknown", comment: "Unknown")
        case .battery:
            return NSLocalizedString("Battery", comment: "Battery")
        case .ups:
            return NSLocalizedString("External Power", comment: "External Power")
        }
    }
}

struct PowerSource: CustomDebugStringConvertible {
    let id: Int
    let serialNumber: String
    let name: String
    let maximumCapacity: Int
    let currentCapacity: Int
    let charging: Bool
    let present: Bool
    let state: PowerSourceState
    let type: PowerSourceType
    
    var chargedPercentage: Int {
        return Int(floor((Float(currentCapacity) / Float(maximumCapacity)) * 100))
    }
    
    init?(blob: [String: Any]) {
        guard let id = blob[kIOPSPowerSourceIDKey] as? Int,
            let serialNumber = blob[kIOPSHardwareSerialNumberKey] as? String,
            let name = blob[kIOPSNameKey] as? String,
            let maximumCapacity = blob[kIOPSMaxCapacityKey] as? Int,
            let currentCapacity = blob[kIOPSCurrentCapacityKey] as? Int,
            let charging = blob[kIOPSIsChargingKey] as? Bool,
            let present = blob[kIOPSIsPresentKey] as? Bool,
            let state = blob[kIOPSPowerSourceStateKey] as? String,
            let type = blob[kIOPSTypeKey] as? String else {
                return nil
        }
        
        self.id = id
        self.serialNumber = serialNumber
        self.name = name
        self.maximumCapacity = maximumCapacity
        self.currentCapacity = currentCapacity
        self.charging = charging
        self.present = present
        self.state = PowerSourceState(rawValue: state) ?? .unknown
        self.type = PowerSourceType(rawValue: type) ?? .unknown
    }
    
    var debugDescription: String {
        return "PowerSource - Name: \"\(name)\", ID: \(id), Serial Number: \(serialNumber), Capacity: \(currentCapacity) / \(maximumCapacity), Charging? \(charging), State: \(state)"
    }
    
}
