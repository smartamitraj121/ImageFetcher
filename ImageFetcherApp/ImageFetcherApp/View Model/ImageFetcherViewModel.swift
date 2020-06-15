//
//  ImageFetcherViewModel.swift
//  ImageFetcherApp
//
//  Created by Amit Kumar on 09/06/20.
//  Copyright © 2020 Amit Kumar. All rights reserved.
//

import UIKit
class ImageFetcherViewModel {
    var imageFetcherData: [Rows]
    var title: String
    init(model: ImageFetcherModel){
        let filterData = model.rows.filter({$0.imageHref != nil || $0.title != nil || $0.description != nil})
        self.imageFetcherData = filterData
        self.title = model.title
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView {
    var imageUrlString: String?
    public func imageFromURL(urlString: String) {
        imageUrlString = urlString
        image = nil
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect.init(x: 50, y: 50, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                activityIndicator.stopAnimating()
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                if imageToCache != nil{
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                }
                activityIndicator.removeFromSuperview()
            })
        }).resume()
    }
}
