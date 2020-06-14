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
