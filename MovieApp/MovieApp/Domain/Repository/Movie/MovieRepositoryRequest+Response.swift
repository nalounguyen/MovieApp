//
//  MovieRepositoryRequest+Response.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

// MARK: - MovieRepository Request API
struct GetListMoviesRequest: ApiRequest {
    var externalUrlStr: String?
    var method: ApiMethod = .get
    var path = ""
    var parameters: [String: String] = [:]
    var body: [String: Any] = [:]
    
    init(keyword: String, type: MovieType, page: Int = 1) {
        parameters = [
            "s" : keyword,
            "type" : type.rawValue,
            "page" : "\(page)",
            "apikey" : Environment.API_KEY
        ]
    }
}

// MARK: - MovieRepository Response
struct GetListMoviesResponse: Codable {
    let movieList: [MovieModel]?
    let totalResults: String?
    let response: String

    enum CodingKeys: String, CodingKey {
        case movieList = "Search"
        case totalResults
        case response = "Response"
    }
}
