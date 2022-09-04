//
//  MainWeatherResponseModel.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/04.
//

import Foundation

struct MainWeatherResponseModel: Decodable {
    var weather: [WeatherDetail]
    var main: MainWeatherDetail
    var wind: MainWindDetail
    var name: String
}

struct MainWeatherDetail: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct MainWindDetail: Decodable {
    var speed: Double
//    var deg: Int
}

