//
//  ImageFetcherModel.swift
//  ImageFetcherApp
//
//  Created by Amit Kumar on 09/06/20.
//  Copyright © 2020 Amit Kumar. All rights reserved.
//

import Foundation

struct ImageFetcherModel: Codable {
    var title: String
    var rows: [Rows]
    init(title: String, rows: [Rows]) {
        self.title = title
        self.rows = rows
    }
}

struct Rows: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
    init(title: String?, description: String?, imageHref: String?) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}

