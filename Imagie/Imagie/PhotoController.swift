//
//  PhotoController.swift
//  Imagie
//
//  Created by Julian A. Fordyce on 5/13/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation

class PhotoController {
    
    private let baseURL = URL(string: "https://api.unsplash.com/search/photos")!
    private let accessKey = "a77358e5700c0836aa87552d37dc6d3485823e6ea7ed51cd6aa5370d0ad4a807"
    
    private var photos: [Photo] = []
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    func photo(at indexPath: IndexPath) -> Photo {
        return photos[indexPath.row]
    }
    
    func search(for SearchTerm: String, completion: @escaping (Error?) -> Void) {
        
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let clientIDQueryItem = URLQueryItem(name: "client_id", value: accessKey)
        let searchQueryItem = URLQueryItem(name: "query", value: SearchTerm)
        let resultCountQueryItem = URLQueryItem(name: "per_page", value: "20")
        
        components?.queryItems = [clientIDQueryItem, searchQueryItem, resultCountQueryItem]
        
        
        guard let requestURL = components?.url else {
            NSLog("Not able to construct URL")
            completion(NSError())
            return
        }
        
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Request didn't return valid data.")
                completion(NSError())
                return
            }
            // Do stuff with the results
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.photos = searchResults.results
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
                return
            }
            }.resume()
        
    }

    
    
    
    
    
    
    
    
    
}
