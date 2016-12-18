//
//  PowerSource+Extensions.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation

extension PowerSource {
    var chargedDetent: Int {
        switch chargedPercentage {
        case 0...10:
            return 0
        case 10...20:
            return 1
        case 20...30:
            return 2
        case 30...40:
            return 3
        case 40...50:
            return 4
        case 50...60:
            return 5
        case 60...70:
            return 6
        case 70...80:
            return 7
        case 80...90:
            return 8
        case 90...100:
            return 9
        default:
            return 0
        }
    }
}
