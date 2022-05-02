//
//  Download.swift
//  Application
//
//  Created by Kirill Titov on 15.06.2021.
//

import UIKit
import Alamofire

let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {

    func loadImageUsingUrlString(urlString: String) {
        image = nil

        if urlString.isEmpty { return }
        
        // cache version of image
        if let imageFromCache = imageCache.object(forKey: urlString as NSString ) as? UIImage {
            self.image = imageFromCache
            return
        }

        // image into cache
        AF.download(urlString).responseData { response in
            switch response.result {
            case .success:
                guard let imageToCach = UIImage(data: response.value!) else { return }
                DispatchQueue.main.async {
                    imageCache.setObject(imageToCach, forKey: urlString as NSString)
                    self.image = imageToCach
                }
            case let .failure(error):
                print(error)
            }
        }.resume()
    }
}
