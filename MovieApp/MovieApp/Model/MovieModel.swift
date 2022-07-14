//
//  MovieModel.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

struct MovieModel: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    var posterURL: URL? {
        return URL(string: poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        
        case imdbID
    }
}
