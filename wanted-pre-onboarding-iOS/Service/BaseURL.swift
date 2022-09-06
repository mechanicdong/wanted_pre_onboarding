//
//  BaseURL.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation

struct BaseURL {
    static let exclude = "minutely,alerts,hourly"
    static var url = "https://api.openweathermap.org/data/2.5/weather?lang=kr&appid=\(weatherAPIKey)"
    static var imgUrl = "http://openweathermap.org/img/wn/"
    static var subDataUrl = "https://api.openweathermap.org/data/2.5/forecast?appid=\(weatherAPIKey)&lang=kr&cnt=20"
}

private var weatherAPIKey: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "KeyOpenWeatherAPI", ofType: "plist") else { fatalError("Open Weather API Key 가져오기 실패!") }
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let value = plist?.object(forKey: "OpenWeatherAPIKey") as? String else {
            fatalError("KeyOpenWeatherAPI.plist에서 키값을 찾을 수 없음!")
        }
        return value
    }
}
