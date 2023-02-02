//
//  Extensions.swift
//
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getImage(from url: URL) {
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            print("Image from cache")
            self.image = cachedImage
        }
        
        downloadImage(from: url) { (data, response, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    self.image = nil
                }
            } else if let imgData = data, let image = UIImage(data: imgData) {
                ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
                print("Image from cache")
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}


class ImageCache {
    
    private init() {}
    
    static let shared = NSCache<NSString, UIImage>()
}
