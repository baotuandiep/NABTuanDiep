//
//  Throttler.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

class Throttler {

    // MARK: - Private Constants
    private let _queue = DispatchQueue.global(qos: .background)

    // MARK: - Private Variables
    private var _job = DispatchWorkItem(block: { })
    private var _maxInterval = 0.5
    private var _previousRun = Date()

    // MARK: - Life Cycle Override
    convenience init(seconds: Double) {
        self.init()
        _maxInterval = seconds
    }

    // MARK: - Public Function
    func throttle(block: @escaping () -> Void) {
        _job.cancel()
        _job = DispatchWorkItem { [weak self] in
            self?._previousRun = Date()
            block()
        }
        let delay = Date().timeIntervalSince(_previousRun).rounded() > _maxInterval ? 0 : _maxInterval
        _queue.asyncAfter(deadline: .now() + delay, execute: _job)
    }
}
