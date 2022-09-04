//
//  FileManager.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/02.
//

import Foundation
import UIKit

final class CustomFileManager {
    static func getImageFromDisk(imgUrl: NSString, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let fileManager = FileManager.default
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        var filePath = URL(fileURLWithPath: path)
        //이미지 이름으로 이미지파일을 만들어서 저장
        filePath.appendPathComponent(imgUrl.lastPathComponent)
        if fileManager.fileExists(atPath: filePath.path) {
            DispatchQueue.main.async {
                guard let imageData = try? Data(contentsOf: filePath) else {
                    completion(.failure(NSError(domain: "no image in disk cache", code: 0)))
                    return
                }
                guard let image = UIImage(data: imageData) else {
                    completion(.failure(NSError(domain: "image convert Error", code: 0)))
                    return
                }
                //캐시 저장
                ImageCacheManager.shared.setObject(image.withRenderingMode(.alwaysOriginal), forKey: NSString(string: imgUrl.lastPathComponent))
                completion(.success(image))
            }
        }
        else if !fileManager.fileExists(atPath: filePath.path) {
            print("경로에 파일이 존재하지 않을 때")
            //api response
            guard let url = URL(string: imgUrl as String) else { return }
            print("이미지 요청 url: \(url)")
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: url), let newImage = UIImage(data: data) {
                    //캐시 저장
                    ImageCacheManager.shared.setObject(newImage.withRenderingMode(.alwaysOriginal), forKey: NSString(string: imgUrl.lastPathComponent))
                    print("메모리 캐시 저장 경로: \(imgUrl.lastPathComponent)")
                    fileManager.createFile(atPath: filePath.path, contents: newImage.withRenderingMode(.alwaysOriginal).pngData(), attributes: nil)
                    completion(.success(newImage))
                }
            }
            
        }
        
    }
    
    
}
