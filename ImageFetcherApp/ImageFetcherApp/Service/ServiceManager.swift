//
//  ServiceManager.swift
//  ImageFetcherApp
//
//  Created by Amit Kumar on 09/06/20.
//  Copyright © 2020 Amit Kumar. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    static let shared: APIManager = APIManager()
    override init() {}
    func getData(urlString: String, completion: @escaping(Result<ImageFetcherModel, Error>) -> ()) {
           
           guard let url = URL(string: urlString) else {
               return
           }
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let err = error {
                   completion(.failure(err))
                   return
               }
               guard let data = data else { return }
               do {
                   let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                   let imageFetcherData = try JSONDecoder().decode(ImageFetcherModel.self, from: utf8Data!)
                   completion(.success(imageFetcherData))
               } catch let jsonError {
                   completion(.failure(jsonError))
               }
           }.resume()
       }
}



