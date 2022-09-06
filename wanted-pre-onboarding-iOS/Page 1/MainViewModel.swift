//
//  MainViewModel.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/01.
//

import Foundation
import UIKit

class MainViewModel {
    static let shared = MainViewModel()
    
    //데이터를 중복으로 불러옴을 방지하는 변수
    var dataTasks = [URLSessionDataTask](repeating: URLSessionDataTask(), count: 21)
    
    func getCurrentWeather(location: String, completion: @escaping (MainWeatherResponseModel) -> Void) {
        guard let url = URL(string: BaseURL.url.appending("&q=\(location)")),
              dataTasks.first(where: { task in
                  task.originalRequest?.url == url
              }) == nil
        else { return }
        print("변환된 URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        DispatchQueue.global().async {
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil,
                      let response = response as? HTTPURLResponse,
                      let data = data,
                      let currentWeather = try?
                        JSONDecoder().decode(MainWeatherResponseModel.self, from: data) else {
                    print("ERROR: URLSession Data Task \(error?.localizedDescription ?? "")")
                    return
                }
                switch response.statusCode {
                case (200...299):
                    completion(currentWeather)
                default:
                    print("error ---> \(String(describing: error?.localizedDescription))")
                }
            }
            dataTask.resume() //dataTask 실행
            self.dataTasks.append(dataTask) //Page 중복 읽어오기 방지
        }
        
    }
    
    func getCurrentWeatherAsync(location: String) async throws -> MainWeatherResponseModel {
        print("메인스레드에서 실행되는가?: \(Thread.isMainThread)")
        guard let url = URL(string: BaseURL.url.appending("&q=\(location)")),
              dataTasks.first(where: { task in
                  task.originalRequest?.url == url
              }) == nil
        else { throw NetworkError.invalidURLString }
            
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        let decodedWeather = try JSONDecoder().decode(MainWeatherResponseModel.self, from: data)
        return decodedWeather
    }
    
//    func getSubCellWeatherData(location: String) async throws -> SubWeatherResponseModel {
//        guard let url = URL(string: BaseURL.subDataUrl.appending("&q=\(location)")) else { throw NetworkError.invalidURLString
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard let httpResponse = response as? HTTPURLResponse,
//              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
//        let decodedSubWeather = try JSONDecoder().decode(SubWeatherResponseModel.self, from: data)
//        print("가져온 서브 데이터 가져옴")
//        return decodedSubWeather
//    }
    
    func getSubCurrentWeather(location: String, completion: @escaping (SubWeatherResponseModel) -> Void) {
        guard let url = URL(string: BaseURL.subDataUrl.appending("&q=\(location)")),
              dataTasks.first(where: { task in
                  task.originalRequest?.url == url
              }) == nil else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        DispatchQueue.global().async {
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil,
                      let response = response as? HTTPURLResponse,
                      let data = data,
                      let currentWeather = try?
                        JSONDecoder().decode(SubWeatherResponseModel.self, from: data) else {
                    print("ERROR: URLSession Data Task \(error?.localizedDescription ?? "")")
                    return
                }
                switch response.statusCode {
                case (200...299):
                    completion(currentWeather)
                default:
                    print("error ---> \(String(describing: error?.localizedDescription))")
                }
            }
            dataTask.resume() //dataTask 실행
            self.dataTasks.append(dataTask) //Page 중복 읽어오기 방지
        }
    }
    
    
    func buildQueryString(fromDictionary parameters: [String:Double]) -> String {
        var urlVars = [String]()
        for (var k, v) in parameters {
            let characters = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
            characters.removeCharacters(in: "&")
//            v = v.addingPercentEncoding(withAllowedCharacters: characters as CharacterSet)!
            k = k.addingPercentEncoding(withAllowedCharacters: characters as CharacterSet)!
            urlVars += [k + "=" + "\(v)"]
        }
        
        return (!urlVars.isEmpty ? "" : "") + urlVars.joined(separator: "&")
    }

}

enum NetworkError: Error {
    case invalidURLString
    case invalidServerResponse
}
  
