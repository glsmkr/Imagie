//
//  Photo.swift
//  Imagie
//
//  Created by Julian A. Fordyce on 5/13/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let description: String?
    let urls: ImageURLs
}

struct ImageURLs: Codable {
    let thumb: String
    let small: String
}

struct SearchResults: Codable {
    let results: [Photo]
}
