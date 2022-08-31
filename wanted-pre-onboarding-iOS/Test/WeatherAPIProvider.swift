//
//  WeatherAPIProvider.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation

class WeatherAPIProvider {
    let session: URLSession
    
    init(session: URLSessionProtocol = URLSession.shared as! URLSessionProtocol) {
        self.session = session
    }
}

protocol URLSessionProtocol: URLSession {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
