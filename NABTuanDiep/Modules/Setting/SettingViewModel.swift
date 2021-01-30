//
//  SettingViewModel.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

class SettingViewModel {
    var showSettingIndices = Set<Int>()
    var settingModel = SettingModel.load()
    
    var cntArray: [String] {
        var array: [String] = []
        for i in 1...14 {
            array.append("\(i)")
        }
        return array
    }
    
    var unitArray: [String] {
        TempUnit.allCases.map { $0.rawValue }
    }
    
    var cntIndex: Int {
        cntArray.firstIndex(of: "\(settingModel.cnt + 1)") ?? 7
    }
    
    var tempUnitIndex: Int {
        TempUnit.allCases.firstIndex(of: settingModel.unit) ?? 0
    }
    
    init() {
        settingModel = SettingModel()
    }
    
    func array(index: Int) -> [String] {
        index == 0 ? unitArray : cntArray
    }
    
    func value(index: Int) -> String {
        if index == 0 {
            return settingModel.unit.rawValue
        } else {
            return "\(settingModel.cnt)"
        }
    }
    
    func selectedIndex(index: Int) -> Int {
        index == 0 ? tempUnitIndex : cntIndex
    }

    func updateIndex(index: Int, value: Int) {
        if index == 0 {
            settingModel.unit = TempUnit.allCases[value]
        } else {
            settingModel.cnt = value + 1
        }
        settingModel.save()
    }
}
