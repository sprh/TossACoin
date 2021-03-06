//
//  ImageCache.swift
//  TossACoin
//
//  Created by Софья Тимохина on 06.03.2021.
//

import Foundation
import UIKit
import Alamofire

// MARK: - Кеширование изображений.
class ImageCache {
    static let imageCache = NSCache<NSString, UIImage>()
    // Получить изображение.
    static func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        }
        
        // Если его нет, то загрузить.
        else {
            AF.request(url).responseImage { response in
                if case .success(let image) = response.result {
                    setImage(url: url, image: image)
                    completion(image)
                }
                else {
                    completion(UIImage(systemName: "dollarsign.square.fill")?.withTintColor(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)))
                }
            }
        }
    }
    
    // Закешировать изображение.
    static func setImage(url: URL, image: UIImage) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
