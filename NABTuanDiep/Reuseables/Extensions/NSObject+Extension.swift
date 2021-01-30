//
//  NSObject+Extension.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

extension NSObject {
    public static func className() -> String {
        String(describing: self)
    }
}
