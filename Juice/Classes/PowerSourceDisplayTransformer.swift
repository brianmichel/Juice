//
//  PowerSourceDisplayTransformer.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation

struct PowerSourceDisplayTransformer {
    func display(for source: PowerSource) -> String {
        var string = ""
        
        switch source.chargedPercentage {
        case 0...10:
            string = "☠️"
        case 10...20:
            string = "💀"
        case 20...30:
            string = "😡"
        case 30...40:
            string = "😠"
        case 40...50:
            string = "😟"
        case 50...60:
            string = "😳"
        case 60...70:
            string = "🙄"
        case 70...80:
            string = "😏"
        case 80...90:
            string = "☺️"
        case 90...100:
            string = "😁"
        default:
            string = "¯\\_(ツ)_/¯"
        }
        
        
        
        return string
    }
}
