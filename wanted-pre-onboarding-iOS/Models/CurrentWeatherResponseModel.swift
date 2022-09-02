//
//  CurrentWeatherResponseModel.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/01.
//

import Foundation

struct CurrentWeatherResponseModel: Codable {
    var timezone: String
    var current: CurrentDetail
}

struct CurrentDetail: Codable {
    var temp: Double
    var humidity: Int
    var feels_like: Double
    var pressure: Int
    var wind_speed: Double
    var weather: [WeatherDetail]
}

struct WeatherDetail: Codable {
    var icon: String
    var description: String
}
