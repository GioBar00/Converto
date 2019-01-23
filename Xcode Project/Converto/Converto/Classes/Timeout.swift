//
//  Timeout.swift
//  Converto
//
//  Created by Giovanni Barbiero on 23/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import Foundation

class Timeout: NSObject
{
    private var timer: Timer?
    private var callback: (() -> ())?
    
    init(_ delaySeconds: Double, _ callback: @escaping () -> ())
    {
        super.init()
        self.callback = callback
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(delaySeconds), target: self, selector: #selector(invoke), userInfo: nil, repeats: false)
    }
    
    @objc func invoke()
    {
        self.callback?()
        // Discard callback and timer.
        self.callback = nil
        self.timer = nil
    }
    
    func cancel()
    {
        self.timer?.invalidate()
        self.timer = nil
    }
}
