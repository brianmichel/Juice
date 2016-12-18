//
//  ApplicationCoordinator.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: NSObject {
    private let statusBarItemCoordinator = StatusBarItemCoordinator()
    
    override init() {
        super.init()
        statusBarItemCoordinator.start()
        
        let detents = [
            1: "huh one",
            2: "lol two",
            3: "huh three",
            4: "sdf four",
            5: "sfijsoidfj",
            6: "sixsixsix",
            7: "sevennn",
            8: "eighthttt",
            9: "ninnininine",
            10: "full house"
        ]
        let scale = FileBackedChargeScaleDisplay(title: "Test Emoji Faces",
                                                 detents: detents,
                                                 defaultDetentString: "who knows",
                                                 fileName: "test-emoji")
        
        scale.save()
    }
}
