//
//  CustomImageView.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 11/12/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {

    private var imagePath = ""

    func loadImageUsing(_ path: String) {

        imagePath = path
        guard let url = URL(string: path) else { return }

        self.image = UIImage(named: "logo-marvel")

        if let imageFromCache = imageCache.object(forKey: path as NSString) {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            if error != nil { return }

            guard let data = data else  { return }

            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data) else { return }
                if self.imagePath == path {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: path as NSString)
            }
        }).resume()
    }
}
