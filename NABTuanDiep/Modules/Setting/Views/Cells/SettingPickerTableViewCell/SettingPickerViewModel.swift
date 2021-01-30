//
//  SettingPickerViewModel.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

class SettingPickerViewModel {
    private(set) var values: [String]
    var selectedIndex: Int
    
    init(values: [String], selectedIndex: Int = 0) {
        self.values = values
        self.selectedIndex = selectedIndex
    }
    
    func update(values: [String], selectedIndex: Int = 0) {
        self.values = values
        self.selectedIndex = selectedIndex
    }
    
    func setIndex(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
}
