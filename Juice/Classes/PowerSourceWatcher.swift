//
//  PowerSourceWatcher.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation
import RxSwift

final class PowerSourceWatcher {
    private var context: Int = 0
    
    private var source: CFRunLoopSource?
    private var runLoop: CFRunLoop?
    private let callback: ([PowerSource]) -> Void
    
    init(callback: @escaping ([PowerSource]) -> Void) {
        self.callback = callback
    }
    
    func start() {
        stop()
        
        callback(sources())
        
        let context = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        source = IOPSNotificationCreateRunLoopSource({ (context) in
            guard let ctx = context else {
                return
            }
            
            let watcher = Unmanaged<PowerSourceWatcher>.fromOpaque(ctx).takeUnretainedValue()
            watcher.call(sources: watcher.sources())
        }, context).takeRetainedValue()
        
        runLoop = RunLoop.current.getCFRunLoop()
        CFRunLoopAddSource(runLoop, source, .defaultMode)
    }
    
    func stop() {
        guard let runLoop = runLoop, let source = source else {
            return
        }
        CFRunLoopRemoveSource(runLoop, source, .defaultMode)
    }
    
    private func sources() -> [PowerSource] {
        let blob = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        if let list = IOPSCopyPowerSourcesList(blob).takeRetainedValue() as? [[String: Any]] {
            return list.flatMap({ PowerSource(blob: $0)})
        }

        return []
    }
    
    private func call(sources: [PowerSource]) {
        callback(sources)
    }
    
    deinit {
        stop()
    }
}
