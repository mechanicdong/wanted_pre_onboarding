//
//  RegionGeo.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/02.
//

import Foundation

struct RegionGeo {
    static let gongju: [String: Double] = [
        "lat": 36.44667,
        "lon": 127.11972
    ]
    
    static let gwangju: [String: Double] = [
        "lat": 35.15972,
        "lon": 126.85306
    ]
    
    static let gumi: [String: Double] = [
        "lat": 36.11944,
        "lon": 128.34472
    ]
    
    static let gunsan: [String: Double] = [
        "lat": 35.96833,
        "lon": 126.73722
    ]
    
    static let daegu: [String: Double] = [
        "lat": 35.87222,
        "lon": 128.60250
    ]
    
    static let daejeon: [String: Double] = [
        "lat": 36.35111,
        "lon": 127.38500
    ]
    
    static let mokpo: [String: Double] = [
        "lat": 34.81183,
        "lon": 126.39216
    ]
    
    static let busan: [String: Double] = [
        "lat": 35.17944,
        "lon": 129.07556
    ]
    
    static let seosan: [String: Double] = [
        "lat": 36.78500,
        "lon": 126.45056
    ]
    
    static let seoul: [String: Double] = [
        "lat": 37.56667,
        "lon": 126.97806
    ]
    
    static let sokcho: [String: Double] = [
        "lat": 38.20694,
        "lon": 128.59194
    ]
    
    static let suwon: [String: Double] = [
        "lat": 37.26389,
        "lon": 127.02861
    ]
    
    static let suncheon: [String: Double] = [
        "lat": 34.95583,
        "lon": 127.49028
    ]
    
    static let ulsan: [String: Double] = [
        "lat": 35.53889,
        "lon": 129.31667
    ]
    
    static let iksan: [String: Double] = [
        "lat": 35.95000,
        "lon": 126.95833
    ]
    
    static let jeonju: [String: Double] = [
        "lat": 35.82500,
        "lon": 127.15000
    ]
    
    static let jeju: [String: Double] = [
        "lat": 33.50000,
        "lon": 126.51667
    ]
    
    static let cheonan: [String: Double] = [
        "lat": 36.81528,
        "lon": 127.11389
    ]
    
    static let cheongju: [String: Double] = [
        "lat": 36.64389,
        "lon": 127.48944
    ]
    
    static let chuncheon: [String: Double] = [
        "lat": 37.88131,
        "lon": 127.72997
    ]
    
    var regionGeoArray: [[String:Double]] = [
        gongju, gwangju, gumi, gunsan, daegu,
        daejeon, mokpo, busan, seosan, seoul,
        sokcho, suwon, suncheon, ulsan, iksan,
        jeonju, jeju, cheonan, cheongju, chuncheon
    ]
    
    
}
