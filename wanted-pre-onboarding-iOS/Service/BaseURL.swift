//
//  BaseURL.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation

struct BaseURL {
    static let apiKey = "3e38385d70e8699253a8dcedc301e1fc"
    static let exclude = "minutely,alerts,hourly"
    static var url = "https://api.openweathermap.org/data/3.0/onecall?appid=\(apiKey)&lang=kr&exclude=\(exclude)&"

//    static var imgUrl = "http://openweathermap.org/img/wn/10d@2x.png"
    static var imgUrl = "http://openweathermap.org/img/wn/"
}
