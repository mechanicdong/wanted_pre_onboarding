//
//  SubWeatherResponseModel.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/06.
//

import Foundation

struct SubWeatherResponseModel: Decodable {
    var list: [SubWeatherListDetail]
}

struct SubWeatherListDetail: Decodable {
    var dt: Double
    var main: MainWeatherDetail
    var weather: [WeatherDetail]
}
