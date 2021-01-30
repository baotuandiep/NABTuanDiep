//
//  MainViewModel.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

class MailViewModel {
    var model = DataBinding<ForecastModel?>(value: nil).queue(receiveQueue: .main)
    var error = DataBinding<ErrorType?>(value: nil).queue(receiveQueue: .main)
    
    private lazy var _loadDataThrottler = Throttler()
    var settingModel = SettingModel.load()
    
    var tempUnit: String {
        return settingModel.unit.unit
    }
    
    func numberItems() -> Int {
        guard let model = model.value else {
            return 0
        }
        return model.list.count
    }
    
    func data(at index: Int) -> ForcastDetailModel? {
        guard let model = model.value, model.list.count > index else { return nil }
        return model.list[index]
    }
    
    func updateSetting() {
        settingModel = SettingModel.load()
    }
    
    func clearData() {
        model.value = nil
        error.value = nil
    }
    
    func loadData(city: String) {
        _loadDataThrottler.throttle { [weak self] in
            guard let self = self else { return }
            guard city.count >= 3 else {
                return self.clearData()
            }
            APIManager.shared.loadData(type: ForecastModel.self,
                                       path: "/data/2.5/forecast/daily",
                                       queryParams: [
                "q": city,
                "cnt": self.settingModel.cnt,
                "appid": "60c6fbeb4b93ac653c492ba806fc346d",
                "units": self.settingModel.unit.rawValue
            ]) { [weak self] in
                switch $0 {
                case .success(let model):
                    self?.model.value = model
                    self?.error.value = nil
                case .error(let error):
                    self?.model.value = nil
                    self?.error.value = error
                }
            }
        }
    }
}
