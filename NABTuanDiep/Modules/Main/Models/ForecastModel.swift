//
//  ForecastModel.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

struct ForecastModel: Codable {
    var city: CityModel
    var list: [ForcastDetailModel]
}

struct CityModel: Codable {
    var id: Int
    var name: String
    var coord: CoordModel
    var country: String
    var population: Int
    var timezone: Int
}

struct CoordModel: Codable {
    var lon: Double
    var lat: Double
}

protocol ForecastData {
    var dateString: String { get }
    var averageTempString: String { get }
    var pressureString: String { get }
    var humidityString: String { get }
    var description: String { get }
}

struct ForcastDetailModel: Codable {
    var dt: Double
    var sunrise: Double
    var sunset: Double
    var temp: TempModel
    var humidity: Double
    var pressure: Int
    var weather: [WeatherModel]
    
    var timeDisplay: String {
        return ""
    }
    
    var avengerTemp: Double {
        (temp.day + temp.eve + temp.morn + temp.night) / 4
    }
    
    var description: String {
        guard let weather = weather.first else {
            return "No Data"
        }
        return weather.description
    }
    
    func avengerTempDisplay(unit: TempUnit) -> String {
        ""
    }
}

extension ForcastDetailModel: ForecastData {
    var dateString: String {
        Date(timeIntervalSince1970: dt).string()
    }
    
    var averageTempString: String {
        "\(avengerTemp)"
    }
    
    var pressureString: String {
        "\(pressure)"
    }
    
    var humidityString: String {
        "\(humidity) %"
    }
}

struct TempModel: Codable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct WeatherModel: Codable {
    var description: String
}
