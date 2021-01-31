//
//  DataBinding.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

class DataBinding<T> {
    
    typealias Handler = (T) -> Void
    private var handler: Handler?
    private var receiveQueue: DispatchQueue? = nil

    var value: T {
        didSet {
            if let receiveQueue = receiveQueue {
                receiveQueue.async { [weak self] in
                    guard let self = self else { return }
                    self.handler?(self.value)
                }
            } else {
                self.handler?(self.value)
            }
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func queue(receiveQueue: DispatchQueue) -> DataBinding<T> {
        self.receiveQueue = receiveQueue
        return self
    }
    
    func bind(isNow: Bool = true, hdl: @escaping Handler) {
        handler = hdl
        if isNow { handler?(value) }
    }
}
