//
//  ImageCacheManager.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/02.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
    
}
