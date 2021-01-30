//
//  SettingModel.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

private let kSettingModel = "kSettingModel"

enum TempUnit: String, Codable, CaseIterable {
    case metric
    case standard
    case imperial
    
    var unit: String {
        switch self {
        case .metric:
            return "°C"
        case .imperial:
            return "°F"
        case .standard:
            return "°K"
        }
    }
}

struct SettingModel: Codable {
    var unit: TempUnit = .metric
    var cnt: Int = 7
}

extension SettingModel {
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: kSettingModel)
        }
    }
    
    static func load() -> SettingModel {
        if let modelData = UserDefaults.standard.object(forKey: kSettingModel) as? Data {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(SettingModel.self, from: modelData) {
                return model
            }
        }
        return SettingModel()
    }
}
